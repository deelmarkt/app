/**
 * Webhook Dead Letter Queue (DLQ) Processor (B-19)
 *
 * Retries failed/unprocessed webhook events with exponential backoff.
 * After 5 failed attempts, sends PagerDuty SEV-1 alert.
 *
 * Retry schedule: 1s → 2s → 4s → 8s → DLQ (PagerDuty SEV-1)
 *
 * Designed to run on a schedule (every 5 minutes via pg_cron or external).
 *
 * Reference: docs/epics/E03-payments-escrow.md §Webhook Idempotency
 */

import "@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "jsr:@supabase/supabase-js@2";

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

const MAX_ATTEMPTS = 5;
const BACKOFF_BASE_MS = 1000; // 1s, 2s, 4s, 8s, 16s

// ---------------------------------------------------------------------------
// PagerDuty SEV-1 alert
// ---------------------------------------------------------------------------

async function triggerSev1Alert(
  routingKey: string,
  event: {
    id: string;
    mollie_id: string;
    attempts: number;
    last_error: string | null;
    created_at: string;
  }
): Promise<void> {
  const response = await fetch("https://events.pagerduty.com/v2/enqueue", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      routing_key: routingKey,
      event_action: "trigger",
      dedup_key: `dlq:${event.mollie_id}`,
      payload: {
        summary: `[DeelMarkt] SEV-1: Webhook DLQ — ${event.mollie_id} failed ${event.attempts} times`,
        source: "webhook-dlq",
        severity: "critical",
        component: "mollie-webhook",
        custom_details: {
          mollie_id: event.mollie_id,
          attempts: event.attempts,
          last_error: event.last_error,
          first_seen: event.created_at,
          action_required:
            "Manual investigation required. Check Mollie dashboard for payment status " +
            "and reconcile with ledger_entries table.",
        },
      },
    }),
  });

  if (!response.ok) {
    console.error(
      `[webhook-dlq] PagerDuty alert failed: ${response.status} ${await response.text()}`
    );
  } else {
    console.log(`[webhook-dlq] SEV-1 alert sent for ${event.mollie_id}`);
  }
}

// ---------------------------------------------------------------------------
// Retry a single webhook event
// ---------------------------------------------------------------------------

async function retryWebhookEvent(
  supabaseUrl: string,
  serviceRoleKey: string,
  event: { id: string; mollie_id: string; payload: Record<string, unknown>; attempts: number }
): Promise<{ success: boolean; error?: string }> {
  try {
    // Call the mollie-webhook function internally
    const response = await fetch(`${supabaseUrl}/functions/v1/mollie-webhook`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        // No HMAC header — internal retry, signature already verified on first attempt
        "x-dlq-retry": "true",
      },
      body: JSON.stringify({ id: event.mollie_id }),
    });

    if (response.ok) {
      return { success: true };
    }

    const text = await response.text();
    return { success: false, error: `HTTP ${response.status}: ${text}` };
  } catch (error) {
    return { success: false, error: (error as Error).message };
  }
}

// ---------------------------------------------------------------------------
// Main handler
// ---------------------------------------------------------------------------

Deno.serve(async (req: Request): Promise<Response> => {
  if (req.method !== "POST" && req.method !== "GET") {
    return new Response("Method not allowed", { status: 405 });
  }

  const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
  const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
  const supabase = createClient(supabaseUrl, serviceRoleKey);
  const pagerdutyKey = Deno.env.get("PAGERDUTY_ROUTING_KEY");

  try {
    // Fetch unprocessed events, oldest first
    const { data: failedEvents, error } = await supabase
      .from("mollie_webhook_events")
      .select("id, mollie_id, payload, attempts, last_error, created_at")
      .eq("processed", false)
      .lt("attempts", MAX_ATTEMPTS)
      .order("created_at", { ascending: true })
      .limit(20);

    if (error) {
      throw new Error(`Failed to fetch DLQ events: ${error.message}`);
    }

    // Fetch events that have exhausted retries (for alerting)
    const { data: dlqEvents } = await supabase
      .from("mollie_webhook_events")
      .select("id, mollie_id, attempts, last_error, created_at")
      .eq("processed", false)
      .gte("attempts", MAX_ATTEMPTS)
      .order("created_at", { ascending: true })
      .limit(20);

    const results = {
      retried: 0,
      succeeded: 0,
      failed: 0,
      alerted: 0,
      timestamp: new Date().toISOString(),
    };

    // Retry eligible events with exponential backoff
    for (const event of failedEvents ?? []) {
      // Check if enough time has elapsed for backoff
      const backoffMs = BACKOFF_BASE_MS * Math.pow(2, event.attempts);
      const lastAttemptTime = new Date(event.created_at).getTime();
      const now = Date.now();

      if (now - lastAttemptTime < backoffMs) {
        continue; // Not ready for retry yet
      }

      results.retried++;

      const { success, error: retryError } = await retryWebhookEvent(
        supabaseUrl,
        serviceRoleKey,
        event
      );

      if (success) {
        results.succeeded++;
        await supabase
          .from("mollie_webhook_events")
          .update({
            processed: true,
            processed_at: new Date().toISOString(),
            attempts: event.attempts + 1,
          })
          .eq("id", event.id);
      } else {
        results.failed++;
        await supabase
          .from("mollie_webhook_events")
          .update({
            attempts: event.attempts + 1,
            last_error: retryError ?? "Unknown error",
          })
          .eq("id", event.id);

        // If this was the 5th attempt, it will be picked up as DLQ next run
        if (event.attempts + 1 >= MAX_ATTEMPTS && pagerdutyKey) {
          await triggerSev1Alert(pagerdutyKey, {
            ...event,
            attempts: event.attempts + 1,
            last_error: retryError ?? event.last_error,
          });
          results.alerted++;
        }
      }
    }

    // Alert on any events that already exceeded max attempts
    for (const event of dlqEvents ?? []) {
      if (pagerdutyKey) {
        await triggerSev1Alert(pagerdutyKey, event);
        results.alerted++;
      }
    }

    const status = results.failed > 0 || (dlqEvents?.length ?? 0) > 0 ? "degraded" : "ok";

    console.log(
      `[webhook-dlq] ${status}: retried=${results.retried} succeeded=${results.succeeded} ` +
        `failed=${results.failed} alerted=${results.alerted} dlq_pending=${dlqEvents?.length ?? 0}`
    );

    return new Response(JSON.stringify({ status, ...results }, null, 2), {
      status: 200,
      headers: { "Content-Type": "application/json" },
    });
  } catch (error) {
    console.error(`[webhook-dlq] Error: ${(error as Error).message}`);
    return new Response(
      JSON.stringify({ status: "error", message: (error as Error).message }),
      { status: 500, headers: { "Content-Type": "application/json" } }
    );
  }
});
