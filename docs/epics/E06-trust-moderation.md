# E06 — Trust, Moderation & DSA Compliance

> **Priority:** P1 — High | **Phase:** 0–1 (MVP) | **Est. Duration:** 9 weeks

---

## Overview

AI scam detection engine (sole owner — E04 integrates via API), dispute resolution workflow, user ratings/reviews (full lifecycle), account suspension/appeal/recovery, DSA-compliant transparency module, admin moderation panel, and prohibited items enforcement.

---

## User Stories

### Scam Detection (this epic OWNS scam detection — E04 integrates it)
- As a user, messages containing suspicious links/phone numbers are flagged automatically within 1 second
- As a moderator, I can review AI-flagged content and take action

### Dispute Resolution
- As a buyer, I can flag an issue within 48 hours of delivery
- As a buyer/seller, I can submit evidence (photos, chat screenshots) within 24 hours
- As a user, I receive a binding resolution within 72 hours for contested cases

### Ratings & Reviews
- As a buyer, I can rate and review a seller after escrow release (transaction fully complete)
- As a seller, I can rate and review a buyer after escrow release (two-way ratings)
- As a user, I see a seller's average rating and review count on their profile
- As a user, I can report a review as fake or abusive

### Account Suspension & Recovery
- As the platform, I can warn, suspend, or ban an account when policy violations are confirmed
- As a suspended user, I receive a clear notification stating the reason for suspension
- As a suspended user, I can submit an appeal with supporting evidence within 14 days
- As a moderator, I review appeals and issue a binding decision within 72 hours
- As a reinstated user, I receive a notification and my account is fully restored

### DSA Compliance
- As a user, I can report illegal content with a structured notice form
- As a user, I have access to a non-personalised feed option
- As the platform, DSA notice-and-action reports are tracked with 24-hour SLA

### Prohibited Items
- As a seller, I see a clear prohibited items policy before listing
- As the platform, listings matching prohibited categories are auto-flagged

### Moderation
- As an admin, I have a moderation panel to review flagged content, disputes, DSA reports, and appeals

---

## Technical Scope

### AI Scam Detection Engine (4 weeks)
- NLP keyword scanning for common fraud patterns
- Link detection and flagging (external URLs, shortened links)
- Phone number / off-platform payment request detection
- Rule-based scoring system with configurable thresholds
- **Latency target: <1s** (Edge Function; synchronous per-message call from E04)
- Exposed as an Edge Function API (called by E04 messaging)
- Prohibited items keyword matching on listing creation

### Dispute Resolution Workflow (2 weeks)
- Buyer "flag issue" flow within 48-hour delivery window
- Evidence submission with 24-hour deadline
- AI pre-screening for automatic resolution (~60% target)
- Human agent review queue for contested cases
- Refund/release with correct split via E03

### Ratings & Reviews System (1 week)
**Data model:**
- `reviews` table: `id`, `transaction_id` (FK, UNIQUE per reviewer), `reviewer_id`, `reviewee_id`, `role` (buyer|seller), `rating` (1–5), `body` (text, max 500 chars), `created_at`, `is_hidden` (bool, moderation flag)
- Rating is triggered **after escrow release** (delivery confirmed + 48-hour window closed) — not on listing sale, not sooner
- Two-way: buyer rates seller AND seller rates buyer (mutual; each can only submit once per transaction)
- **Blind review:** both parties' reviews are submitted and locked before either is revealed — prevents strategic retaliation
- **Anti-gaming rules:**
  - 1 review per transaction (UNIQUE on `transaction_id + reviewer_id`)
  - Review window: 14 days after escrow release; closes automatically
  - Fake review reports: user flagging → moderator queue; 3 confirmed fake reviews → account review
- **Aggregate score:** `avg(rating)` displayed once ≥3 reviews; hidden below threshold to prevent first-review abuse
- Displayed on seller profile and in listings listing card

### Account Suspension & Appeal/Recovery Flow (1 week)
- `account_sanctions` table: `user_id`, `type` (warning|suspension|ban), `reason`, `expires_at` (null = permanent), `appealed_at`, `appeal_body`, `appeal_decision`, `resolved_at`
- **Suspension types:** temporary (7/14/30 days), permanent
- Push notification + email on sanction with plain-language reason (no vague "policy violation")
- **Appeal flow:**
  - User submits appeal with supporting text/evidence within 14 days of suspension
  - Routed to moderator appeal queue (separate from standard dispute queue)
  - Binding decision within 72 hours; counter-appeal not permitted
  - Reinstatement: RLS policies re-enabled; all existing listings restored (not deleted during suspension)
- Fraudulent seller pattern → automatic ban flag → iDIN level revoked → flagged for Wwft reporting

### DSA Transparency Module (1 week)
- Content reporting form (notice-and-action)
- 24-hour SLA tracking with dashboard
- KYBC verification for business sellers
- Non-personalised feed option toggle

### Admin Moderation Panel (0 weeks additional — included above)
- Retool-based panel (fastest to build) or custom Flutter web
- Queues: flagged listings, flagged messages, disputes, DSA reports, **appeals**
- User management: view KYC level, warn, suspend, ban, **review appeals**
- SLA dashboard: DSA 24hr compliance tracking
- Dispute resolution interface: view evidence, issue decision

### Phase 3 — AI Behavioural Scoring
> Documented here as a planned Phase 3 capability; implementation owned by a future E08.
- Anomaly detection for bot accounts and account takeover patterns
- Real-time behavioural signal scoring (session velocity, IP patterns, device fingerprint)
- Automatic risk-tier assignment; high-risk accounts routed to human review
- Latency target: <1s per event

### Phase 2 — Sustainability Features
> CO2 savings calculator and eco-score badges — planned for Phase 2; ownership confirmed in this epic.
- Each completed shipped transaction → CO2 savings estimate calculated based on item category (vs buying new)
- Eco-score badge displayed on listing and seller profile
- Platform-level CO2 saved counter for press/investor reporting
- Enables sustainability marketing pillar (Master Plan §14.1 Pillar #5)

---

## Acceptance Criteria

- [ ] Scam detection API flags suspicious messages with <1s latency (callable by E04)
- [ ] Prohibited items auto-flagging works on listing creation
- [ ] Dispute resolution flow works end-to-end
- [ ] Ratings & reviews: both parties can rate after escrow release; blind until both submit
- [ ] Anti-gaming: UNIQUE constraint on one review per transaction enforced at DB level
- [ ] Ratings hidden until ≥3 reviews; average displayed correctly
- [ ] Account suspension sends push + email with reason
- [ ] Appeal flow: submission → moderator queue → 72h decision → reinstatement/uphold
- [ ] DSA notice-and-action form available and tracked with SLA
- [ ] Non-personalised feed option available
- [ ] Admin moderation panel operational with all queues (including appeals)
- [ ] ≥70% test coverage

---

## Dependencies

- **E04** (Messaging) — scam detection is called by chat; but E06 owns the engine
- **E03** (Payments) — dispute resolution and ratings both depend on escrow completion
- **E01** (Listings) — prohibited items check on listing creation; CO2 calculation on category
