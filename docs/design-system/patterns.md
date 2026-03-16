# UI Patterns

> Trust UI, escrow flow, KYC, chat, search, shipping, listing detail, notifications, sustainability.

---

## Trust Banner

Top of listing detail and transaction screens:

```
┌──────────────────────────────────────────┐
│ 🛡️  Beschermd met DeelMarkt Escrow       │
│     Je geld is veilig tot levering.      │
│                              Meer info → │
└──────────────────────────────────────────┘
```

Background: `trust-shield` (`#F0FDF4`). Border-left: 3px `trust-verified` (`#16A34A`). Never dismissible.

---

## Seller Trust Score

Displayed on seller profile and listing detail:

```
┌─────────────────────────┐
│  ★ 4.8  (127 reviews)   │
│  🛡️ iDIN · 📱 · ✉️      │
│  📍 Amsterdam            │
│  ⏱️ Reageert binnen 1u   │
│  📦 98% op tijd verzonden │
└─────────────────────────┘
```

---

## Escrow Timeline

Horizontal stepper on transaction detail:

```
● ─────── ● ─────── ○ ─────── ○ ─────── ○
Betaald   Verzonden  Bezorgd   Bevestigd  Uitbetaald
```

- Complete: filled + checkmark (`trust-escrow` blue)
- Active: pulsing circle (`primary` orange)
- Pending: empty circle (`neutral-300`)
- Solid line for complete, dashed for pending
- Each step tappable → detail modal with timestamp
- "Bezorgd" step: countdown "48 uur om te bevestigen"

---

## Payment Summary

```
┌──────────────────────────────────────┐
│  Bestelling overzicht                │
│                                      │
│  Vintage stoel               €45,00  │
│  Platformkosten               €1,63  │
│  Verzendkosten                €6,95  │
│  ───────────────────────────────────  │
│  Totaal                      €53,58  │
│  incl. BTW                           │
│                                      │
│  🛡️ Beschermd met escrow             │
│                                      │
│  [ Betaal met iDEAL        → ]       │
│                                      │
│  PayPal · Bancontact · Kaart         │
└──────────────────────────────────────┘
```

All costs visible before buy button. iDEAL default (with bank logo). BTW mandatory. Escrow callout always visible.

---

## KYC Prompts

Contextual, never blocking walls:

| Transition | Trigger | Style |
|:-----------|:--------|:------|
| 0 → 1 | First message | Inline banner: "Verifieer je e-mail om te chatten" |
| 1 → 2 | First listing | Bottom sheet: "Bevestig je identiteit om te verkopen" (iDIN/itsme) |
| 2 → 3 | First escrow | Full-screen: "Laatste stap: foto-verificatie" (Onfido) |
| 3 → 4 | €2,500+/month | Dashboard banner: "Word zakelijk verkoper" |

### Verification Progress (on profile)

```
┌──────────────────────────────────────┐
│  Verificatie                         │
│                                      │
│  ✅ E-mail geverifieerd              │
│  ✅ Telefoon geverifieerd            │
│  ✅ iDIN identiteit                  │
│  ○  Foto-verificatie          [ → ]  │
│  ○  Zakelijk verkoper                │
│                                      │
│  ████████████████░░░░  3/5           │
│  Meer verificatie = meer vertrouwen  │
└──────────────────────────────────────┘
```

---

## Search & Discovery

### Search Bar

```
┌──────────────────────────────────────┐
│  🔍  Zoek op DeelMarkt...     ⚙️    │
└──────────────────────────────────────┘
```

Persistent at top of Home and Search tabs. On tap → expands to:
- Recent searches (with "Wis alles")
- Trending searches
- Suggested categories

### Filter System

```
[ Categorie ▼ ]  [ Prijs ▼ ]  [ Afstand ▼ ]  [ Conditie ▼ ]  [ Meer ▼ ]
```

