# E01 — Listing Management & Search

> **Priority:** P0 — Critical | **Phase:** 0–1 (MVP) | **Est. Duration:** 10 weeks

---

## Overview

Core listing CRUD with photo-first creation flow, Dutch-language search via PostgreSQL full-text search (built into Supabase), image processing pipeline via Supabase Storage + Cloudinary, saved favourites, and location-based filtering.

---

## User Stories

### Listing Creation
- As a seller, I can create a listing with photos, title, description, price, condition, and category
- As a seller, I can edit or delete my active listings
- As a seller, I see a listing quality score (0–100) before publishing, with tips to improve it
- As a seller, my uploaded images are automatically optimised (resize, WebP, EXIF stripped)

### Search & Discovery
- As a buyer, I can search listings with Dutch-language support (stemming, e.g. "fietsen" → "fiets")
- As a buyer, I can filter by category, price range, condition, and location/distance
- As a buyer, I can browse listings by category with dynamic faceting
- As a buyer, empty search results suggest related items or prompt saved search alerts

### Favourites
- As a user (Level 0+), I can save listings to my favourites
- As a user, I can view and manage my saved favourites list
- As a user, I am notified when a saved listing's price drops or it is about to expire

---

## Technical Scope

### Listing CRUD (6 weeks)
- Photo-first mobile creation flow (1–12 images)
- Category tree (L1 → L2 hierarchy)
- Condition grading: New, Like New, Good, Fair
- Listing status: draft, active, sold, expired, deleted
- Favourites table (user_id + listing_id) with RLS
- Supabase PostgreSQL schema + RLS policies

### Image Processing Pipeline (2 weeks)
- Upload to Supabase Storage (source of truth)
- Edge Function trigger: resize (200×200, 800×600, 1600×1200)
- EXIF stripping (GDPR — GPS coordinates = personal data)
- Cloudinary for WebP/AVIF conversion + CDN delivery
- ClamAV virus scanning via Edge Function
- Rules: max 15 MB/image, max 12 images/listing

### Search — PostgreSQL FTS (1 week)
- Dutch text search configuration with tsvector
- Weighted search: title (A) > description (B) > category (C)
- GIN index for fast lookups
- **Outbox pattern for downstream sync** (`search_outbox` table + PostgreSQL trigger):
  - Drives Redis cache invalidation (listing detail, search results, user profile caches)
  - Provides event stream for Phase 2 Meilisearch/Typesense sync
  - Prevents stale listings (sold items showing in results) — Risk Register item
  - FTS queries PostgreSQL directly (<500ms); the outbox feeds async downstream consumers only
- Schema:
  ```sql
  CREATE TABLE search_outbox (
    id          UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    event_type  TEXT NOT NULL, -- 'listing.created' | 'listing.updated' | 'listing.deleted'
    payload     JSONB NOT NULL,
    processed   BOOLEAN DEFAULT false,
    created_at  TIMESTAMPTZ DEFAULT now()
  );
  CREATE TRIGGER listings_to_outbox
    AFTER INSERT OR UPDATE OR DELETE ON listings
    FOR EACH ROW EXECUTE FUNCTION notify_search_outbox();
  ```

### Listing Quality Score (0.5 weeks)
- Server-side score (0–100) computed before publish; exposed via Edge Function
- Scoring weights:
  | Signal | Weight |
  |:-------|:-------|
  | ≥3 photos | 25 pts |
  | Title length 10–60 chars | 15 pts |
  | Description ≥50 words | 20 pts |
  | Price set (not 0) | 15 pts |
  | Category set at L2 | 15 pts |
  | Condition set | 10 pts |
- Score display: colour-coded bar (red <40, amber 40–70, green >70) with per-field tips
- Minimum score to publish: 40 (prevents blank listings)

### Location & Distance Filtering (0.5 week)
- Request GPS permission on first distance-based search
- PostNL postcode API to resolve postcode → lat/lng
- PostgreSQL PostGIS extension or simple haversine formula for distance sorting
- Default radius options: 10 km, 25 km, 50 km, nationwide

---

## Phase 2 — Search Upgrade (Months 3–9, ~5K MAU)

> **Trigger:** When typo tolerance and autocomplete become user pain points (typically at ~5K MAU)

- **Meilisearch** (self-hosted on Railway ~$15–20/mo, or Cloud $30/mo) replaces direct FTS queries
- Typesense is an alternative — decision deferred; see ROADMAP.md for resolution
- Dutch stemmer config + typo tolerance + prefix autocomplete
- Outbox poller fans events into Meilisearch on top of existing Redis invalidation
- **Phase 3 (10M+ listings):** Elasticsearch with compound-word decomposition replaces Meilisearch

**Phase 2 User Stories:**
- As a buyer, misspelled searches still return relevant results (typo tolerance)
- As a buyer, I see autocomplete suggestions as I type
- As a seller, a newly created listing appears in search within <500ms (P95) of publishing

---

## Acceptance Criteria

- [ ] Listing CRUD works end-to-end on iOS and Android
- [ ] Image pipeline: EXIF stripped, WebP generated via Cloudinary, ClamAV scanned
- [ ] PostgreSQL FTS returns Dutch-stemmed results (e.g. "fietsen" matches "fiets")
- [ ] Search results render in <500ms (P95)
- [ ] `search_outbox` table populated on listing create/update/delete (verified via DB rows)
- [ ] Redis cache invalidated on `listing.sold` and `listing.deleted` events within 10s
- [ ] Sold/deleted listings excluded from search immediately (same DB — instant)
- [ ] Listing quality score API returns 0–100 with per-field breakdown
- [ ] Publishing blocked if quality score <40
- [ ] Favourites: save, unsave, view list
- [ ] Location/distance filtering works with postcode and GPS
- [ ] ≥70% test coverage

---

## Dependencies

- **E07** (Infrastructure) — Supabase project, Cloudinary account, Upstash Redis
- **E02** (User Auth) — seller must be authenticated to create listings
