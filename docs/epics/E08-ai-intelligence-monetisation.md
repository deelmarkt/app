# E08 — AI, Intelligence & Monetisation

> **Priority:** P2 — Medium | **Phase:** 2–3 (Post-Launch) | **Est. Duration:** 16+ weeks (parallel tracks)

---

## Overview

Phase 2–3 capabilities that transform DeelMarkt from a functional marketplace into an intelligent platform. Covers AI listing tools (Snap-to-List, smart pricing), personalised recommendations, visual search, promoted listings monetisation, analytics migration, sustainability/CO2 features, and the Phase 3 behavioural scoring system.

> **Note:** This epic is a planning document for Phase 2+. Stories will be broken into sprint-sized work orders when Phase 2 begins (Month 3). Dependencies on Phase 1 infrastructure (E01–E07) must be fully live before this epic begins.

---

## User Stories

### AI Listing Tools (Phase 2)
- As a seller, I can photograph an item and the app generates a title, description, and category automatically (Snap-to-List)
- As a seller, I see an AI-recommended price based on comparable completed sales
- As a seller, my listing photo background is automatically removed/cleaned up
- As a seller, my item is automatically categorised at L2 level from a single photo

### Personalised Discovery (Phase 2–3)
- As a buyer, my home feed shows listings relevant to my browsing and purchase history
- As a buyer, I see "Similar items" recommendations on every listing detail page
- As a buyer, I can search by photo — I photograph something I want and see matching listings

### Monetisation (Phase 2)
- As a seller, I can boost my listing for increased visibility (promoted listings: €0.99–€4.99)
- As a seller with high volume, I can subscribe to a business plan (€19.99–€99.99/month)
- As a business seller, I have a premium dashboard with analytics, bulk listing tools, and priority support

### Analytics Upgrade (Phase 2)
- As the product team, we have funnel analysis, session recording, and retention charts via PostHog
- As a developer, model performance is tracked and model drift is detected automatically (MLflow + Evidently)

### Sustainability (Phase 2) ← E06 declares ownership; E08 implements
- As a buyer/seller, I see a CO2 savings estimate on each completed transaction (vs buying new)
- As a user, I see eco-score badges on listings and seller profiles
- As a seller, I can opt into a "circular economy verified" badge programme

### AI Behavioural Scoring (Phase 3) ← E06 declares intent; E08 implements
- As the platform, bot accounts and account takeover attempts are detected in real-time
- As a moderator, high-risk accounts are surfaced automatically for review

---

## Technical Scope

### Snap-to-List — AI Listing Creation (Phase 2, 6 weeks)
- Computer vision: object identification from a single photo (CLIP or fine-tuned ResNet)
- LLM (GPT-4o or Gemini) generates professional title + description from photo + object class
- AI background removal (visual segmentation)
- Automatic L2 category detection (fine-tuned DistilBERT + ResNet ensemble, <200ms)
- Phase 2 target: <3 minutes to publish for 80% of items

### Smart Pricing Engine (Phase 2, 4 weeks)
- XGBoost regression model trained on completed transactions (price, category, condition, age)
- Market data ingestion: completed sales from own platform + public price signals
- Confidence range displayed (not just a point estimate)
- Latency target: <100ms (served from feature store)

### Personalised Recommendations (Phase 2–3, 6 weeks)
- Two-Tower collaborative filtering model (user embeddings + item embeddings)
- Content-based fallback for cold-start users
- Latency target: <150ms for home feed
- A/B test new models at 5% shadow traffic before rollout
- Model drift: Evidently AI weekly monitoring; PSI >0.2 → retrain

### Visual Search (Phase 3, 8 weeks)
- CLIP (ViT-B/32) visual embeddings for all listing photos
- Pinecone ANN vector database for nearest-neighbour search
- Latency target: <500ms
- Enables "photograph what you want" search flow

### Promoted Listings & Monetisation (Phase 2, 3 weeks)
- Promoted listing product: seller pays €0.99–€4.99 for boosted placement (top of results, category page featured)
- Top Ad product: €2.99–€9.99 for homepage/category hero
- Business subscription plans: €19.99 (basic), €49.99 (growth), €99.99/month (enterprise)
  - Includes: bulk listing, analytics dashboard, priority support queue
- Shipping commission: 7% of shipping label cost (passed through PostNL/DHL APIs)
- Authentication fee: €4.99–€14.99 for premium item authentication (Phase 3)

### Analytics Migration — PostHog (Phase 2, 1 week)
- Self-hosted PostHog on Railway (GDPR-native; session recording; funnels; retention)
- Replaces Firebase Analytics as primary product analytics
- Firebase Analytics retained for Crashlytics and Remote Config
- Data warehouse: Redshift Serverless for BI + ML training data

### MLOps Standards (Phase 2+)
- Model versioning: MLflow Model Registry (every model tied to a commit)
- Feature store: Feast (offline + online) — prevents training/serving skew
- A/B testing: 5% shadow traffic → statistical significance → rollout
- Fallback policy: AI fails → rule-based system activates automatically

### CO2 Savings Calculator (Phase 2, 2 weeks)
- Per-category CO2 savings table (lifecycle emissions: new item vs secondhand)
- Calculated on escrow release; stored on transaction record
- Displayed: post-transaction confirmation screen, seller profile, platform stats page
- Platform aggregate counter for press/investor reporting

### AI Behavioural Scoring (Phase 3, 8 weeks)
- Anomaly detection: session velocity, IP reputation, device fingerprint, listing pattern analysis
- Real-time risk tier: low / medium / high / critical
- High-risk → auto-suspend pending human review (E06 account suspension flow)
- Latency: <1s per event via streaming ML inference

---

## Acceptance Criteria (Phase 2 launch gate)

- [ ] Snap-to-List: category detected correctly for top 10 item types (>80% accuracy)
- [ ] Smart pricing: suggested price within 20% of final sale price for >60% of listings
- [ ] Promoted listings purchasable via Mollie; placement logic verified
- [ ] PostHog analytics receiving events (funnel events: registration, listing_created, payment_started, payment_completed)
- [ ] CO2 savings calculated and displayed on transaction completion
- [ ] MLflow tracking all model versions; Evidently drift detection active
- [ ] A/B framework (Unleash + PostHog) able to measure impact of recommendations on CTR

---

## Dependencies

- **E01** — Listing data and outbox events as ML training data + search sync foundation
- **E02** — KYC Level 2+ required for business subscription
- **E03** — Mollie integration for promoted listing purchases + shipping commission
- **E06** — CO2 badges co-owned; behavioural scoring feeds account suspension flow
- **E07** — Unleash for gradual AI feature rollouts; Upstash Redis for ML serving cache
- Pinecone account (Phase 3 visual search)
- Redshift Serverless (BI + ML training data)
- MLflow infrastructure (Railway or self-hosted)
- PostHog (self-hosted on Railway)
