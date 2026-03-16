# E05 — Shipping & Logistics

> **Priority:** P1 — High | **Phase:** 0–1 (MVP) | **Est. Duration:** 4 weeks

---

## Overview

Label-free QR shipping via PostNL and DHL, real-time tracking, Dutch address verification with postcode auto-fill, SmartyStreets validation for international addresses, and ParcelShop selector. Returns flow deferred to Phase 2.

---

## User Stories

### Phase 0–1 (MVP)
- As a seller, I receive a QR code after a sale — no printer needed
- As a seller, I can drop off the package at any PostNL ServicePoint or DHL ParcelShop
- As a buyer, I receive real-time tracking updates from carrier scan to delivery
- As a buyer, I can choose a pickup point near me
- As a user, my address auto-fills when I enter my postcode (4+2 format)

### Phase 2 Additions
- As a seller, I can generate a printerless return QR code for buyer returns
- As a buyer, I can initiate a return entirely within the app (no printing required)

---

## Technical Scope

### Label-Free QR Shipping (2 weeks)
- PostNL Shipping V4 API integration
- DHL QR Service integration
- QR code generation in-app after sale confirmation
- Carrier scan → tracking event → escrow release trigger (E03)

### Tracking & Address (2 weeks)
- PostNL Shipping Status API for real-time tracking
- Push notifications on tracking milestones via FCM (FCM delivery rate SLO ≥98% — inherited from E07/Firebase)
- **Dutch address verification (primary): PostNL postcode API** — postcode 4+2 → city + street auto-fill; three distinct fields (Postcode, Huisnummer, Toevoeging)
- **International address verification (secondary): SmartyStreets** — validates non-Dutch/expat addresses where PostNL API doesn't apply; reduces delivery errors for international sellers/buyers
  - Decision: include SmartyStreets API in Phase 1 for international address validation; defer if expat volume is lower than projected
- PostNL VPS map integration for ParcelShop selector
- Uses saved addresses from E02 user profile

### Phase 2: Returns
- DHL Printerless Returns API for label-free returns
- Return QR code generation
- Return tracking + escrow handling

---

## Acceptance Criteria

- [ ] QR code generated after sale and displayed in-app
- [ ] PostNL label-free shipping works end-to-end
- [ ] Real-time tracking events push to both buyer and seller
- [ ] Dutch address auto-fill works from postcode entry (PostNL postcode API)
- [ ] SmartyStreets validates non-Dutch addresses (or decision to defer is explicitly recorded in ADR)
- [ ] ParcelShop selector shows nearest locations on map
- [ ] Delivery confirmation triggers escrow release (E03)
- [ ] Saved addresses from E02 pre-fill shipping forms
- [ ] Tracking push notifications fire on carrier scan events (FCM)
- [ ] ≥70% test coverage

---

## Dependencies

- **E03** (Payments) — escrow release triggered by delivery confirmation
- **E02** (User Auth) — saved addresses
- PostNL API credentials + DHL API credentials
- SmartyStreets API key (or explicit ADR deferral decision)
