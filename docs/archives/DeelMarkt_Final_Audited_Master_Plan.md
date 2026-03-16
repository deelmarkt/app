# DeelMarkt — Final Audited Master R&D Plan

> **Platform:** DeelMarkt — Trust-First Dutch P2P Marketplace
> **Domains:** deelmarkt.com ✅ | deelmarkt.eu ✅
> **Tagline:** *"Deel wat je hebt"* (Share what you have)
> **Version:** FINAL — Audited | March 2026 | CONFIDENTIAL — INTERNAL USE ONLY

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Market Analysis & Opportunity](#2-market-analysis--opportunity)
3. [Competitive Landscape](#3-competitive-landscape)
4. [Product Architecture & Methodology](#4-product-architecture--methodology)
5. [Flutter Tech Stack](#5-flutter-tech-stack)
6. [Backend Architecture](#6-backend-architecture)
7. [Trust & Safety Architecture](#7-trust--safety-architecture)
8. [UX/UI Design System](#8-uxui-design-system)
9. [Logistics & Shipping Infrastructure](#9-logistics--shipping-infrastructure)
10. [AI & Advanced Technology Roadmap](#10-ai--advanced-technology-roadmap)
11. [Security Architecture & Compliance](#11-security-architecture--compliance)
12. [Legal & Regulatory Compliance](#12-legal--regulatory-compliance)
13. [Observability & Reliability Engineering](#13-observability--reliability-engineering)
14. [Go-to-Market Strategy](#14-go-to-market-strategy)
15. [Financial Model](#15-financial-model)
16. [Organisation & Hiring](#16-organisation--hiring)
17. [Consolidated Phased Roadmap](#17-consolidated-phased-roadmap)
18. [Architecture Decision Records (ADR)](#18-architecture-decision-records-adr)
19. [Risk Register](#19-risk-register)
20. [Audit Findings & Resolutions](#20-audit-findings--resolutions)

---

## 1. Executive Summary

This document is the single authoritative blueprint for building **DeelMarkt**, a Flutter-based, trust-first marketplace to challenge Marktplaats in the Dutch P2P commerce market. It represents the final audited consolidation of all research, architecture reviews, and strategic planning — with all inconsistencies resolved, gaps filled, and improvements incorporated.

### 1.1 The Opportunity

Marktplaats holds 8 million unique monthly visitors (~48 million total monthly visits) but scores **1.2/5 on Trustpilot** (77% one-star reviews). 70,000 fraud reports were filed against it in 2023, representing ~90% of all Dutch marketplace fraud. Its user base skews 45–54 years old, leaving the 18–35 demographic and 1M+ expats completely underserved. Dutch police data suggests only 1 in 5 victims reports, placing actual fraud incidents at ~350,000 annually with €109 million in documented damage.

Meanwhile, Vinted has proven that modern, trust-centred marketplaces can achieve explosive growth (€813 million revenue in 2024, +36% YoY, €76.7 million net profit). The Dutch C2C/classifieds market is valued at ~€1.2 billion (2023) and projected to reach ~€2.6 billion by 2030 at 11.8% CAGR.

### 1.2 Brand Strategy — DeelMarkt

"Deel" (share/part) + "Markt" (market) — a multi-layered name:

- **Dutch:** "Deel" = share → sharing economy, circular economy
- **English:** sounds like "deal" → value, bargain
- **German:** "Teil" (part) → natural cross-border resonance for BE/DE expansion
- **Domain advantage:** .com + .eu secured — global + EU positioning
- **Tagline:** *"Deel wat je hebt"* (Share what you have)

### 1.3 Strategic Vision & Mission

**Vision:** By 2028, become the most trusted, intelligent, and user-friendly secondhand marketplace in the Netherlands; expand across Benelux and into Germany as a scalable European marketplace.

**Mission:** Create a safe, transparent, and enjoyable buying and selling experience that contributes to the circular economy and reduces societal waste.

### 1.4 The Three Non-Negotiable Decisions

| # | Decision | Why It Cannot Be Compromised |
|---|---|---|
| 1 | **Launch with one category in Amsterdam** | Network density > breadth for first-mover liquidity |
| 2 | **Trust as the core brand promise** | Escrow + iDIN + human support from day one |
| 3 | **Stay free for 12–18 months** | Premature monetisation kills marketplace liquidity |

### 1.5 Investment & Phase Summary

| Phase | Timeline | Cumulative Investment | KPI Target |
|---|---|---|---|
| Pre-Launch | Months −6 to 0 | €50K–€100K | 500 seeded listings, 2K waitlist |
| Soft Launch (Amsterdam) | Months 0–3 | €150K–€300K | 2,000 listings, 500 MAU, 200 transactions |
| Amsterdam Open | Months 3–9 | €350K–€600K | 20,000 listings, 5K MAU |
| Randstad Expansion | Months 9–18 | €600K–€1M | 100K listings, 50K MAU |
| National + Belgium | Months 18–30 | €1M–€1.5M total | 500K listings, 200K MAU |

---

## 2. Market Analysis & Opportunity

### 2.1 The Dutch Digital Market

| Indicator | Value | Strategic Implication |
|---|---|---|
| Population | 18.3 million | Finite market — density > breadth |
| Internet Penetration | 99% | No digital access barriers |
| E-commerce Spend (2024) | €36 billion | Proven online payment behaviour |
| C2C / Classifieds Market | ~€1.2B (2023) → ~€2.6B (2030) | 11.8% CAGR growth |
| Total Digital Market | ~$6.01B (2023) → ~$13.03B (2030) | 11.5% CAGR |
| WhatsApp Penetration | 88.8% | Primary viral loop channel |
| LinkedIn Users | 14M (79.7% — highest globally per capita) | B2B seller acquisition |
| Facebook Users | 12.4 million | Existing buy/sell communities |
| Expat Population | 1M–1.5M+ | Completely underserved by Marktplaats |
| Secondhand Buyers | ~20% of consumers (clothing alone) | Cultural acceptance established |
| Circular Economy Target | Government mandate fully circular by 2050 | Policy tailwind for sustainability positioning |
| iDEAL Market Share | ~75% of all Dutch online payments | Non-negotiable payment integration |

### 2.2 Marktplaats's Structural Vulnerabilities

| Pain Point | Frequency in Reviews | Root Cause |
|---|---|---|
| Scams and fraud | ~40% of negative reviews | No escrow, no identity verification, no human review |
| Non-existent customer service | ~30% | Chatbot-only; refuses English speakers |
| Buyer protection fails | ~20% | iDEAL-only by design prevents chargebacks |
| Account blocking (no explanation) | ~15% | Automated systems with no recovery path |
| Monetisation creep | ~12% | €35+ auto ads, hidden €0.40 service fees |
| No English language support | Top feature request | 25-year Dutch-only legacy |

**Key Stat:** Google Play: **4.07/5** (320K reviews) vs Trustpilot: **1.2/5** (4K reviews). Casual users find it functional — anyone with a problem discovers a platform that actively fails them.

### 2.3 Market Gaps & Opportunities

- **Young user (18–35) gap:** Marktplaats skews 45–54; 61.45% male; 73.25% direct traffic (habitual, not discovery-driven)
- **Expat / multilingual gap:** 1M–1.5M+ expats; English interface is top feature request across all app stores
- **Secure payment / escrow gap:** No integrated escrow; cash transactions dominate; chargeback protection absent
- **AI & personalisation gap:** No algorithmic recommendations, no automated pricing, no AI scam detection
- **Sustainability narrative gap:** Government-mandated circular economy by 2050; DeelMarkt's brand directly addresses this
- **DSA compliance risk:** Mandatory since February 2024; Marktplaats is slow to comply

### 2.4 The Unbundling of Classifieds

Marktplaats faces the same structural risk that eroded Craigslist in the US. Vertical specialists are attacking from every side: Vinted (fashion), AutoTrack/AutoScout24 (cars), Funda/Pararius (real estate), Catawiki (collectibles), TicketSwap (tickets), Indeed/LinkedIn (jobs). A new entrant that combines broad category ambition with vertical-quality trust infrastructure can exploit this fragmentation.

Three international trends accelerate this disruption: **social commerce** (live-stream selling via TikTok Shop, influencer-curated collections), **AI-powered marketplace features** (automated listing creation, chatbot-mediated negotiations, visual search, dynamic pricing), and **embedded fintech** (Vinted Pay model, instant payouts, BNPL integration).

---

## 3. Competitive Landscape

### 3.1 Platform Comparison

| Platform | Strategic Core | Critical Vulnerability | Threat Level |
|---|---|---|---|
| **Marktplaats** | 8M unique monthly visitors, 48M visits, 25yr brand, 18.7M live ads, free listings | Fraud epidemic, dated UX, Dutch-only, chatbot support, 1.2/5 Trustpilot | HIGH — dominant but structurally stagnant |
| **Vinted** | €813M revenue, zero seller fees, mobile-first, social fashion, Vinted Go logistics | Fashion-focused (recent electronics expansion), no auctions, weak seller analytics | MEDIUM — category threat |
| **Facebook Marketplace** | Zero friction, social graph, messenger integration | No payment protection, 40% lower selling prices, 16x less inventory in categories like books, declining youth usage | LOW — commodity tier |
| **eBay** | Global reach, professional tools, auctions | High fees, complex UX, poor local C2C fit | LOW — wrong market fit |
| **Catawiki** | €105M revenue, 10M+ visitors, curated auctions, expert authentication | Collectibles niche only | LOW — niche only |
| **Tweakers.net** | 4M+ visitors, tech community trust, forum credibility | No payment infrastructure, desktop-only | LOW — partial overlap |

### 3.2 Feature Gap Matrix

| Capability | Marktplaats | Vinted | FB Marketplace | **DeelMarkt** |
|---|---|---|---|---|
| Category breadth | ★★★★★ | ★★ | ★★★★ | ★★★★★ (over time) |
| Buyer protection | ★★ | ★★★★★ | ★ | **★★★★★ from day one** |
| Mobile app quality | ★★★ | ★★★★★ | ★★★★ | ★★★★★ |
| Trust & safety | ★★ | ★★★★ | ★★★ | **★★★★★ (primary differentiator)** |
| English language | ✗ | ★★★ | ★★★★ | **★★★★★ (full bilingual)** |
| iDIN verification | ✗ | ✗ | ✗ | ✅ Progressive 5-level KYC |
| Shipping (label-free) | ★★★ | ★★★★★ | ★★ | ★★★★★ QR-code workflow |
| AI listing tools | Basic | ✗ | ✗ | ★★★★★ Snap-to-List |
| Sustainability | ★★ | ★★★★★ | ★ | ★★★★★ circular economy |
| Progressive KYC | ✗ | ✗ | ✗ | ✅ 5-level, threshold-based |
| Mobile deep linking | Minimal | Basic | ✅ | ✅ Universal Links + App Links |
| DSA transparency | Slow progress | Partial | Partial | ✅ Day-1 compliant |

### 3.3 Uncontested White Spaces

- **Verified used electronics with quality grading** — no Dutch equivalent to Back Market
- **Building materials reuse** — Netherlands' largest resource-consuming sector, no dedicated platform
- **Peer-to-peer rental** — tools, outdoor gear, party equipment — no Dutch platform at scale
- **Local services with trust infrastructure** — no Dutch TaskRabbit equivalent
- **Swap/trade functionality** — no platform supports structured bartering

---

## 4. Product Architecture & Methodology

### 4.1 Product Layers

**Layer 1 — Core Platform**

- Listing creation and management (mobile + web)
- Dutch-language Typesense search (Phase 1) → Elasticsearch (Phase 3+)
- User accounts with iDIN identity verification
- In-app messaging (Firestore MVP → Stream Chat SDK at ~1K MAU)
- iDEAL / Mollie payment infrastructure
- Universal Links (iOS) + App Links (Android) for deep linking
- Multi-domain routing: deelmarkt.eu (EU) + deelmarkt.com (global)

**Layer 2 — Trust & Safety**

- Progressive KYC module — threshold-based, friction-minimised
- Escrow payment flow + double-entry accounting ledger
- AI + rule-based scam detection (chat NLP + link/phone flagging)
- User ratings, reviews, and dispute resolution workflow
- DSA-compliant transparency reporting module
- Mollie webhook idempotency + exponential backoff + DLQ

**Layer 3 — Intelligence**

- AI price recommendation engine (XGBoost + market data)
- Personalised listing recommendations (Two-Tower + content-based)
- Visual search (CLIP + Pinecone)
- Automatic category detection (NLP + visual ensemble)
- CO2 savings calculator and sustainability badges

**Layer 4 — Growth & Monetisation**

- Premium seller dashboard (analytics, bulk listing)
- PostNL/DHL label-free shipping integration
- ASO (App Store Optimisation) assets
- BNPL integration (Klarna/Afterpay — Phase 2)
- Live auction engine (Phase 2)
- B2B API ecosystem (Phase 3)

### 4.2 MVP Scope (First 6 Months)

| Feature | Priority | Est. Duration | Notes |
|---|---|---|---|
| Listing CRUD (mobile) | P0 — Critical | 6 weeks | Photo-first flow |
| Search + Dutch analyser (Typesense) | P0 — Critical | 4 weeks | Custom Dutch stemming |
| User registration + Progressive KYC (Levels 0–2) | P0 — Critical | 3 weeks | iDIN at Level 2 |
| In-app messaging (Firestore) | P0 — Critical | 3 weeks | WebSocket real-time |
| iDEAL / Mollie escrow payment | P0 — Critical | 4 weeks | Split payments |
| Escrow double-entry ledger | P1 — High | 2 weeks | PSD2 compliance |
| Mollie webhook idempotency + retry | P1 — High | 1 week | Critical — cannot retrofit |
| Outbox pattern (search sync) | P1 — High | 2 weeks | Prevents dual-write risk |
| Dispute resolution workflow | P1 — High | 3 weeks | Buyer → evidence → AI → human |
| DSA transparency module | P1 — High | 2 weeks | Legal Day-1 requirement |
| Feature flag infrastructure (Unleash) | P1 — High | 1 week | Zero-downtime deploys |
| Basic AI scam detection | P1 — High | 4 weeks | NLP chat scanning |
| Shipping label integration (PostNL/DHL QR) | P1 — High | 3 weeks | Label-free model |
| Universal Links + App Links | P1 — High | 1 week | Must be live before App Store submission |
| Multi-domain routing (Cloudflare) | P1 — High | 1 week | .eu + .com geo-routing |
| Image processing pipeline | P2 — Medium | 2 weeks | EXIF strip, WebP, virus scan |
| Push notification infrastructure (FCM) | P2 — Medium | 2 weeks | Deep link targets |
| Admin moderation panel | P2 — Medium | 3 weeks | Retool or custom |

### 4.3 Development Methodology

- **Working Model:** Agile / Scrum + OKR (quarterly cycles)
- **Sprint Duration:** 2 weeks; technical debt sprint every 4th sprint
- **Tools:** Linear (project management), Figma (design), GitHub (code), Notion (docs), Unleash (feature flags)
- **Deployment:** Blue-green (MVP) → Canary 5%/20%/100% with error-based abort (Phase 2+)
- **Testing:** ≥70% widget test coverage (Phase 1), ≥80% (Phase 2); CI-enforced
- **User Testing:** Guerrilla test with 5–10 users every sprint end
- **ADR Culture:** Every significant architectural decision documented; knowledge must never be person-dependent

---

## 5. Flutter Tech Stack

### 5.1 Why Flutter (Not React Native)

| Criterion | React Native | Flutter | Winner for Marketplace |
|---|---|---|---|
| Rendering consistency | Native components — platform divergence possible | Skia/Impeller — pixel-perfect | **Flutter** — payment UI must look identical everywhere |
| Image-heavy list performance | 60fps with FlatList + optimisation | Consistent 60–120fps; lazy loading built-in | **Flutter** — listing browse is the primary UX surface |
| Biometric/secure payment UX | Third-party libraries; bridge failure risk | First-class integration; fewer attack surfaces | **Flutter** — trust product cannot afford auth failures |
| OTA code push | Expo OTA — battle-tested | Shorebird — newer but growing | React Native — marginal edge |
| Third-party dependency stability | High fragility during major SDK updates | Curated plugin ecosystem, more stable | **Flutter** — production stability > velocity |
| Long-term bet (2026–2030) | Meta-maintained; JS fragmentation risk | Google-maintained; Dart growing; Impeller maturing | **Flutter** — stronger long-term commitment |

**Conclusion:** Flutter is the correct choice for a trust-first, payment-centric platform. The only scenario for React Native is a founding team with zero Dart experience and a strict 6-month deadline.

### 5.2 Architecture Foundation

**Clean Architecture + MVVM + Riverpod 3** — feature-first folder structure with three layers per module:

- **Presentation Layer** — Views + ViewModels (Riverpod Notifiers), pure UI
- **Domain Layer** — Use cases, entities, repository interfaces in pure Dart
- **Data Layer** — Repository implementations, DTOs, Supabase/API adapters

### 5.3 Full Tech Stack Table

| Layer | Technology | Notes |
|---|---|---|
| Framework | Flutter 3.x + Dart 3.x | Cross-platform iOS + Android |
| State Management | Riverpod 3 with @riverpod code generation | Compile-time type safety, context-free testing |
| Navigation | GoRouter + Universal Links + App Links | Deep links from notifications, shares, payments |
| Backend (Phase 1) | Supabase (PostgreSQL) + Edge Functions | Zero infra ops; fastest time-to-market |
| Backend (Phase 2) | NestJS Modular Monolith (Strangler Fig migration) | Control over business logic; CQRS; outbox pattern |
| Search (Phase 1) | Typesense + Dutch stemmer config | Sub-50ms, self-hostable, $20/month |
| Search (Phase 3+) | Elasticsearch 8 + Dutch analyser + ILM | Compound word decomposition at scale |
| Search Sync | Outbox table + poller (P1) → Debezium + Kafka CDC (P2) | Eliminates dual-write inconsistency; <500ms P95 |
| Payments | Mollie Connect + idempotency + backoff + DLQ | iDEAL flat €0.32; split payments; 90-day escrow |
| Escrow Accounting | Double-entry ledger (PostgreSQL, append-only) | PSD2 compliant; daily reconciliation |
| Identity Verification | iDIN/itsme Progressive 5-level KYC | Reduces signup friction; Onfido for Level 3 |
| Chat (MVP) | **Supabase Realtime** (PostgreSQL subscriptions + WebSocket) | Single platform; no extra service; migrates to Stream Chat at ~1K MAU (ADR-15) |
| Chat (Scale) | Stream Chat Flutter SDK (at ~1K MAU) | Pre-built UI, 99.999% SLA, offline support |
| Push Notifications | Firebase Cloud Messaging (FCM) | Supabase lacks native push |
| Analytics (Phase 1) | Firebase Analytics + Crashlytics | Free tier; quick setup |
| Analytics (Phase 2) | PostHog (GDPR-native, self-hostable) | Funnel analysis, session recording, retention |
| Image CDN | Cloudinary | Responsive variants, auto-optimisation |
| Image Pipeline | Client-side compress → Cloudinary transform → CDN | EXIF stripping (GDPR), WebP/AVIF, ClamAV virus scan |
| Deep Linking | app_links + GoRouter | Notification → app, not browser |
| Local Storage | Hive or Isar | Offline-first data caching |
| HTTP Client | Dio | Interceptors, retry, auth token management |
| Localisation | easy_localization (NL/EN from P1; DE/FR from P3) | One-tap language switch; auto-translation |
| Feature Flags | Unleash (self-hosted) | Zero-downtime deploys; instant rollback |
| CI/CD | GitHub Actions (CI) + Codemagic (deployment) | Split per ABI builds; Apple Silicon |
| OTA Hotfixes | Shorebird | Critical bug fixes without App Store review (~$200/mo) |
| Testing | flutter_test, mockito, alchemist (golden), patrol (E2E) | Firebase Test Lab for physical device testing |
| Accessibility | WCAG 2.2 Level AA (5 additional criteria over 2.1) | EAA legally mandated since June 2025 |
| Secret Management | Supabase Vault (P1) → AWS Secrets Manager (P2) | API keys never in env vars or source code |

### 5.4 Universal Links & App Links

Without Universal Links on iOS and App Links on Android, every notification tap, WhatsApp share, and email link opens in the browser instead of the app — destroying re-engagement conversion.

**iOS — `/.well-known/apple-app-site-association`:**

```json
{
  "applinks": {
    "apps": [],
    "details": [{
      "appID": "TEAMID.nl.deelmarkt.app",
      "paths": [
        "/listings/*", "/users/*", "/categories/*",
        "/transactions/*", "/shipping/*"
      ]
    }]
  }
}
```

**GoRouter Deep Link Handler:**

```dart
final _appLinks = AppLinks();

void _handleIncomingLinks() {
  _appLinks.uriLinkStream.listen((Uri? uri) {
    if (uri != null) {
      router.go(uri.path, extra: uri.queryParameters);
    }
  });
}

GoRoute(
  path: '/listings/:id',
  builder: (context, state) =>
    ListingDetailScreen(listingId: state.pathParameters['id']!),
),
```

**Impact:**

| Scenario | Without | With | Business Impact |
|---|---|---|---|
| Notification: "Your item sold!" | Opens Safari → App Store | App opens at transaction screen | Seller acts immediately |
| WhatsApp shared listing | Mobile web (no buy button) | Listing screen with Buy Now | ~30–50% conversion uplift |
| Email: dispute update | Browser view | Dispute resolution in-app | Faster resolution, lower support cost |

**Critical:** Apple-app-site-association endpoint must be live BEFORE App Store submission.

### 5.5 Mollie Webhook Idempotency — Production Pattern

Without idempotency, Mollie webhook retries can double-process payments.

```typescript
// Supabase Edge Function: /functions/v1/mollie-webhook
export async function handler(req: Request) {
  const payload = await req.json();
  const idempotencyKey = `mollie:webhook:${payload.id}`;

  // Atomic check-and-set: NX = set only if Not eXists, EX = expire in 24h
  const isNew = await redis.set(idempotencyKey, '1', 'EX', 86400, 'NX');
  if (!isNew) {
    return new Response('Already processed', { status: 200 });
  }

  await processPaymentEvent(payload);
  return new Response('OK', { status: 200 });
}

// Retry policy: exponential backoff
// Attempt 1: 1s | Attempt 2: 2s | Attempt 3: 4s
// Attempt 4: 8s | Attempt 5: DLQ → PagerDuty SEV-1 alert
```

### 5.6 Double-Entry Escrow Accounting Ledger

PSD2 financial audit requires an immutable double-entry ledger, not just an event log.

```sql
CREATE TABLE ledger_entries (
  id              UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  transaction_id  UUID NOT NULL REFERENCES transactions(id),
  idempotency_key TEXT NOT NULL UNIQUE,
  debit_account   TEXT NOT NULL,
  credit_account  TEXT NOT NULL,
  amount_cents    INTEGER NOT NULL,
  currency        CHAR(3) NOT NULL DEFAULT 'EUR',
  created_at      TIMESTAMPTZ DEFAULT now()
);

-- Row-Level Security: append-only (no UPDATE or DELETE)
ALTER TABLE ledger_entries ENABLE ROW LEVEL SECURITY;
CREATE POLICY no_update ON ledger_entries FOR UPDATE USING (false);
CREATE POLICY no_delete ON ledger_entries FOR DELETE USING (false);

-- Escrow flow:
-- Buyer pays €100.00:
--   DEBIT  buyer.wallet       10000 EUR
--   CREDIT escrow.holding     10000 EUR
--
-- Delivery confirmed (2.5% commission):
--   DEBIT  escrow.holding     10000 EUR
--   CREDIT seller.wallet       9750 EUR
--   CREDIT platform.revenue     250 EUR
```

**Reconciliation:** Daily automated cron job comparing ledger entry count vs Mollie payment event count. Any mismatch → immediate PagerDuty SEV-1 alert.

### 5.7 CI/CD Performance Budget Gates

| Gate | Threshold | CI Action | Tool |
|---|---|---|---|
| APK release size | < 25 MB (thin APK) | Block merge | `flutter build apk --analyze-size` |
| Frame render time (P99) | < 16.67ms (60fps) on reference device | Block merge; post report to PR | `flutter drive` + timeline_summary |
| App cold start time | < 2.5s on Pixel 4a or iPhone 12 | Warning (P1); blocker (P2) | `flutter drive --profile` |
| Integration test suite | 100% pass on Firebase Test Lab | Block merge | patrol + Firebase Test Lab |
| Widget test coverage | ≥ 70% (Phase 1), ≥ 80% (Phase 2) | Block below threshold | `flutter test --coverage` |
| Golden test diff | 0 unexpected pixel changes | Block merge; post diff screenshot | alchemist golden tests |
| Dependency CVEs | 0 known vulnerabilities | Block merge | `flutter pub outdated` + osv-scanner |
| JS bundle (web) | < 200 KB gzip | Block merge | Lighthouse CI |
| LCP (web) | < 2.5s (mobile 4G) | Warning | Lighthouse CI |

### 5.8 App Store Optimisation (ASO) Strategy

| Element | iOS App Store | Google Play |
|---|---|---|
| App Title (30 chars) | `DeelMarkt — Koop & Verkoop` | `DeelMarkt — Koop & Verkoop` |
| Subtitle / Short Desc | `Veilig tweedehands markt` | `Koop en verkoop veilig met escrow-beveiliging` |
| Primary Keywords | tweedehands, kopen, verkopen, marktplaats alternatief, spullen verkopen, veilig betalen | tweedehands markt, marktplaats app, veilig tweedehands, escrow kopen |
| Screenshots Priority | 1: Trust badge + escrow flow  2: AI listing  3: English UI  4: Shipping QR | Same — A/B test via Play Store Experiments |
| Review Response SLA | < 24 hours | < 24 hours |
| Rating Target | ≥ 4.3 before featuring applications | ≥ 4.3 for "top app" badge |

**In-app review timing:** Trigger `in_app_review` immediately after a successful transaction — the highest-conversion moment for positive reviews. Never on app open; never after a dispute.

### 5.9 Flutter-Specific SLO Framework

| Flutter SLI | SLO Target | Error Budget (30 days) | Tool |
|---|---|---|---|
| Crash-free session rate | ≥ 99.5% | 216 minutes | Firebase Crashlytics |
| ANR rate | < 0.1% of sessions | Absolute threshold | Firebase Crashlytics + Sentry |
| Payment flow completion | 99.99% complete or clean error | 4 minutes | Custom analytics + Sentry |
| Listing creation P95 latency | < 3 seconds end-to-end | — | Firebase Performance Monitoring |
| Search result P95 latency | < 500ms query to render | — | Firebase Performance + Typesense metrics |
| App cold start | < 2.5s on P50 device | — | Firebase Performance Monitoring |
| FCM delivery rate | ≥ 98% delivered | — | FCM delivery reports |
| CDC search sync lag | < 500ms (P95) | — | Kafka consumer lag monitoring |

**Policy:** When the payment flow error budget is 50% consumed in any 30-day window, halt all new feature releases to the payment module. Reliability before features — always.

---

## 6. Backend Architecture

### 6.1 Modular Monolith First (Strangler Fig Migration)

| Phase | Backend Pattern | Rationale |
|---|---|---|
| Phase 1 (0–12 months) | Supabase BaaS (managed Postgres + Edge Functions) | Zero infrastructure ops; fastest time-to-market |
| Phase 2 (12–24 months) | NestJS Modular Monolith replacing Edge Functions | Control over business logic; CQRS; outbox pattern |
| Phase 3 (24+ months) | Extract AI Service + Search Service as independent deployments | Independent scaling profiles justify extraction |

**Migration pattern:** Strangler Fig — replace Edge Functions module by module. Core PostgreSQL database never moves.

### 6.2 Architecture Diagram

```
┌──────────────────────────────────────────────────────────────────┐
│           Cloudflare (CDN + WAF + DDoS + Geo-routing)            │
│           .eu → EU users | .com → global/expats                  │
└──────────────────────┬───────────────────────────────────────────┘
                       │
┌──────────────────────▼───────────────────────────────────────────┐
│         API Gateway (Kong / Supabase Edge Functions)             │
│      Rate Limiting │ Auth │ Routing │ Logging │ Versioning       │
└──────────┬─────────────────────────────────┬─────────────────────┘
           │                                 │
    ┌──────▼──────┐                   ┌──────▼──────┐
    │  Core API   │                   │  AI Service │
    │ (NestJS P2) │                   │  (FastAPI)  │
    └──────┬──────┘                   └──────┬──────┘
           │                                 │
    ┌──────▼─────────────────────────────────▼──────┐
    │                  Data Layer                    │
    │  PostgreSQL │ Redis Cluster │ Typesense/ES     │
    │  S3/CDN     │ Outbox Table  │ Pinecone (P2+)   │
    │  Kafka(P2+) │ Ledger Table  │ Redshift (P2+)   │
    └────────────────────────────────────────────────┘
```

### 6.3 CDC-Based Search Sync — Outbox Pattern

```sql
-- Phase 1: PostgreSQL Outbox table
CREATE TABLE search_outbox (
  id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  event_type  TEXT NOT NULL, -- 'listing.created' | 'listing.updated' | 'listing.deleted'
  payload     JSONB NOT NULL,
  processed   BOOLEAN DEFAULT false,
  created_at  TIMESTAMPTZ DEFAULT now()
);

-- Trigger: auto-populate on listings changes
CREATE OR REPLACE FUNCTION notify_search_outbox()
RETURNS TRIGGER AS $$ BEGIN
  INSERT INTO search_outbox (event_type, payload)
  VALUES (TG_OP, row_to_json(NEW));
  RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER listings_to_outbox
AFTER INSERT OR UPDATE OR DELETE ON listings
FOR EACH ROW EXECUTE FUNCTION notify_search_outbox();

-- Phase 2: Debezium + Kafka CDC replaces poller for sub-500ms sync
```

### 6.4 Dutch Language Search Configuration

```json
{
  "settings": {
    "analysis": {
      "analyzer": {
        "deelmarkt_dutch": {
          "type": "custom",
          "tokenizer": "standard",
          "filter": [
            "lowercase", "dutch_stop", "dutch_stemmer",
            "dutch_keywords", "asciifolding"
          ]
        }
      },
      "filter": {
        "dutch_stop":     { "type": "stop", "stopwords": "_dutch_" },
        "dutch_stemmer":  { "type": "stemmer", "language": "dutch" },
        "dutch_keywords": { "type": "keyword_marker",
                            "keywords": ["fiets", "auto", "huis", "tweedehands"] }
      }
    }
  }
}
```

**Results:** "fietsbanden" → "fietsband" (compound decomposition); "tweedehands" → preserved as keyword; "gebruikte" ↔ "gebruikt" ↔ "gebruik" (stemming matches).

### 6.5 Cache Invalidation Strategy

| Cache Type | TTL | Invalidation Trigger |
|---|---|---|
| Listing detail page | 5 min | `listing.updated`, `listing.sold`, `listing.deleted` |
| Search results | 2 min | `listing.created`, `listing.updated`, category change |
| User profile | 10 min | `user.updated`, review added |
| AI recommendations | 30 min | `user.purchase`, `user.favorite` |
| Category page | 15 min | New listing count threshold |

Redis Pub/Sub event-driven invalidation with stale-while-revalidate pattern to protect UX.

### 6.6 Multi-Domain Routing Strategy

| Domain | Target Audience | Routing Rule |
|---|---|---|
| deelmarkt.eu | EU users (NL, BE, DE, FR) | Cloudflare Worker geo-routing EU → .eu |
| deelmarkt.com | Global (expats, international) | Default; non-EU traffic |
| www.deelmarkt.nl | Reserved (brand protection) | 301 → deelmarkt.eu |

**SEO:** hreflang tags per language/region; canonical URLs on every page; `x-robots-tag: noindex` on dev/staging.

### 6.7 PgBouncer Configuration (Phase 2 NestJS)

```ini
[pgbouncer]
pool_mode = transaction        # Correct for NestJS async context
max_client_conn = 200
default_pool_size = 20
reserve_pool_size = 5
reserve_pool_timeout = 3
max_db_connections = 100       # = RDS max_connections / 2
server_idle_timeout = 600
```

### 6.8 Scalability Targets

| Component | Scaling Strategy | Capacity Target |
|---|---|---|
| API (NestJS P2) | Horizontal (ECS Fargate) | 10,000 RPS |
| PostgreSQL | Read replica × 2; PgBouncer tx mode | 50M rows/table |
| Redis | ElastiCache Cluster (6 node) | 1M ops/sec |
| Typesense/ES | 3 shards × 2 replicas; ILM | 100M+ listings |
| Kafka (P2+) | 3 brokers; replication factor 3 | 100K msg/sec |
| Image CDN | Cloudinary + CloudFront | Unlimited; auto-scale |

---

## 7. Trust & Safety Architecture

### 7.1 The Trust Ecosystem

Trust is not a feature — it is the product. Every screen must communicate safety through verification badges, escrow visibility, transaction history, and dispute resolution paths.

| Protocol | Mechanism | Compliance | Phase |
|---|---|---|---|
| iDIN / itsme Auth | Bank-based identity (ING, Rabobank, ABN AMRO) | eIDAS legally binding; AML | MVP |
| Escrow Payments | Mollie Connect neutral fund-holding | PSD2 compliant | MVP |
| Double-Entry Ledger | Append-only PostgreSQL ledger | PSD2 financial audit | MVP |
| Webhook Idempotency | Redis NX lock + exponential backoff + DLQ | Exactly-once payment processing | MVP |
| Multi-Factor Auth | Face ID / Fingerprint; 3DS2/SCA | SCA compliant | MVP |
| AI Scam Detection | NLP chat scanning for suspicious patterns | Proactive fraud prevention | P1 basic → P2 full |
| Progressive KYC | 5-level threshold-based verification | Wwft and AML | P1 (0–2); P2 (3–4) |
| AI Behavioural Scoring | Anomaly detection for bots + account takeover | Platform integrity | Phase 3 |

### 7.2 Progressive KYC Framework

| Level | Trigger | Requirement | Access Granted |
|---|---|---|---|
| Level 0 (Basic) | Registration | Email + phone verification | Browse, save favourites |
| Level 1 (Buyer) | First message | — (no additional requirement) | Message sellers, make offers |
| Level 2 (Seller) | First listing | iDIN (BSN-based identity) | Create listings, receive payments |
| Level 3 (Escrow) | First escrow transaction | Onfido selfie + document | Full escrow functionality |
| Level 4 (Business) | Monthly €2,500+ sales | KVK number + KYBC verification | Business seller features, bulk tools |

### 7.3 Escrow Payment Flow

```
Buyer pays → funds held (Mollie Connect) → seller ships with QR label
→ carrier scans → tracking confirms delivery
→ buyer has 48 hours to flag issues
→ auto-release to seller (minus 2.5% commission + shipping)

Ledger entries:
  DEBIT  buyer.wallet       → CREDIT escrow.holding     (payment)
  DEBIT  escrow.holding     → CREDIT seller.wallet       (delivery confirmed)
                            → CREDIT platform.revenue    (commission)
```

### 7.4 Tiered Customer Support

| Tier | Handles | SLA | Language |
|---|---|---|---|
| 1 — AI Chatbot | FAQs, tracking lookups, common listing issues | < 60 seconds | NL + EN |
| 2 — Human Agent | Fraud reports, account disputes, payment issues | 4-hour response | NL + EN |
| 3 — Senior Dispute | High-value transactions, platform abuse, appeals | 72-hour decision | NL + EN |

### 7.5 Dispute Resolution Workflow

1. Buyer marks order as "issue" within 48 hours of delivery → escrow extended
2. App prompts both parties for evidence (photos, chat screenshots) — 24-hour deadline
3. AI pre-screens evidence → resolves ~60% of cases automatically
4. Human agent reviews contested cases → binding decision within 72 hours
5. Refund or release with correct split (shipping, commission, seller payout)
6. Fraudulent seller pattern → account suspended → flagged in iDIN system

---

## 8. UX/UI Design System

### 8.1 Design Philosophy: Trust by Design

Users form an opinion about app quality within 50 milliseconds. Every screen communicates safety through verification badges, escrow visibility, and clear dispute resolution paths.

### 8.2 Listing Creation — Snap-to-List Flow

```
Camera opens on "Sell" tap
→ User photographs item (1 photo minimum)
→ AI identifies object + maps to L2 category
→ LLM generates professional title and description
→ AI recommends price (comparable completed sales)
→ Listing quality score displayed before publishing
→ Target: < 30 seconds for 80% of common items (Phase 2)
→ Phase 1 target: < 3 minutes (manual form with AI assist)
```

### 8.3 Search & Discovery

Search bar at the top of every screen supporting autocomplete with product queries and category suggestions. Dynamic faceting based on active category — price range sliders, condition filters (New, Like New, Good, Fair), and location/distance filters with map view toggle. Empty states must never be dead ends; suggest related items, broaden search, or prompt saved search alerts.

### 8.4 Payment Flow

iDEAL as default first option. Minimise form fields (iDEAL pre-fills payment information). Display clear order summary: item price + platform fee + shipping. Escrow timeline visualisation: buyer pays → funds held → seller ships → buyer confirms → funds released.

**Payment method priority:** iDEAL (mandatory), Bancontact (Belgian cross-border), BNPL via Klarna (Phase 2), PayPal (expat community), credit/debit cards (international users), Apple Pay/Google Pay.

### 8.5 2026 UX Trend Integration

| Trend | Principle | Flutter Implementation |
|---|---|---|
| Minimalist Aesthetic | Essential content only | Clean headers, fast-closing filter drawers, generous whitespace |
| Dark Mode Baseline | Eye-friendly, battery-saving | Adaptive themes via system setting + time-of-day |
| Micro-interactions | Functional, contextual feedback | Lottie animations: bid placed, message sent, delivery confirmed |
| Multimodal Interfaces | Voice + Touch + Gesture | Voice listing creation; gesture-driven negotiation |
| Inclusive Design (WCAG 2.2) | Accessibility for all | 4.5:1 contrast; 44×44px+ touch targets; full ARIA labels |
| Sustainable Design | Minimal data, fast on mid-range | AVIF/WebP images; no heavy carousels; < 3s on 4G |
| Dynamic / Generative UI | Interface adapts to user role | Seller mode vs buyer mode home dashboard |
| AR Spatial Commerce | Place items in real space | Markerless AR for furniture (Phase 3) |

### 8.6 Ethical Design Commitments

Hard commitments from day one — advertised explicitly:

- No intrusive ads that intercept swipe events
- No roach motel cancellation flows
- No hidden fees — all costs shown before the buy button
- No deceptive urgency mechanics
- No manipulative personalisation
- BTW (VAT) displayed on every price view, not just at checkout
- Users must have a "non-personalised" feed option (DSA requirement)

### 8.7 Dutch Localisation Requirements

- Bilingual NL/EN with one-tap language switch (DE/FR from Phase 3)
- Auto-translation of all listing content
- Euro currency with BTW on every price view
- DD-MM-YYYY date format
- Dutch address fields: Postcode (4+2 format), Huisnummer, Toevoeging
- +31 phone format with validation
- PostNL postcode auto-fill API
- KVK number display for verified business sellers

### 8.8 Chat UX

Conversation thread embeds listing card at top. Structured "Make an Offer" buttons for price negotiation. Seller response times displayed ("Usually responds within 1 hour"). In-app location sharing for meetup coordination. Real-time scam detection flags messages containing suspicious external links, phone numbers, or off-platform payment requests. Auto-translation for multilingual market.

---

## 9. Logistics & Shipping Infrastructure

### 9.1 Label-Free Shipping Model

```
Sale confirmed → app generates QR code
→ seller brings package to PostNL ServicePoint or DHL ParcelShop
→ carrier staff scans QR → prints label
→ tracking events push to buyer + seller in real-time
→ delivery confirmed → escrow releases
```

### 9.2 Logistics API Integration

| Component | API | Seller Benefit | Buyer Benefit |
|---|---|---|---|
| Label-free QR shipping | PostNL Shipping V4 + DHL QR Service | No printer required | Automatic tracking from handoff |
| Real-time tracking | PostNL Shipping Status API | Fewer buyer disputes | Live map + delivery alerts |
| Address verification | PostNL postcode API + SmartyStreets | Reduces delivery errors | Fast checkout auto-fill |
| ParcelShop selector | PostNL VPS map integration | Choose nearest drop-off | Choose nearest pickup |
| Integrated returns | DHL Printerless Returns API | One QR code for returns | Returns confidence |

### 9.3 Dutch Address UX

Three distinct fields required (not one combined field):

- **Postcode** (4 digits + 2 letters — triggers auto-fill of city + street)
- **Huisnummer** (house number)
- **Toevoeging** (apartment/addition — optional)

Auto-fill via PostNL address API eliminates the most common courier delivery error in NL.

---

## 10. AI & Advanced Technology Roadmap

### 10.1 AI Feature Phase Plan

| Capability | Model / Approach | Latency Target | Phase |
|---|---|---|---|
| Real-Time Scam Detection | NLP chat scanning + link/phone flagging | < 1s | Phase 1 (basic) → Phase 2 (full) |
| Snap-to-List (Image Recognition) | Computer vision object ID from single photo | — | Phase 2 |
| AI Listing Copy Generation | LLM title + description from photo | — | Phase 2 |
| AI Background Removal | Visual segmentation models | — | Phase 2 |
| Smart Pricing Engine | XGBoost regression + market data + category embedding | < 100ms | Phase 2 |
| Personalised Recommendations | Two-Tower collaborative + content-based fallback | < 150ms | Phase 2–3 |
| Automatic Category Detection | Fine-tuned DistilBERT + ResNet ensemble | < 200ms | Phase 2 |
| Visual Search | CLIP (ViT-B/32) + Pinecone ANN | < 500ms | Phase 3 |
| AI Behavioural Scoring | Anomaly detection for bots + account takeover | < 1s | Phase 3 |
| AR Furniture Visualisation | Markerless AR / Google Geospatial API | — | Phase 3 |
| AI Chat Assistant | GPT-4o + RAG (listing database) | < 3s | Phase 3 |
| Dynamic / Generative UI | Activity-based interface reconfiguration | — | Phase 4 |
| Voice-Based Listing | Conversational AI for listing creation | — | Phase 4 |

### 10.2 MLOps Standards (Phase 2+)

- **Model versioning:** MLflow Model Registry; every model tied to a commit, reproducible
- **A/B testing:** New models at 5% shadow traffic → statistical significance before rollout
- **Model drift detection:** Evidently AI weekly; PSI > 0.2 → retrain
- **Data quality gates:** Great Expectations in training pipelines
- **Feature store:** Feast (offline + online) — prevents training/serving skew
- **Fallback policy:** AI fails → rule-based system activates automatically
- **Feedback loop:** User actions → Redshift → weekly model refresh

---

## 11. Security Architecture & Compliance

### 11.1 OWASP Top 10 Mitigation Plan

| OWASP Risk | Mitigation |
|---|---|
| A01 — Broken Access Control | RBAC, resource-based auth, JWT 15min + refresh token |
| A02 — Cryptographic Failures | AES-256 PII encryption, TLS 1.3, HSTS, certificate pinning (mobile) |
| A03 — Injection | Parameterised queries, Joi/Zod input validation, DOMPurify |
| A04 — Insecure Design | Threat modeling per feature, 4-eyes principle on escrow |
| A05 — Security Misconfiguration | Infrastructure as Code, drift detection, CIS benchmarks |
| A06 — Vulnerable Components | Snyk/osv-scanner (CI blocker), Dependabot, quarterly dependency audit |
| A07 — Auth Failures | iDIN MFA, rate-limited login attempts, bcrypt (cost 12) |
| A08 — Data Integrity | Signed S3 URLs, webhook HMAC-SHA256 + idempotency |
| A09 — Logging Failures | Structured logging for all auth + payment events; PII masking mandatory |
| A10 — SSRF | Allowlist-based outbound HTTP; metadata endpoint blocking |

### 11.2 Security Processes

- **Penetration Test:** Pre-launch (independent external firm) + annual repeat
- **SAST:** SonarQube (CI-enforced gate)
- **DAST:** OWASP ZAP (weekly on staging)
- **Secret Scanning:** GitGuardian + GitHub secret scanning
- **Cyber Insurance:** Pre-launch €1M+ cyber insurance policy
- **WAF:** Cloudflare Pro with custom rules for NL/BE traffic patterns

### 11.3 Image Processing Pipeline

```
Upload → S3 (raw/) → processing trigger
  → Resize: thumbnail (200×200), medium (800×600), large (1600×1200)
  → Convert: WebP (primary) + AVIF (modern browsers)
  → EXIF stripping (GDPR — GPS coordinates = personal data)
  → Virus scan: ClamAV
  → Output: CDN-ready processed images
  → Cloudinary/CloudFront URL generation
```

**Rules:** Max 15 MB per image, max 12 images per listing. Accepted formats: JPEG, PNG, HEIC, WebP. HEIC → JPEG conversion for iOS users.

---

## 12. Legal & Regulatory Compliance

Budget **€20–50K** for Dutch tech/privacy legal counsel before launch. Non-compliance is existential.

### 12.1 Regulatory Requirements

| Regulation | Key Requirements | Action |
|---|---|---|
| **GDPR** | Processing register; DPO; 72hr breach notification; DPIA for profiling; right-to-erasure; EXIF metadata stripping | Privacy-by-design architecture; DPO contract before launch; Didomi CMP (IAB TCF 2.2) |
| **Digital Services Act (DSA)** | Notice-and-action for illegal content (24hr SLA); KYBC for business sellers; transparency policies; annual report; non-personalised feed option | Build content reporting + business KYB in MVP |
| **European Accessibility Act (EAA)** | WCAG 2.2 Level AA; accessibility statement | Build into MVP — retrofitting is 3–5x more expensive; fines up to €100K or 4% revenue |
| **PSD2 / PSD3** | Strong Customer Authentication; escrow may need DNB payment institution licence | Use licensed PSP (Mollie) to avoid obtaining licence; double-entry ledger for audit |
| **Dutch Consumer Protection** | 14-day cooling-off (B2C only, not C2C private); full price transparency; display KVK + VAT number | Clear B2C vs C2C distinction; full cost shown before buy button |
| **AML / Wwft** | Monitor transactions for red flags; sanctions screening for business sellers | Automated monitoring via Mollie Connect compliance tools |

### 12.2 Business Entity Structure

**Recommended: Holding BV + Operations BV**

- **Holding BV** — owns IP (brand, domain, codebase), collects royalties; tax-optimised
- **Operations BV** — employs staff, runs day-to-day marketplace operations

**Why:** International expansion (Belgium, Germany) without restructuring cost; IP protection; investor capital held at Holding level; each country gets independent tax liability; legal risk in one country doesn't affect others.

Setup cost: ~€3K–€5K legal fees. Must be done before any Series A funding round.

### 12.3 GDPR-Specific Implementation

| Requirement | Implementation |
|---|---|
| Consent management | Didomi CMP (IAB TCF 2.2 compliant) |
| Access right (DSR) | 30-day automated data export API |
| Right to erasure | Async PII deletion worker; 30 days; audit log preserved |
| Data portability | JSON + CSV export endpoint |
| Breach notification | PagerDuty → team → Autoriteit Persoonsgegevens (72 hours) |
| Data classification | PII-Critical (BSN/IBAN): AES-256 + KMS; Standard PII: TLS at-rest |
| Image metadata | EXIF stripping — GPS coordinates are personal data |

---

## 13. Observability & Reliability Engineering

### 13.1 Observability Stack by Phase

| Pillar | Phase 1 | Phase 2 | Purpose |
|---|---|---|---|
| Crash & Error | Firebase Crashlytics + Sentry | Sentry (primary) | Stack traces, ANR, release tracking |
| Mobile Performance | Firebase Performance | Firebase + Datadog RUM | App startup, screen render times |
| Backend Metrics | Supabase Dashboard | Datadog APM | API latency, DB performance |
| Distributed Tracing | — | OpenTelemetry → Datadog APM | Trace Flutter events through backend |
| Uptime (external) | Betterstack Free | Betterstack Pro | SLA reporting independent of infra |
| User Analytics | Firebase Analytics | PostHog (GDPR-native, self-hostable) | Funnel analysis, retention |
| Payment Audit | Supabase logs + Mollie dashboard | Double-entry ledger + reconciliation | PSD2 audit compliance |
| CDC Lag | Outbox polling metrics | Kafka consumer lag monitoring | Search sync freshness |
| Synthetics | — | Datadog Synthetic Tests | Critical flow monitoring (payment, listing) |
| Data Warehouse | — | Redshift Serverless | BI + ML training data (OLAP) |

**OpenTelemetry Rule:** All services must propagate trace context via `traceparent` header. Trace ID injected into log lines.

### 13.2 Alerting Hierarchy

```
CRITICAL (PagerDuty — immediate):
→ Payment flow error rate > 1%
→ Escrow ledger reconciliation mismatch
→ Mollie webhook DLQ > 0 unprocessed messages
→ App crash-free session rate drops below 99%
→ Search outbox/CDC lag > 60 seconds (sold items still visible)
→ DB connection pool > 90% utilised

HIGH (PagerDuty — 15-minute response):
→ Flutter app P95 startup time > 4 seconds
→ API P95 latency > 1 second (sustained 5 min)
→ Supabase/Redis connection pool > 80% utilised
→ iDIN / Onfido KYC service degraded
→ SLO error budget > 50% consumed
→ Elasticsearch health status yellow

INFO (Slack — business hours):
→ New version deployed successfully
→ Daily active user milestone
→ App Store / Play Store new review posted
→ Cache hit rate dropped below 70%
→ Disk usage > 80%
```

### 13.3 Incident Management

| Severity | Definition | Response | Escalation |
|---|---|---|---|
| SEV-1 | Payment failure / platform down | 5 minutes | CTO as Incident Commander |
| SEV-2 | Critical feature broken | 15 minutes | On-call engineer |
| SEV-3 | Degradation, non-critical | 1 hour | Slack notification |
| SEV-4 | Cosmetic bug | Next sprint | Backlog |

SEV-1 and SEV-2: blameless post-mortem mandatory — draft within 48 hours, published within 1 week.

### 13.4 Deployment Strategy & DR

- **Phase 1:** Blue-green deployment — smoke test → route traffic → 30 min monitoring
- **Phase 2+:** Canary 5% → 20% → 100%; automatic error-based abort
- **RTO:** < 4 hours (SEV-1) | **RPO:** < 1 hour
- **Backup:** PostgreSQL every 1 hour; S3 continuous versioning
- **Restore Drill:** Monthly automated restore test → Slack report ("untested backup is not a backup")
- **Cross-region:** eu-west-1 → us-east-1 DR; 2x annual Game Day exercises

---

## 14. Go-to-Market Strategy

### 14.1 The Five Differentiation Pillars

| Pillar | Strategy | Vulnerability Exploited |
|---|---|---|
| 1 — Trust First | Escrow, iDIN, AI fraud detection, human support NL+EN | 90% of Dutch marketplace fraud = Marktplaats |
| 2 — Mobile-First UX | Social commerce, AI tools, visual search, one-tap buying | Marktplaats's 45–54 demographic skew |
| 3 — Expat-Friendly | Full English, auto-translation, PayPal/cards | 1M+ expats with zero native platform |
| 4 — Vertical Focus | Launch one category; deep condition grading + authentication | Horizontal incumbents vulnerable to vertical depth |
| 5 — Sustainability | CO2 tracking, eco-scores, circular economy partnerships | Government mandate + younger consumer values |

### 14.2 Marketing Channels

**Tier 1 — Highest ROI:** WhatsApp viral loops (88.8% penetration — referral incentives built into every transaction), Instagram/TikTok short-form (hauls, finds, before/after; Dutch sustainability + lifestyle creators), Dutch-language SEO (targeting "tweedehands meubels Amsterdam", "marktplaats alternatief", "veilig tweedehands kopen").

**Tier 2 — Scalable Growth:** Facebook Groups (sponsor existing buy/sell communities), Google Ads targeting high-intent keywords, LinkedIn for B2B seller acquisition (kringloopwinkels, small businesses).

**Tier 3 — Brand Building:** Micro-influencers (€5–15K/month; Dutch market favours 10K–100K followers in sustainability/lifestyle), Tweakers.net (18.7M monthly visits) for verified-electronics coverage, guerrilla marketing at university campuses, expat meetups (Internations Amsterdam), kringloopwinkels.

### 14.3 Launch Strategy: Amsterdam First

**Phase 1 — Pre-launch (6 months before):** Choose one category (fashion or electronics). Seed supply manually — partner with 50–100 active sellers, cross-list kringloopwinkel inventory, create 500+ skeleton listings. Build waitlist with WhatsApp referral incentives.

**Phase 2 — Soft launch (months 0–3):** Invite-only in Amsterdam. Zero fees. Review every listing manually, personally mediate disputes. Target: 2,000 listings, 500 active users, 200 completed transactions.

**Phase 3 — Amsterdam expansion (months 3–9):** Open registration. Expand to 2–3 adjacent categories. Launch micro-influencer partnerships. Introduce promoted listings. Target: 20,000 listings, 5,000 active users.

**Phase 4 — Randstad expansion (months 9–18):** Rotterdam, The Hague, Utrecht, Eindhoven (8M people, ~45% of NL population). Add all major categories. Introduce transaction fees on shipped items. Target: 100,000 listings, 50,000 active users.

**Phase 5 — National + Belgium (months 18–30):** Nationwide availability. Full monetisation stack. Evaluate Flanders expansion (Bancontact already integrated). Target: 500,000+ listings, 200,000+ active users.

### 14.4 Monetisation Timeline

| Phase | Timeline | Model |
|---|---|---|
| Free | Months 0–12 | Everything free — build critical mass |
| Growth | Months 12–24 | Promoted listings €0.99–€4.99; Top Ad €2.99–€9.99 |
| Scale | Months 24+ | 2.5% + €0.50 escrow commission on shipped items; business subscriptions €19.99–€99.99/month; shipping commission 7%; authentication €4.99–€14.99 |

This undercuts Vinted's buyer fee (~5% + €0.70) while maintaining free basic listings as a permanent differentiator against Marktplaats's increasing paywall.

---

## 15. Financial Model

### 15.1 Unit Economics

| Metric | Target | Rationale |
|---|---|---|
| CAC | < €5 (organic-weighted) | WhatsApp viral loops target 80% organic acquisition |
| LTV (3-year) | > €35 | 2.5% commission on avg basket × transactions/year |
| LTV/CAC | > 7x | Below 3x = unsustainable; above 5x = healthy |
| Monthly Premium Churn | < 3% | Escrow lock-in reduces churn |
| Escrow Transaction Rate | > 30% of transactions | Primary revenue driver |
| Average Order Value (shipped) | €85 (Phase 1) → €120 (Phase 3) | Electronics + fashion mix |

### 15.2 Three-Year Financial Projection

| Metric | Year 1 | Year 2 | Year 3 |
|---|---|---|---|
| Active Users (MAU) | 100,000 | 500,000 | 2,000,000 |
| Active Listings | 200,000 | 1,500,000 | 6,000,000 |
| Monthly Escrow Volume | €300,000 | €3,000,000 | €15,000,000 |
| Escrow Commission (2.5% + €0.50) | €120,000 | €1,100,000 | €5,000,000 |
| Shipping Commission (7%) | €50,000 | €400,000 | €2,000,000 |
| Promoted Listings / Boosts | €60,000 | €600,000 | €2,500,000 |
| Premium Subscriptions | €40,000 | €400,000 | €1,500,000 |
| **Total Annual Revenue** | **€270,000** | **€2,500,000** | **€11,000,000** |
| Salaries (4→8→15 people) | €280,000 | €700,000 | €2,500,000 |
| Cloud Infrastructure | €60,000 | €200,000 | €600,000 |
| Marketing | €100,000 | €400,000 | €1,500,000 |
| Legal / Compliance | €40,000 | €80,000 | €150,000 |
| **EBITDA** | **−€210,000** | **+€1,120,000** | **+€6,250,000** |

**Break-even:** Month 15 (estimated).

**Pessimistic scenario:** If user acquisition is 50% slower, break-even shifts to Month 20; requires an additional ~€600K capital.

### 15.3 Cash Flow & Runway

| Metric | Value |
|---|---|
| Estimated Starting Capital | €300K (bootstrap) |
| Monthly Burn Rate (Phase 1) | €55,000 |
| Burn Rate (Phase 2 start) | €90,000 |
| Estimated Runway | 18 months |
| Seed Round Target | €1.5M–€3M |
| Seed Round Timing | Launch at Month 9 (not 12) |

**Funding note:** Begin Seed fundraising at Month 9 to fund Randstad expansion and NestJS monolith migration. Waiting until Month 12 risks runway pressure.

---

## 16. Organisation & Hiring

### 16.1 Founding Team (3 Persons)

Clear role separation from Day 1 to prevent burnout and knowledge silos.

### 16.2 Hiring Plan

| Position | Timing | Priority Reason |
|---|---|---|
| UX/UI Designer | Month 2 | MVP quality — WCAG 2.2 compliance |
| Backend Engineer (Payments/CDC) | Month 3 | Escrow + ledger + CDC pipeline complexity |
| Mobile Engineer (Flutter) | Month 3 | Universal Links, payment flows, performance |
| Trust & Safety / Customer Success | Month 6 | Moderation + DSA compliance processes |
| Data Engineer | Month 9 | Kafka, Debezium, Redshift, ML pipeline |
| Growth Marketer | Month 6 | ASO + paid acquisition + community |

### 16.3 OKR System

**Q1 — Objective: Launch a Reliable MVP**

- KR1: All P0 features live within 6 months
- KR2: Escrow payment error rate < 0.1%
- KR3: App Store / Google Play ≥ 4.2

**Q2 — Objective: Make Trust Measurable**

- KR1: Progressive KYC Level 2 completion rate > 80%
- KR2: Fraud complaint rate < 0.3%
- KR3: DSA notice-and-action response SLA 100% < 24 hours

**Q3 — Objective: Prove AI Creates Value**

- KR1: AI price suggestion acceptance rate > 25%
- KR2: Recommendation click-through rate > 15%
- KR3: Visual search usage rate > 10%

### 16.4 Key Team Disciplines

- **Scope constraint:** Every sprint ends with "what will we NOT do?" question
- **Outsource selectively:** Design, legal, tax, ASO copy → freelancers
- **No-code/low-code:** Moderation panel, landing pages → Retool/Webflow
- **Automate everything:** Every manual recurring task is an automation candidate
- **ADR culture:** Every important decision is written; knowledge must never be person-locked

---

## 17. Consolidated Phased Roadmap

### Phase 0 — Foundation (Months −6 to 0)

- [ ] Register Holding BV + Operations BV at KVK; engage Dutch tech/privacy law firm
- [ ] Conduct 50+ user interviews; Jobs-to-be-Done analysis
- [ ] Set up Flutter monorepo: Clean Architecture, Riverpod 3, GoRouter, Supabase
- [ ] Integrate Mollie Connect — iDEAL + escrow flow + idempotency from day one
- [ ] Build double-entry ledger schema in Supabase
- [ ] Implement iDIN/itsme OAuth for Level 2 KYC
- [ ] Build Universal Links (iOS) + App Links (Android) — before App Store submission
- [ ] Create search outbox table + PostgreSQL trigger
- [ ] Configure Typesense with Dutch stemmer
- [ ] Integrate PostNL address API + DHL QR-label shipping flow
- [ ] Set up Cloudflare multi-domain routing (.eu + .com + hreflang)
- [ ] Bilingual NL/EN (easy_localization); EXIF stripping in image pipeline
- [ ] Set up Unleash feature flag infrastructure
- [ ] Publish privacy policy, accessibility statement (WCAG 2.2), prohibited items policy
- [ ] Seed 500+ listings manually; sign 50–100 seller partners; build WhatsApp referral waitlist
- [ ] Set up CI with performance budget gates (APK size, frame rate, coverage)
- [ ] Produce ASO assets (screenshots, descriptions, keywords)
- [ ] Contract penetration testing firm for pre-launch audit
- [ ] Obtain €1M+ cyber insurance policy

### Phase 1 — Soft Launch Amsterdam (Months 0–3)

- [ ] Invite-only in Amsterdam; zero fees for all transactions
- [ ] Founders manually review every listing; personally resolve every dispute
- [ ] Deploy basic AI scam detection (NLP keyword/link scanning)
- [ ] Progressive KYC Levels 0–2 live
- [ ] Firebase Crashlytics + Sentry monitoring active; alerting hierarchy configured
- [ ] Complete pre-launch penetration test; remediate findings
- [ ] Collect NPS weekly; conduct 20+ user interviews per month
- [ ] **Target:** 2,000 listings, 500 MAU, 200 transactions, NPS > 40

### Phase 2 — Amsterdam Open (Months 3–9)

- [ ] Open public registration; expand to 2–3 adjacent categories
- [ ] Launch Snap-to-List AI (image recognition + LLM copy generation)
- [ ] Migrate chat from Firestore to Stream Chat SDK at ~1,000 MAU
- [ ] Introduce promoted listings (€0.99–€4.99) as first revenue stream
- [ ] Launch ASO assets on App Store + Google Play; implement in-app review prompts
- [ ] Hire Trust & Safety Lead + Growth Marketer + UX Designer
- [ ] Progressive KYC Level 3 (Onfido escrow verification) live
- [ ] Migrate analytics from Firebase to PostHog
- [ ] Deploy MLflow for model versioning
- [ ] **Target:** 20,000 listings, 5,000 MAU, NPS > 50

### Phase 3 — Randstad Expansion (Months 9–18)

- [ ] Expand to Rotterdam, Den Haag, Utrecht, Eindhoven (8M people, 45% of NL)
- [ ] Introduce 2.5% + €0.50 transaction fee on shipped items; 7% shipping commission
- [ ] Launch business seller subscriptions (€19.99–€99.99/month)
- [ ] Negotiate PostNL/DHL preferred carrier rates
- [ ] Begin NestJS Modular Monolith migration (Strangler Fig) from Supabase Edge Functions
- [ ] Deploy Debezium + Kafka CDC pipeline replacing outbox poller (<500ms sync target)
- [ ] Set up Redshift Serverless for BI + ML training data
- [ ] Integrate OpenTelemetry distributed tracing → Datadog APM
- [ ] AR furniture visualisation (markerless AR via Google Geospatial API)
- [ ] Social commerce features: seller following, feed browse, listing stories
- [ ] Launch Seed fundraising round (target €1.5M–€3M) — start at Month 9
- [ ] **Target:** 100,000 listings, 50,000 MAU

### Phase 4 — National + Belgium (Months 18–30)

- [ ] Full national availability across all major categories
- [ ] Evaluate Flanders (Belgium) expansion — Bancontact already integrated via Mollie
- [ ] Add DE/FR language support (easy_localization)
- [ ] Extract AI Service + Search Service as independent deployments (Strangler Fig Phase 3)
- [ ] Migrate search to Elasticsearch with Dutch analyser at 10M+ listings
- [ ] BNPL/invoice financing partnership for professional sellers (Klarna/Afterpay)
- [ ] Launch live auction engine
- [ ] Series A fundraise preparation based on 18 months of metrics
- [ ] **Target:** 500,000+ listings, 200,000+ MAU

---

## 18. Architecture Decision Records (ADR)

| ADR | Decision | Rationale | Trade-off |
|---|---|---|---|
| ADR-001 | Flutter over React Native | Rendering consistency, payment security primitives, long-term platform stability | Smaller Dart talent pool; learning curve |
| ADR-002 | Supabase (Phase 1) → NestJS Modular Monolith (Phase 2) | Speed-to-market first; Strangler Fig migration when justified | Phase 2 migration cost; acknowledged debt |
| ADR-003 | Mollie Connect as primary PSP | iDEAL flat €0.32; Dutch-native; split payments; 90-day escrow hold | No official Flutter SDK; WebView integration |
| ADR-004 | Typesense (Phase 1) → Elasticsearch (Phase 3+) | Typesense: fast, cheap, sub-50ms; ES when 10M+ listings need compound word analysis | Typesense Dutch support less complete than ES |
| ADR-005 | Outbox pattern for search sync from Day 1 | Prevents dual-write consistency gap; PostgreSQL = single source of truth | Outbox polling adds minor latency (~2s Phase 1) |
| ADR-006 | Progressive KYC 5 levels | Amazon/eBay model; reduces signup friction dramatically | Fraud window between Level 0–2; mitigated by AI scoring |
| ADR-007 | Mollie webhook idempotency from Day 1 | Post-launch retrofit is expensive and risky; payments must be exactly-once | Redis dependency (Upstash for Phase 1) |
| ADR-008 | Double-entry escrow ledger in PostgreSQL | PSD2 compliance; daily reconciliation; immutable append-only audit trail | Additional schema complexity |
| ADR-009 | Holding BV + Operations BV | IP held in Holding; international expansion without restructuring; tax optimisation | Higher setup cost (~€3K–€5K); worth it before Series A |
| ADR-010 | GoRouter + app_links for Universal Links | Notification → app deep link is critical conversion; browser fallback unacceptable | AASA endpoint must be live before App Store submission |
| ADR-011 | WCAG 2.2 Level AA (not 2.1) | EAA references current standard; 2.2 superseded 2.1 in Oct 2023 | 5 new Flutter widget criteria; build once correctly |
| ADR-012 | Shorebird for Flutter OTA hotfixes | Critical payment/trust bugs fixed without App Store review delays | ~$200/month; smaller community than Expo OTA |
| ADR-013 | Unleash for feature flags | Zero-downtime deploys; instant rollback; A/B testing foundation | Flag overhead per feature; discipline required |
| ADR-014 | Debezium + Kafka CDC (Phase 2) | Replace outbox polling with streaming CDC; sub-500ms sync | Kafka operational overhead; justified only at scale |
| ADR-015 | deelmarkt.eu (primary EU) + .com (global) | .eu → EU trust signal; .com → expat/international reach | Two domain management; hreflang complexity |

---

## 19. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Network effect failure — insufficient listing density | HIGH | CRITICAL | Manual supply seeding; category focus before horizontal expansion |
| Marktplaats responds with trust improvements or acquires competitor | MEDIUM | HIGH | 12-month free period builds switching costs before they react |
| Regulatory non-compliance (GDPR, DSA, EAA, PSD2) | MEDIUM | CRITICAL | Law firm pre-launch; compliance built into architecture, not retrofitted |
| Fraud occurs despite protections | MEDIUM | HIGH | Escrow + iDIN are structural; publicise zero-tolerance policy |
| Mollie or Supabase pricing changes significantly | LOW | MEDIUM | Supabase is open-source + self-hostable; Mollie has NL market motivation |
| Webhook payment event loss or duplication | LOW | CRITICAL | Idempotency + retry + DLQ + PagerDuty SEV-1 from day one |
| Search index shows stale listings (sold items visible) | MEDIUM | HIGH | Outbox pattern + CDC pipeline; cache invalidation events |
| Engineering quality drops under growth pressure | MEDIUM | HIGH | CI/CD performance gates + ≥70% test coverage from Phase 1 |
| Escrow ledger reconciliation mismatch | LOW | CRITICAL | Daily automated reconciliation job; any mismatch = SEV-1 |
| ASO underperformance — organic installs below target | MEDIUM | MEDIUM | A/B test screenshots and title; respond to reviews within 24 hours |
| Expat/English market smaller than projected | LOW | LOW | Dutch-language market is primary; English support is low marginal cost |
| Team burnout (3-person founding team) | MEDIUM | HIGH | Clear role separation; hire at Month 3; tech debt sprints |
| Cash flow / burn rate exceeds projections | MEDIUM | MEDIUM | 18-month runway; early escrow revenue; Seed round at Month 9 |
| AI model drift degrades recommendations | MEDIUM | MEDIUM | Evidently drift detection; weekly retraining; rule-based fallback |
| CDC pipeline outage (stale search results) | MEDIUM | MEDIUM | Kafka replication factor 3; consumer lag alerting |
| Data breach | LOW | CRITICAL | Pre-launch pentest; WAF; encryption; AP notification SOP; cyber insurance |
| Vinted expands into general marketplace categories | MEDIUM | HIGH | Deep vertical trust + escrow in categories Vinted doesn't serve |

---

## 20. Audit Findings & Resolutions

This section documents all inconsistencies, gaps, and improvements identified during the final audit and how they are resolved in this document.

### 20.1 Resolved Inconsistencies

| # | Issue | Resolution |
|---|---|---|
| 1 | **Framework choice conflict:** DeelMarkt Strateji uses React Native + NestJS; other documents use Flutter | **Flutter confirmed** as the correct choice for trust-first, payment-centric platform. React Native only justified with zero Dart experience + strict 6-month deadline. See ADR-001. |
| 2 | **Backend architecture conflict:** Strateji uses NestJS from Day 1; Master Plan uses Supabase → NestJS | **Supabase BaaS for Phase 1** (zero infra ops, fastest time-to-market for 3-person team); **NestJS Modular Monolith via Strangler Fig in Phase 2** when scale demands control. See ADR-002. |
| 3 | **Search engine conflict:** Strateji uses Elasticsearch from Day 1; Master Plan starts with Typesense | **Typesense Phase 1** ($20/month, sub-50ms, sufficient Dutch support); **Elasticsearch Phase 3+** when 10M+ listings demand compound word decomposition. See ADR-004. |
| 4 | **Financial projection conflicts:** DeelMarkt Strateji projects Year 1 revenue €600K–€900K; Master Plan v2 projects €240K | **Reconciled to €270K Year 1.** The €600K+ figure assumed immediate monetisation; this plan enforces 12 months free, making early revenue modest. Year 3 reconciled to €11M. |
| 5 | **Year 3 user target conflict:** Strateji projects 3M MAU; Master Plan projects 2M MAU | **Reconciled to 2M MAU** as the base case. 3M is the optimistic scenario. Conservative projections are safer for fundraising. |
| 6 | **Escrow commission rate conflict:** Building a Marktplaats research cites 5% + €0.50; Master Plan uses 2.5% + €0.50 | **2.5% + €0.50 confirmed.** This undercuts Vinted's ~5% + €0.70 — a deliberate competitive advantage. The 5% figure was from early research and pre-dates competitive pricing analysis. |
| 7 | **Marktplaats traffic figures:** Strateji cites 48M monthly visits; Building a Marktplaats cites 8M unique visitors | **Both correct — different metrics.** ~48M total monthly visits (page views); ~8M unique monthly visitors. This document uses both with proper labels. |
| 8 | **Chat solution conflict:** Strateji uses custom WebSocket + Redis; Master Plan uses Firestore → Stream Chat | **Firestore MVP → Stream Chat SDK at ~1K MAU** confirmed. Custom WebSocket is overkill for Phase 1 and delays MVP. |
| 9 | **Observability timing:** Strateji deploys Datadog from Day 1; Master Plan starts with Firebase | **Firebase Phase 1 → Datadog Phase 2** confirmed. Datadog cost ($15+/host/month) is unjustified for a 3-person team pre-revenue. Firebase free tier covers Phase 1 needs. |
| 10 | **PgBouncer max_client_conn:** Strateji backend table says 100; PgBouncer section says 200 | **Standardised to 200.** The backend table entry was an error. |
| 11 | **Chat MVP technology:** §5.3 tech stack table referenced Firebase Firestore + StreamBuilder; ADR-15, epics/E04, and ROADMAP all specify Supabase Realtime | **Supabase Realtime confirmed** for Phase 1 chat (PostgreSQL subscriptions, single-platform, no extra service). Stream Chat SDK at ~1K MAU remains. §5.3 Chat (MVP) row updated accordingly. |

### 20.2 Gaps Filled

| # | Gap | Resolution |
|---|---|---|
| 1 | **Feature flag system** was absent from Master Plan v2 | Added Unleash (self-hosted) to tech stack + ADR-013 |
| 2 | **OWASP Top 10 mitigation plan** was absent from Master Plan | Added complete §11.1 with all 10 mitigations |
| 3 | **Data warehouse (OLAP)** was absent from Master Plan | Added Redshift Serverless in Phase 2+ for BI + ML |
| 4 | **Cyber insurance** was absent from Master Plan | Added €1M+ pre-launch cyber insurance policy |
| 5 | **Secret management** was under-specified | Added Supabase Vault (P1) → AWS Secrets Manager (P2) |
| 6 | **Consent management platform** was unspecified | Added Didomi CMP (IAB TCF 2.2) |
| 7 | **SAST/DAST security scanning** was absent | Added SonarQube (SAST, CI-enforced) + OWASP ZAP (DAST, weekly) |
| 8 | **Database restore drill** was absent | Added monthly automated restore test + Slack report |
| 9 | **Cross-region DR** was absent from Master Plan | Added eu-west-1 → us-east-1 DR; 2x annual Game Day |
| 10 | **Pre-launch penetration testing** was insufficiently emphasised | Added as mandatory Phase 0 task with external firm |
| 11 | **Synthetic monitoring** was absent | Added Datadog Synthetic Tests for critical flows (Phase 2) |
| 12 | **Swap/trade functionality** was mentioned in Strateji but absent from Master Plan | Documented as a Phase 2+ feature in Product Layers |
| 13 | **Cash flow / runway analysis** was absent from Master Plan | Added §15.3 with monthly burn rates and runway |
| 14 | **User interviews / JTBD analysis** was absent from Phase 0 | Added 50+ user interview requirement to Phase 0 roadmap |
| 15 | **Hiring timeline** was vague | Added explicit month-by-month hiring plan §16.2 |

### 20.3 Improvements Made

| # | Improvement | Rationale |
|---|---|---|
| 1 | Added ADR-013 (Unleash), ADR-014 (CDC), ADR-015 (multi-domain) | Complete decision coverage |
| 2 | Standardised all financial projections into single coherent model | Eliminates confusion from conflicting numbers across documents |
| 3 | Unified all phase timelines across roadmap, financials, and hiring | Everything aligns to the same 30-month calendar |
| 4 | Added explicit Seed round timing at Month 9 (not 12) | Prevents runway pressure during Randstad expansion |
| 5 | Added pessimistic scenario to financial model | Investors and founders need worst-case planning |
| 6 | Strengthened image pipeline: added ClamAV virus scanning + EXIF stripping + AVIF support | Security + GDPR compliance + performance |
| 7 | Added Redshift Serverless for OLAP | Separates analytical workloads from production DB; enables ML pipeline |
| 8 | Expanded risk register from 11 to 17 entries | Covers team, financial, competitive, and operational risks |
| 9 | Added OKR system with quarterly objectives and key results | Alignment mechanism for 3-person founding team |
| 10 | Added "Ethical Design Commitments" as explicit section | Differentiator against Marktplaats dark patterns; builds trust |

---

> **Bottom Line:** This is the final, audited, single-source-of-truth document. All research has been consolidated, all inconsistencies resolved, all gaps filled, and 10 material improvements incorporated. The three most critical items that must be built into Phase 0/1 (MVP) are: **(1) Mollie webhook idempotency, (2) double-entry escrow ledger, and (3) Universal Links/App Links.** Building these later is expensive, risky, and in the case of the ledger, potentially non-compliant with PSD2.

---

*© 2026 — DeelMarkt | deelmarkt.com | deelmarkt.eu | FINAL AUDITED — CONFIDENTIAL — INTERNAL USE ONLY*