- Horizontal scroll chip row
- Active: filled `primary-surface` with `primary` text
- Inactive: outline chip
- Badge on active: `[ Prijs (1) ▼ ]`
- "Meer" → full filter bottom sheet

### Map Toggle

```
[ ≡ Lijst ]  [ 🗺️ Kaart ]
```

Map view: listing pins with price labels. Tap pin → listing card preview.

### Empty Search

```
┌──────────────────────────────────────┐
│        🔍  (large, grey)             │
│  Geen resultaten voor "xyz"          │
│  Probeer:                            │
│  · Andere zoektermen                 │
│  · Minder filters                    │
│  · Grotere afstand                   │
│  [ Bewaar zoekopdracht 🔔 ]          │
└──────────────────────────────────────┘
```

---

## Chat Thread

```
┌──────────────────────────────────────┐
│ ← Jan de Vries  🛡️ iDIN             │
│   ⏱️ Reageert < 1 uur                │
├──────────────────────────────────────┤
│ ┌────────────────────────────────┐   │
│ │ 📷 Vintage stoel  ·  €45,00   │   │
│ │ 🟢 Escrow beschikbaar         │   │
│ └────────────────────────────────┘   │
│ [ Doe een bod 💰 ]  [ Plan afhalen 📍 ] │
├──────────────────────────────────────┤
│ ... messages ...                     │
└──────────────────────────────────────┘
```

Listing card always pinned. Verification badges in header. Response time displayed.

### Structured Offer Message

```
┌──────────────────────────────────────┐
│  💰 Bod van €35,00                   │
│     op: Vintage design stoel (€45,00)│
│                                      │
│  [ Accepteren ✅ ]  [ Afwijzen ✗ ]   │
│  [ Tegenbod doen ↩️ ]                │
└──────────────────────────────────────┘
```

### Scam Alert (Inline)

```
┌─ ⚠️ Waarschuwing ────────────────────┐
│ Dit bericht bevat een link naar een  │
│ externe betaalsite. Betaal alleen    │
│ via DeelMarkt Escrow.                │
│ [ Negeer ]  [ Meld verdacht 🚨 ]    │
└──────────────────────────────────────┘
```

Background: `error-surface`. Border-left: 3px `trust-warning`. Inline in chat, never popup.

---

## Listing Detail

```
┌──────────────────────────────────────┐
│  ← (back)           🔗 (share) ♡    │  ← Transparent over image
│  ┌────────────────────────────────┐  │
│  │     IMAGE GALLERY (16:10)     │  │  ← Swipe, dot indicators
│  │  1/8              📷          │  │  ← Photo count + fullscreen
│  └────────────────────────────────┘  │
│  €45,00                              │  ← heading-lg, bold
│  🌿 −2,4 kg CO2                     │  ← Eco badge (small, green)
│  Vintage design stoel                │  ← heading-md
│  🛡️ Beschermd met DeelMarkt Escrow  │  ← Trust banner
│  ┌── Seller Card ────────────────┐  │
│  │ 🧑 Jan de Vries  🛡️ iDIN      │  │
│  │    ⭐ 4.8 (127) · 📍 Amsterdam│  │
│  └────────────────────────────────┘  │
│  Beschrijving: ...  [ Toon meer ▼ ] │
│  Categorie: Meubels · Conditie: Goed│
│  Verzending: PostNL (€6,95)         │
│  📍 Amsterdam, 2,3 km [map preview] │
│  ──────── Sticky bottom ──────────  │
│  [ Bericht sturen 💬 ] [Koop nu → ] │
└──────────────────────────────────────┘
```

Sticky CTA bar: 72px height (incl safe area). White + `elevation-1`.

---

## Listing Creation (Phase 1)

```
[+Verkoop] → Camera (1–12 photos) → Form:
  Title, Price (€), Category, Condition, Description,
  📍 Location (auto), 🚚 Shipping/Pickup toggle

  Quality score: ████░ 72/100  (colour bar: red <40, amber 40–70, green >70)
  Minimum to publish: 40

  [ Concept opslaan ]  [ Plaats advertentie → ]
```

