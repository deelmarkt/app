# Components

> Buttons, cards, inputs, badges, states, navigation, icons, categories.
> All implemented in `lib/widgets/`.

---

## Component Library

| Component | Description | Priority |
|:----------|:-----------|:---------|
| `DeelButton` | Primary, secondary, outline, ghost, destructive, success | P0 |
| `DeelCard` | Listing card (grid/list), seller card, transaction card | P0 |
| `DeelInput` | Text, search, password, price (€), postcode (NL) | P0 |
| `DeelBadge` | Trust badges, status badges, notification counts | P0 |
| `DeelChip` | Filter chips (category, condition, distance), selectable | P0 |
| `DeelAvatar` | User avatar with verification badge overlay | P0 |
| `PriceTag` | Formatted price with BTW, strikethrough for offers | P0 |
| `TrustBanner` | Escrow protection banner, scam alert banner | P0 |
| `EscrowTimeline` | Horizontal stepper for payment flow | P0 |
| `SearchBar` | Autocomplete with recent + trending suggestions | P0 |
| `LocationBadge` | Distance indicator with pin icon | P0 |
| `ImageGallery` | Swipe gallery, dot indicators, zoom, upload preview | P0 |
| `LanguageSwitch` | NL/EN toggle (segmented control, always visible) | P0 |
| `EmptyState` | Illustrated empty state with action button | P0 |
| `ErrorState` | Error with retry button | P0 |
| `SkeletonLoader` | Shimmer loading placeholders | P0 |
| `CategoryIcon` | Duotone category icon with label | P1 |
| `OfferButton` | "Doe een bod" with price input | P1 |
| `RatingDisplay` | Star rating + review count | P1 |
| `ShippingQR` | QR code display for label-free shipping | P1 |
| `TrackingTimeline` | Vertical stepper for shipping status | P1 |
| `EcoBadge` | CO2 savings display, sustainability score | P2 |

---

## Buttons

| Variant | Background | Text | Border | Usage |
|:--------|:-----------|:-----|:-------|:------|
| Primary | `primary` | White | None | "Koop nu", "Verkoop", "Betaal" |
| Secondary | `secondary` | White | None | "Bericht sturen", "Bod doen" |
| Outline | Transparent | `secondary` | 1.5px `secondary` | "Bekijk profiel", "Delen" |
| Ghost | Transparent | `neutral-700` | None | "Annuleren", "Overslaan" |
| Destructive | `error` | White | None | "Account verwijderen" |
| Success | `success` | White | None | "Levering bevestigen" |

| Size | Height | Padding (H) | Font |
|:-----|:-------|:------------|:-----|
| Large | 52px | 24px | 16px |
| Medium | 44px | 16px | 14px |
| Small | 36px | 12px | 13px |

**5 states:** default, pressed (10% darker), focused (2px `primary` outline offset), disabled (40% opacity), loading (spinner replaces text).

**FAB (Sell):** Orange, centred in bottom nav, always visible, never hidden on scroll, `radius-xl` (16px).

---

## Cards

### Listing Card (Grid)

```
┌─────────────────────────────┐
│     [ Image 4:3 ratio ]     │
│                     ♡       │  ← 44×44 tap target
│  🛡️                         │  ← Trust badge overlay
├─────────────────────────────┤
│  €45,00                     │  ← price-sm, bold (ALWAYS first)
│  Vintage design stoel       │  ← body-md, max 2 lines, ellipsis
│  📍 Amsterdam · 2,3 km      │  ← body-sm, neutral-500
│  🟢 Escrow beschikbaar      │  ← body-sm, trust-verified
└─────────────────────────────┘
```

Card: 1px `neutral-200` border, `radius-xl` (16px), no shadow. Shimmer skeleton while loading.

### Listing Card (List)

```
┌────────┬──────────────────────────────┐
│        │  €45,00                      │
│ Image  │  Vintage design stoel        │
│ 1:1    │  📍 Amsterdam · 2,3 km       │
│  🛡️   │  🟢 Escrow · ⏱️ 3 uur geleden│
│ 120×120│                         ♡    │
└────────┴──────────────────────────────┘
```

### Transaction Card

```
┌────────┬──────────────────────────────┐
│        │  Vintage design stoel        │
│ Image  │  €45,00 + €6,95 verzending   │
│ 1:1    │  ● ── ● ── ○ ── ○ ── ○      │  ← Mini escrow timeline
│        │  Status: Verzonden 📦         │
│        │  [ Bekijk details → ]        │
└────────┴──────────────────────────────┘
```

### Seller Card

```
┌──────────────────────────────────────┐
│  🧑 [Avatar]  Jan de Vries           │
│               🛡️ iDIN · ⭐ 4.8 (127) │
│               📍 Amsterdam            │
│               ⏱️ Reageert < 1 uur     │
│  [ Bekijk profiel ]  [ Bericht → ]   │
└──────────────────────────────────────┘
```

---

## Inputs

| Type | Spec |
|:-----|:-----|
| Text | `radius-md` (10px), filled white, `neutral-200` border, `primary` 2px focus border |
| Search | Persistent top, 🔍 left, ⚙️ filter right |
| Price | `€` prefix, tabular figures, comma decimal |
| Postcode | 4+2 format (e.g. `1012 AB`), auto-fills city + street |
| Password | Show/hide toggle, strength indicator |

