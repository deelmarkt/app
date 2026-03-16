# E03 — Payments, Escrow & Ledger

> **Priority:** P0 — Critical | **Phase:** 0–1 (MVP) | **Est. Duration:** 7 weeks

---

## Overview

Mollie Connect integration with iDEAL, escrow payment flow, double-entry accounting ledger (PSD2), webhook idempotency via Upstash Redis, and reconciliation. This is the financial backbone of the platform.

**Two non-retrofittable items (must be built from Day 1):**
1. Mollie webhook idempotency (Upstash Redis)
2. Double-entry escrow ledger (PostgreSQL append-only)

---

## User Stories

### Buyer
- As a buyer, I can pay via iDEAL (default) with pre-filled bank info
- As a buyer, I see a clear order summary: item price + platform fee + shipping
- As a buyer, I see an escrow timeline: pay → held → shipped → confirm → released
- As a buyer, I can flag issues within 48 hours of delivery (escrow extended)

### Seller
- As a seller, funds are auto-released after buyer confirmation or 48-hour window
- As a seller, I receive payout minus 2.5% commission + shipping costs
- As a seller, I can track my earnings and payout history

---

## Technical Scope

### Mollie Connect Integration (4 weeks)
- iDEAL payment flow (flat €0.32 per transaction) — **MVP: iDEAL only**
- Split payments: buyer → escrow → seller + platform
- 90-day escrow hold capability
- WebView integration (no official Flutter SDK)

### Webhook Idempotency (1 week)
- Upstash Redis NX atomic check-and-set (free tier)
- 24-hour idempotency key TTL
- Exponential backoff retry: 1s → 2s → 4s → 8s → DLQ
- DLQ → PagerDuty SEV-1 alert on 5th failure
- HMAC-SHA256 webhook signature verification

### Double-Entry Escrow Ledger (2 weeks)
- Append-only PostgreSQL `ledger_entries` table (see ARCHITECTURE.md §Double-Entry Escrow Ledger for schema)
- Row-Level Security: no UPDATE or DELETE policies
- Idempotency key per ledger entry (UNIQUE constraint)
- Daily automated reconciliation: ledger count vs Mollie event count
- Any mismatch → PagerDuty SEV-1

---

## Phase 2 — Additional Payment Methods (Months 3–9)

> Priority order as defined in Master Plan §8.4:

| Method | Audience | Notes |
|:-------|:---------|:------|
| Bancontact | Belgian cross-border users | Mollie supports natively; add when .eu traffic grows |
| PayPal | Expat community | High perceived trust; needed for international users |
| Apple Pay / Google Pay | Mobile-first users | Reduces checkout friction significantly |
| Credit / Debit cards | International buyers | Enables non-Dutch payment methods |
| BNPL (Klarna / Afterpay) | Phase 2 buyers | Invoice/instalment; relevant for higher-value items |

**Phase 2 User Stories:**
- As a Belgian buyer, I can pay with Bancontact
- As an expat buyer, I can pay via PayPal or credit card
- As a mobile user, I can pay with Apple Pay or Google Pay in one tap
- As a buyer purchasing a higher-value item, I can choose Buy Now Pay Later (Phase 2)

---

## Acceptance Criteria

- [ ] iDEAL payment completes end-to-end
- [ ] Escrow holds funds until delivery confirmed or 48-hour timeout
- [ ] Double-entry ledger records every financial event immutably
- [ ] Webhook idempotency prevents duplicate payment processing
- [ ] DLQ alerts fire on persistent webhook failures
- [ ] Daily reconciliation job runs and reports status
- [ ] Split payment correctly distributes: seller payout + platform commission
- [ ] ≥70% test coverage (critical: 100% on payment paths)

---

## Dependencies

- **E02** (User Auth) — buyer/seller must be authenticated
- **E05** (Shipping) — delivery confirmation triggers escrow release
- Mollie Connect merchant account
