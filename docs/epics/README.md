# MVP Epics

> 8 epics total: E01–E07 for Phase 0–1 (MVP); E08 for Phase 2–3.
> Start with **E07** → **E02** → **E01** → **E03**.

| Epic | Title | Priority | Phase | Duration |
|:-----|:------|:---------|:------|:---------|
| [E01](E01-listing-management.md) | Listing Management & Search | P0 | 0–1 | 10 weeks |
| [E02](E02-user-auth-kyc.md) | User Registration & Progressive KYC | P0 | 0–1 | 6 weeks |
| [E03](E03-payments-escrow.md) | Payments, Escrow & Ledger | P0 | 0–1 | 7 weeks |
| [E04](E04-messaging.md) | In-App Messaging | P0 | 0–1 | 3 weeks |
| [E05](E05-shipping-logistics.md) | Shipping & Logistics | P1 | 0–1 | 4 weeks |
| [E06](E06-trust-moderation.md) | Trust, Moderation & DSA | P1 | 0–1 | 9 weeks |
| [E07](E07-infrastructure.md) | Infrastructure, CI/CD, Deep Linking & i18n | P1 | 0 | 5 weeks |
| [E08](E08-ai-intelligence-monetisation.md) | AI, Intelligence & Monetisation | P2 | 2–3 | 16+ weeks |

## Dependency Chain

```
E07 (Infra) → E02 (Auth) → E01 (Listings) → E04 (Chat)
                          → E03 (Payments) → E05 (Shipping)
              E06 (Trust) depends on E03 + E04 + E01
              E08 (AI)    depends on ALL of E01–E07 (Phase 2 start)
```

## Execution Order & Parallelism

**Month –6 to –5 (Weeks 1–8):**
- E07 starts first (foundation; 5 weeks)
- E02 starts in parallel with E07 Week 2 (auth can scaffold while infra is provisioned)

**Month –4 to –3 (Weeks 9–16):**
- E01 + E03 run in parallel (both depend on E07 complete, E02 MVP auth)
- E06 AI scam detection starts (can build engine before E04 chat is live)

**Month –2 to 0 (Weeks 17–24):**
- E04 starts after E01 is far enough to have listings to link conversations to
- E05 starts after E03 payment flow is testable (needs escrow trigger)
- E06 moderation panel + DSA module completes
- All epics converge for Phase 1 soft launch

**Critical path (serial bottleneck):** E07 → E02 → E01 → E04 = ~21 weeks serial minimum. Parallel execution across a 3-person team achieves Phase 1 in ~20–22 weeks.

## Done = Done

- All acceptance criteria met
- ≥70% test coverage
- CI gates passing
- WCAG 2.2 AA passing