---

## Badges

| Badge | Visual | Colour | Trigger |
|:------|:-------|:-------|:--------|
| Email Verified | ✉️ checkmark | `neutral-500` | KYC Level 0 |
| Phone Verified | 📱 checkmark | `neutral-500` | KYC Level 0 |
| iDIN Verified | 🛡️ shield + check | `trust-verified` | KYC Level 2 |
| ID Verified | 🪪 shield + star | `trust-verified` + gold | KYC Level 3 |
| Business Seller | 🏢 KVK | `secondary` blue | KYC Level 4 |
| Escrow Protected | 🔒 lock | `trust-escrow` | Transaction |
| Top Seller | ⭐ star | `warning` gold | Performance-based |

**Rules:** Max 3 inline. iDIN always leftmost. Never animate. Tooltip on tap.

---

## States

### Loading — Shimmer Skeletons

```
┌─────────────────────────────┐
│  ░░░░░░░░░░░░░░░░░░░░░░░░  │  ← Image shimmer
│  ░░░░░░░░░░░░░░░░░░░░░░░░  │
├─────────────────────────────┤
│  ░░░░░░░░                   │  ← Price
│  ░░░░░░░░░░░░░░░            │  ← Title
│  ░░░░░░░░░░                 │  ← Location
└─────────────────────────────┘
```

Sweep: left-to-right gradient, 1.5s loop. `shimmer` package. Shape matches content.

### Empty States

| Screen | Icon | Message (NL) | Action |
|:-------|:-----|:-------------|:-------|
| Search | 🔍 | "Geen resultaten gevonden" | "Bewaar zoekopdracht" |
| Favourites | ♡ | "Nog geen favorieten" | "Ontdek items" |
| Messages | 💬 | "Nog geen berichten" | "Start met zoeken" |
| My Listings | 📦 | "Je hebt nog niets te koop" | "Plaats je eerste advertentie" |
| Orders | 🛍️ | "Nog geen bestellingen" | "Zoek items" |

Never a blank screen. Always illustration + message + action button.

### Error State

Retry button always present. Offline: cached content + "Je bent offline" banner.

---

## Navigation

### Bottom Nav (5 tabs + FAB)

```
🏠 Home  |  🔍 Zoeken  |  [+Verkoop]  |  💬 Berichten  |  👤 Profiel
```

| Tab | Phosphor Icon | NL | EN |
|:----|:-------------|:---|:---|
| 1 | `PhosphorIcons.house` | Home | Home |
| 2 | `PhosphorIcons.magnifyingGlass` | Zoeken | Search |
| 3 (FAB) | `PhosphorIcons.plus` | Verkoop | Sell |
| 4 | `PhosphorIcons.chatCircle` | Berichten | Messages |
| 5 | `PhosphorIcons.user` | Profiel | Profile |

- Active: `primary` orange, **bold** icon weight
- Inactive: `neutral-500`, regular weight
- Messages badge: red dot + count (white on `error`)
- Min tap target: 48×48px
- Persists via `StatefulShellRoute` (GoRouter)

### App Bar Patterns

| Screen | Style |
|:-------|:------|
| Home | Transparent → white on scroll; logo left, bell right |
| Search | Search input replaces title; filter icon right |
| Listing Detail | Transparent over image → white on scroll; back + share + ♡ |
| Profile | Collapsing header with avatar + stats |
| Transaction | Standard white with title + back |

---

## Icons

**Phosphor Icons** (not Material Symbols).

| Weight | Usage |
|:-------|:------|
| Regular | Default for all UI icons |
| Bold | Active/selected navigation |
| Fill | Favourite hearts, selected states |
| Duotone | Trust badges, category icons |

| Size | px | Usage |
|:-----|:---|:------|
| xs | 16 | Inline with small text |
| sm | 20 | Inside buttons |
| md | 24 | Navigation, cards |
| lg | 32 | Empty states |
| xl | 48 | Onboarding |

---

## Categories

### L1 Categories

| Icon | Phosphor Duotone | NL | EN | Example L2 |
|:-----|:----------------|:---|:---|:-----------|
| 🚗 | `carDuotone` | Voertuigen | Vehicles | Auto's, Motoren, Fietsen |
| 📱 | `devicesDuotone` | Elektronica | Electronics | Telefoons, Computers, Gaming |
| 🛋️ | `armchairDuotone` | Huis & Meubels | Home & Furniture | Meubels, Keuken, Tuin |
| 👗 | `tShirtDuotone` | Kleding & Mode | Clothing & Fashion | Dames, Heren, Schoenen |
| ⚽ | `bicycleDuotone` | Sport & Vrije tijd | Sports & Leisure | Fitness, Kamperen |
| 🧸 | `babyDuotone` | Kinderen & Baby's | Kids & Baby | Speelgoed, Kinderwagens |
| 🔧 | `wrenchDuotone` | Diensten | Services | Klussen, Les, Verhuizen |
| 📦 | `packageDuotone` | Overig | Other | Verzamelen, Dieren, Tickets |

**Display:** Home = horizontal scroll row (duotone icons + labels). Search = vertical list with L2 subcategories expanding on tap.