---

## Shipping QR Card

```
┌──────────────────────────────────────┐
│  📦 Verzend je pakket                │
│  ┌────────────────┐                  │
│  │   [QR CODE]    │  Scan bij een    │
│  │                │  PostNL punt of  │
│  │                │  DHL ServicePoint│
│  └────────────────┘                  │
│  Verzend voor: do 20 mrt, 18:00     │
│  [ Zoek servicepunt 📍 ]             │
└──────────────────────────────────────┘
```

### Tracking Timeline (Vertical)

```
  ✅  Betaald                    14 mrt, 10:30
  │
  ✅  Verzonden via PostNL       15 mrt, 14:15
  │   Tracking: 3SDEVC0123456
  │
  ●   Onderweg                   16 mrt
  │   Sorteercentrum Amsterdam
  │
  ○   Bezorgd
  │
  ○   Bevestigd door koper
  │
  ○   Uitbetaald aan verkoper
```

---

## Dutch Address Input

```
Postcode    [ 1012 AB ]             ← 4+2, triggers auto-fill
Straat      [ Damrak       ] (auto)
Huisnr.     [ 1    ] Toev. [ A  ]
Stad        [ Amsterdam    ] (auto)
```

---

## Seller/Buyer Mode

Home adapts based on activity:
- **Buyer (default):** search → categories → recommended → nearby → recent
- **Seller (active listings):** stats → action needed → active listings → tips

Auto-switch, manual toggle in profile.

---

## Notifications & Feedback

### Toast/Snackbar

```
┌──────────────────────────────────────┐
│  ✅ Advertentie geplaatst            │
└──────────────────────────────────────┘
```

- Bottom of screen, above bottom nav
- Auto-dismiss: 3 seconds; swipe to dismiss
- Max 1 visible at a time
- Colour: semantic surface (green/red/yellow)

### Push Notification Categories

| Category | Example | Priority |
|:---------|:--------|:---------|
| Transaction | "Je item is verkocht!" | High — immediate |
| Message | "Nieuw bericht van Jan" | Medium — badge + sound |
| Shipping | "Je pakket is bezorgd" | Medium |
| Price alert | "Prijsdaling op je favorieten" | Low — silent |
| System | "Verifieer je identiteit" | Low — silent |

### In-App Review

Triggered ONLY after successful transaction. Never on app open, never after dispute. Max once per 90 days. Uses `in_app_review` package.

---

## Sustainability UI

### CO2 Savings Badge

```
  🌿 −2,4 kg CO2 bespaard
```

Small, green text + leaf icon. On listing detail (below price) and transaction confirmation.

### Eco Score (Phase 2)

```
  ♻️ Eco Score: ████░  B
```

Based on: items sold secondhand, packaging, shipping distance.

---

## Localisation

NL/EN **segmented control** (not dropdown). Instant switch, no reload. Persisted locally + backend.

| Element | Dutch (NL) | English (EN) |
|:--------|:-----------|:-------------|
| Currency | €12,50 | €12.50 |
| Date | 16 mrt 2026 | 16 Mar 2026 |
| Date (full) | maandag 16 maart 2026 | Monday 16 March 2026 |
| Time | 14:30 | 14:30 (24h in NL context) |
| Distance | 2,3 km | 2.3 km |
| Decimal | comma (,) | dot (.) |
| Thousands | dot (.) | comma (,) |
| Phone | +31 6 12345678 | +31 6 12345678 |

### Auto-Translation Indicator

```
  🌐 Automatisch vertaald uit het Engels  [ Toon origineel ]
```

### String Key Convention

```dart
// ✅ Correct
'listing_card.escrow_available'.tr()
'payment.total_including_btw'.tr()

// ❌ Never hardcode
Text('Beschermd met escrow')
```
