# DeelMarkt — Master Design System

> **Version:** 1.0 FINAL | March 2026 | CONFIDENTIAL
> **Platform:** Flutter (iOS + Android) + Web (Next.js Phase 2)
> **Compliance:** WCAG 2.2 Level AA | European Accessibility Act | DSA

---

## Table of Contents

1. [Brand Foundation](#1-brand-foundation)
2. [Color System](#2-color-system)
3. [Typography](#3-typography)
4. [Spacing & Layout Grid](#4-spacing--layout-grid)
5. [Elevation & Shadows](#5-elevation--shadows)
6. [Border Radius](#6-border-radius)
7. [Iconography](#7-iconography)
8. [Trust & Safety UI System](#8-trust--safety-ui-system)
9. [Escrow Payment Flow UI](#9-escrow-payment-flow-ui)
10. [Progressive KYC UI](#10-progressive-kyc-ui)
11. [Component Library](#11-component-library)
12. [Card System](#12-card-system)
13. [Button System](#13-button-system)
14. [Navigation](#14-navigation)
15. [Search & Discovery UI](#15-search--discovery-ui)
16. [Chat & Messaging UI](#16-chat--messaging-ui)
17. [Listing Creation Flow (Snap-to-List)](#17-listing-creation-flow-snap-to-list)
18. [Shipping & Logistics UI](#18-shipping--logistics-ui)
19. [Sustainability & Eco UI](#19-sustainability--eco-ui)
20. [Bilingual & Localisation Patterns](#20-bilingual--localisation-patterns)
21. [States: Loading, Empty, Error](#21-states-loading-empty-error)
22. [Motion & Animation](#22-motion--animation)
23. [Accessibility (WCAG 2.2 AA)](#23-accessibility-wcag-22-aa)
24. [Dark Mode](#24-dark-mode)
25. [Responsive & Adaptive Breakpoints](#25-responsive--adaptive-breakpoints)
26. [Listing Detail Page](#26-listing-detail-page)
27. [Seller & Buyer Mode UI](#27-seller--buyer-mode-ui)
28. [Notification & Feedback System](#28-notification--feedback-system)
29. [Category Structure](#29-category-structure)
30. [Flutter Architecture & Folder Structure](#30-flutter-architecture--folder-structure)
31. [Design Tokens Reference](#31-design-tokens-reference)

---

## 1. Brand Foundation

### 1.1 Brand Principles

| Principle | Expression |
|---|---|
| ♻️ Reuse & Sustainability | Every screen subtly reinforces circular economy — CO2 badges, eco-scores, "Deel wat je hebt" |
| 🤝 Trust First | Verification badges, escrow visibility, dispute resolution paths visible on every transaction screen |
| 📍 Local Discovery | Distance indicators, map toggles, neighbourhood-level browse |
| 🚗 Full Category Breadth | From clothing to cars — the design must scale from €5 items to €50,000 vehicles |
| 🌍 Inclusive & Multilingual | NL/EN from Day 1; never assume Dutch-only; expat-friendly at every touchpoint |

### 1.2 Design Personality

| Trait | What It Means in Practice | What to Avoid |
|---|---|---|
| **Friendly** | Warm orange accents, rounded corners, conversational microcopy | Cold, corporate blue-grey monotone |
| **Trustworthy** | Verification badges, escrow timelines, transparent fees always visible | Hidden costs, ambiguous status indicators |
| **Clean** | Generous whitespace, clear hierarchy, single primary action per screen | Cluttered layouts, competing CTAs |
| **Practical** | Information density where needed (filters, seller stats), fast interactions | Decorative-only elements that add no function |
| **Slightly Playful** | Lottie micro-animations on success states, emoji in categories, celebration on first sale | Childish, gimmicky, or distracting animations |

### 1.3 Brand Voice in UI

- Microcopy is conversational, never robotic: "Bijna klaar!" not "Stap 3 van 4"
- Error messages are helpful, never blaming: "Dat lukte niet — probeer opnieuw" not "Ongeldige invoer"
- Success states celebrate the user: "Verkocht! 🎉" not "Transactie voltooid"
- All UI text exists in both NL and EN; never hardcode strings

---

## 2. Color System

### 2.1 Primary Palette

| Token | Name | Hex | RGB | Usage |
|---|---|---|---|---|
| `primary` | DeelMarkt Orange | `#F15A24` | 241, 90, 36 | Brand identity, primary CTAs, FAB, active states |
| `primary-light` | Orange Light | `#FF8A5C` | 255, 138, 92 | Hover/pressed states, secondary highlights |
| `primary-surface` | Orange Surface | `#FFF3EE` | 255, 243, 238 | Orange-tinted backgrounds, selected chips |
| `secondary` | Marketplace Blue | `#1E4F7A` | 30, 79, 122 | Headers, links, navigation active, trust badges |
| `secondary-light` | Blue Light | `#2D6FA3` | 45, 111, 163 | Hover states, secondary actions |
| `secondary-surface` | Blue Surface | `#EAF5FF` | 234, 245, 255 | Blue-tinted backgrounds, info banners |

### 2.2 Semantic Palette

| Token | Name | Hex | Usage |
|---|---|---|---|
| `success` | Green | `#2EAD4A` | Success states, verified badges, escrow released, eco-scores |
| `success-surface` | Green Surface | `#E8F8EC` | Success background banners |
| `warning` | Warm Yellow | `#FFC857` | Warnings, pending states, escrow held |
| `warning-surface` | Yellow Surface | `#FFF8E6` | Warning background banners |
| `error` | Red | `#E53E3E` | Errors, scam alerts, failed transactions, destructive actions |
| `error-surface` | Red Surface | `#FDE8E8` | Error background banners |
| `info` | Info Blue | `#3B82F6` | Informational notices, tooltips |
| `info-surface` | Info Surface | `#EFF6FF` | Info background banners |

### 2.3 Neutral Palette

| Token | Name | Hex | Usage |
|---|---|---|---|
| `neutral-900` | Near Black | `#1A1A1A` | Primary text, headings |
| `neutral-700` | Dark Grey | `#555555` | Secondary text, labels |
| `neutral-500` | Mid Grey | `#8A8A8A` | Placeholder text, disabled |
| `neutral-300` | Light Grey | `#D1D5DB` | Borders, dividers |
| `neutral-200` | Lighter Grey | `#E5E5E5` | Input borders, card strokes |
| `neutral-100` | Near White | `#F3F4F6` | Subtle backgrounds, disabled surfaces |
| `neutral-50` | Background | `#F8F9FB` | App scaffold background |
| `neutral-0` | White | `#FFFFFF` | Cards, modals, input backgrounds |

### 2.4 Trust & Verification Colours

These are dedicated colours used ONLY within the trust system — never for general UI:

| Token | Name | Hex | Usage |
|---|---|---|---|
| `trust-verified` | Trust Green | `#16A34A` | iDIN verified badge, escrow protected |
| `trust-escrow` | Escrow Blue | `#2563EB` | Escrow active indicator, funds held |
| `trust-warning` | Scam Warning | `#DC2626` | Scam detection alerts, suspicious activity |
| `trust-pending` | KYC Pending | `#F59E0B` | Verification in progress |
| `trust-shield` | Shield Background | `#F0FDF4` | Trust badge background surface |

### 2.5 Flutter Theme Setup

```dart
class DeelmarktColors {
  // Primary
  static const primary = Color(0xFFF15A24);
  static const primaryLight = Color(0xFFFF8A5C);
  static const primarySurface = Color(0xFFFFF3EE);
  static const secondary = Color(0xFF1E4F7A);
  static const secondaryLight = Color(0xFF2D6FA3);
  static const secondarySurface = Color(0xFFEAF5FF);

  // Semantic
  static const success = Color(0xFF2EAD4A);
  static const successSurface = Color(0xFFE8F8EC);
  static const warning = Color(0xFFFFC857);
  static const warningSurface = Color(0xFFFFF8E6);
  static const error = Color(0xFFE53E3E);
  static const errorSurface = Color(0xFFFDE8E8);

  // Neutral
  static const neutral900 = Color(0xFF1A1A1A);
  static const neutral700 = Color(0xFF555555);
  static const neutral500 = Color(0xFF8A8A8A);
  static const neutral300 = Color(0xFFD1D5DB);
  static const neutral200 = Color(0xFFE5E5E5);
  static const neutral100 = Color(0xFFF3F4F6);
  static const neutral50 = Color(0xFFF8F9FB);
  static const white = Color(0xFFFFFFFF);

  // Trust (dedicated — never for general UI)
  static const trustVerified = Color(0xFF16A34A);
  static const trustEscrow = Color(0xFF2563EB);
  static const trustWarning = Color(0xFFDC2626);
  static const trustPending = Color(0xFFF59E0B);
  static const trustShield = Color(0xFFF0FDF4);
}

class DeelmarktTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    primaryColor: DeelmarktColors.primary,
    scaffoldBackgroundColor: DeelmarktColors.neutral50,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: DeelmarktColors.primary,
      onPrimary: Colors.white,
      secondary: DeelmarktColors.secondary,
      onSecondary: Colors.white,
      error: DeelmarktColors.error,
      onError: Colors.white,
      surface: DeelmarktColors.white,
      onSurface: DeelmarktColors.neutral900,
      // M3 additions
      surfaceContainerLowest: DeelmarktColors.white,
      surfaceContainerLow: DeelmarktColors.neutral50,
      surfaceContainer: DeelmarktColors.neutral100,
      outline: DeelmarktColors.neutral300,
      outlineVariant: DeelmarktColors.neutral200,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: DeelmarktColors.neutral900,
      elevation: 0,
      scrolledUnderElevation: 1,
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: DeelmarktColors.neutral200, width: 1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: DeelmarktColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'PlusJakartaSans',
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DeelmarktColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: DeelmarktColors.neutral200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: DeelmarktColors.neutral200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: DeelmarktColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: DeelmarktColors.error),
      ),
    ),
  );
}
```

---

## 3. Typography

### 3.1 Font Selection

**Primary Font: Plus Jakarta Sans**

Why this over Inter:
- More distinctive character; avoids the "every SaaS app" look of Inter
- Excellent weight range (ExtraLight to ExtraBold)
- Slightly geometric with warm terminals — matches the "friendly + trustworthy" brand
- Strong readability on mobile at small sizes
- Open source (SIL OFL); free for commercial use
- Excellent Dutch/extended Latin character support (diacritics: ë, é, ü)

**Fallback chain:** `'Plus Jakarta Sans', 'Inter', system-ui, -apple-system, sans-serif`

**Monospace (code/prices):** `JetBrains Mono` for any code display; prices use the primary font with tabular figures.

### 3.2 Type Scale

| Token | Size (px) | Line Height | Weight | Tracking | Usage |
|---|---|---|---|---|---|
| `display` | 32 | 40 (1.25) | Bold (700) | -0.02em | Hero sections, onboarding titles |
| `heading-lg` | 24 | 32 (1.33) | Bold (700) | -0.01em | Page titles, section headers |
| `heading-md` | 20 | 28 (1.4) | SemiBold (600) | 0 | Card group titles, modal headers |
| `heading-sm` | 18 | 24 (1.33) | SemiBold (600) | 0 | Subsection headers |
| `body-lg` | 16 | 24 (1.5) | Regular (400) | 0 | Primary body text, descriptions |
| `body-md` | 14 | 20 (1.43) | Regular (400) | 0 | Secondary text, metadata, timestamps |
| `body-sm` | 12 | 16 (1.33) | Medium (500) | 0.01em | Captions, badges, helper text |
| `label` | 14 | 20 (1.43) | SemiBold (600) | 0.01em | Button labels, form labels, chip text |
| `price` | 20 | 24 (1.2) | Bold (700) | 0 | Listing price display |
| `price-sm` | 16 | 20 (1.25) | Bold (700) | 0 | Price in card view |
| `overline` | 11 | 16 (1.45) | SemiBold (600) | 0.08em | Category labels, status badges (uppercase) |

### 3.3 Flutter TextTheme

```dart
class DeelmarktTypography {
  static const fontFamily = 'PlusJakartaSans';

  static TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, height: 1.25, letterSpacing: -0.64),
    headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, height: 1.33, letterSpacing: -0.24),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 1.4),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.33),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.43),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, height: 1.33, letterSpacing: 0.12),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.43, letterSpacing: 0.14),
    labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, height: 1.45, letterSpacing: 0.88),
  );

  // Custom tokens not in Material
  static const TextStyle price = TextStyle(fontSize: 20, fontWeight: FontWeight.w700, height: 1.2);
  static const TextStyle priceSm = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, height: 1.25);
}
```

### 3.4 Price Display Rules

Prices always use tabular figures (`fontFeatures: [FontFeature.tabularFigures()]`) for alignment in lists. Euro symbol precedes the value with no space: `€12,50`. Use comma as decimal separator (Dutch convention). Always display BTW status on transaction screens: "incl. BTW" or "excl. BTW".

---

## 4. Spacing & Layout Grid

### 4.1 Base Unit: 4px

All spacing is a multiple of 4px. The primary rhythm uses 8px increments.

| Token | Size (px) | Usage |
|---|---|---|
| `space-1` | 4 | Inline spacing, icon-to-text gap |
| `space-2` | 8 | Tight padding, between related elements |
| `space-3` | 12 | Card internal padding, list item gap |
| `space-4` | 16 | Section padding, standard gap |
| `space-5` | 20 | Medium separation |
| `space-6` | 24 | Between content groups |
| `space-8` | 32 | Section separation |
| `space-10` | 40 | Large section breaks |
| `space-12` | 48 | Page-level vertical padding |
| `space-16` | 64 | Hero/splash spacing |

### 4.2 Screen Margins

| Context | Horizontal Margin |
|---|---|
| Mobile (< 600px) | 16px |
| Tablet (600–1024px) | 24px |
| Desktop (> 1024px) | Max content width: 1200px, centred |

### 4.3 Flutter Spacing Constants

```dart
class Spacing {
  static const double s1 = 4;
  static const double s2 = 8;
  static const double s3 = 12;
  static const double s4 = 16;
  static const double s5 = 20;
  static const double s6 = 24;
  static const double s8 = 32;
  static const double s10 = 40;
  static const double s12 = 48;
  static const double s16 = 64;

  // Screen margins
  static const double screenMarginMobile = 16;
  static const double screenMarginTablet = 24;

  // Grid
  static const double listingCardGap = 12;
  static const double sectionGap = 32;
}
```

---

## 5. Elevation & Shadows

Material 3 approach — use sparingly. Cards use border strokes by default; shadows reserved for floating elements.

| Level | Usage | Shadow Definition |
|---|---|---|
| `elevation-0` | Cards, inputs, flat surfaces | No shadow; 1px border `neutral-200` |
| `elevation-1` | Sticky headers, scrolled app bar | `0 1px 3px rgba(0,0,0,0.08)` |
| `elevation-2` | Dropdowns, popovers, tooltips | `0 4px 12px rgba(0,0,0,0.1)` |
| `elevation-3` | Modals, bottom sheets | `0 8px 24px rgba(0,0,0,0.12)` |
| `elevation-4` | FAB, floating action elements | `0 12px 32px rgba(0,0,0,0.15)` |

```dart
class DeelmarktShadows {
  static const elevation1 = [BoxShadow(offset: Offset(0, 1), blurRadius: 3, color: Color(0x14000000))];
  static const elevation2 = [BoxShadow(offset: Offset(0, 4), blurRadius: 12, color: Color(0x1A000000))];
  static const elevation3 = [BoxShadow(offset: Offset(0, 8), blurRadius: 24, color: Color(0x1F000000))];
  static const elevation4 = [BoxShadow(offset: Offset(0, 12), blurRadius: 32, color: Color(0x26000000))];
}
```

---

## 6. Border Radius

| Token | Size (px) | Usage |
|---|---|---|
| `radius-xs` | 6 | Small badges, tags |
| `radius-sm` | 8 | Chips, small buttons |
| `radius-md` | 10 | Inputs, text fields |
| `radius-lg` | 12 | Buttons, images, action items |
| `radius-xl` | 16 | Cards, modals, bottom sheets |
| `radius-2xl` | 24 | Image gallery, large containers |
| `radius-full` | 999 | Avatars, circular badges, pills |

```dart
class DeelmarktRadius {
  static const xs = 6.0;
  static const sm = 8.0;
  static const md = 10.0;
  static const lg = 12.0;
  static const xl = 16.0;
  static const xxl = 24.0;
  static const full = 999.0;
}
```

---

## 7. Iconography

### 7.1 Icon Set

**Primary: Phosphor Icons (Phosphor Flutter)**

Why Phosphor over Material Symbols:
- More distinctive; avoids the "default Flutter app" look
- 6 weights: thin, light, regular, bold, fill, duotone — matches the brand's weight system
- 9,000+ icons including marketplace-relevant glyphs
- Open source MIT licence

**Usage weights:**
- **Regular** — default for all navigation and UI icons
- **Bold** — active/selected navigation items
- **Fill** — favourite hearts, selected states
- **Duotone** — trust badges, category icons (adds the "slightly playful" feel)

### 7.2 Icon Sizes

| Token | Size (px) | Usage |
|---|---|---|
| `icon-xs` | 16 | Inline with small text, badges |
| `icon-sm` | 20 | Inside buttons, list items |
| `icon-md` | 24 | Standard navigation, cards |
| `icon-lg` | 32 | Empty states, section headers |
| `icon-xl` | 48 | Onboarding, feature highlights |

### 7.3 Navigation Icons

| Position | Icon | Label (NL) | Label (EN) |
|---|---|---|---|
| Tab 1 | `PhosphorIcons.house` | Home | Home |
| Tab 2 | `PhosphorIcons.magnifyingGlass` | Zoeken | Search |
| Tab 3 (FAB) | `PhosphorIcons.plus` | Verkoop | Sell |
| Tab 4 | `PhosphorIcons.chatCircle` | Berichten | Messages |
| Tab 5 | `PhosphorIcons.user` | Profiel | Profile |

### 7.4 Marketplace Category Icons (Duotone)

| Category | Icon |
|---|---|
| Voertuigen / Vehicles | `PhosphorIcons.carDuotone` |
| Elektronica / Electronics | `PhosphorIcons.devicesDuotone` |
| Huis & Meubels / Home | `PhosphorIcons.armchairDuotone` |
| Kleding / Clothing | `PhosphorIcons.tShirtDuotone` |
| Sport | `PhosphorIcons.bicycleDuotone` |
| Kinderen / Kids | `PhosphorIcons.babyDuotone` |
| Diensten / Services | `PhosphorIcons.wrenchDuotone` |
| Overig / Other | `PhosphorIcons.packageDuotone` |

---

## 8. Trust & Safety UI System

This is DeelMarkt's primary differentiator. Trust components must be visually consistent and immediately recognisable across every screen.

### 8.1 Verification Badge System

| Badge | Visual | Trigger | Colour |
|---|---|---|---|
| **Email Verified** | ✉️ small checkmark | KYC Level 0 complete | `neutral-500` |
| **Phone Verified** | 📱 small checkmark | KYC Level 0 complete | `neutral-500` |
| **iDIN Verified** | 🛡️ shield with checkmark | KYC Level 2 complete | `trust-verified` green |
| **ID Verified** | 🪪 shield with star | KYC Level 3 (Onfido) | `trust-verified` green with gold accent |
| **Business Seller** | 🏢 KVK badge | KYC Level 4 | `secondary` blue |
| **Escrow Protected** | 🔒 lock icon | Transaction uses escrow | `trust-escrow` blue |
| **Top Seller** | ⭐ star badge | Performance-based | `warning` gold |

### 8.2 Badge Display Rules

- Verification badges appear on: seller profile, listing cards (small inline), chat headers, transaction screens
- Maximum 3 badges visible inline; overflow to "View all" tap
- iDIN badge is always the first/leftmost badge — it's the highest-value trust signal
- Badges never animate or pulse — trust should feel stable, not attention-seeking
- Badge tooltips explain the verification on tap

### 8.3 Trust Banner Component

Appears at the top of listing detail and transaction screens:

```
┌──────────────────────────────────────────┐
│ 🛡️  Beschermd met DeelMarkt Escrow       │
│     Je geld is veilig tot levering.      │
│                              Meer info → │
└──────────────────────────────────────────┘
```

- Background: `trust-shield` (`#F0FDF4`)
- Border-left: 3px solid `trust-verified` (`#16A34A`)
- Icon: Shield in `trust-verified` green

### 8.4 Scam Detection Alert

Triggered by AI when suspicious patterns detected in chat:

```
┌──────────────────────────────────────────┐
│ ⚠️  Let op: dit bericht bevat een link   │
│     naar een externe betaalsite.         │
│     Betaal alleen via DeelMarkt Escrow.  │
│                                          │
│     [ Negeer ]  [ Meld verdacht gedrag ] │
└──────────────────────────────────────────┘
```

- Background: `error-surface` (`#FDE8E8`)
- Border-left: 3px solid `trust-warning` (`#DC2626`)
- Appears inline in the chat, not as a popup

### 8.5 Seller Trust Score

Displayed on seller profiles and listing detail:

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

## 9. Escrow Payment Flow UI

The escrow timeline is the most critical UI component — it makes the invisible (fund holding) visible and trustworthy.

### 9.1 Escrow Timeline Stepper

Horizontal stepper shown on transaction detail:

```
 ● ─────── ● ─────── ○ ─────── ○ ─────── ○
Betaald   Verzonden  Bezorgd   Bevestigd  Uitbetaald
(Paid)    (Shipped)  (Delivered)(Confirmed)(Released)
```

| Step | State | Visual | Colour |
|---|---|---|---|
| Betaald (Paid) | Complete | Filled circle + checkmark | `trust-escrow` blue |
| Verzonden (Shipped) | Complete | Filled circle + checkmark | `trust-escrow` blue |
| Bezorgd (Delivered) | Active / current | Pulsing circle | `primary` orange |
| Bevestigd (Confirmed) | Pending | Empty circle | `neutral-300` |
| Uitbetaald (Released) | Pending | Empty circle | `neutral-300` |

- Connecting line: solid for completed steps, dashed for pending
- Each step is tappable → shows detail modal with timestamp and action
- "Bezorgd" step shows countdown: "48 uur om te bevestigen" (48 hours to confirm)

### 9.2 Payment Summary Card

Shown before buyer commits:

```
┌──────────────────────────────────────┐
│  Bestelling overzicht                │
│                                      │
│  Vintage stoel               €45,00  │
│  Platformkosten               €1,63  │
│  Verzendkosten                €6,95  │
│  ─────────────────────────────────── │
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

- All costs visible before the buy button — no hidden fees
- iDEAL is always the default/primary payment method (with bank logo)
- Escrow protection callout is always visible
- "incl. BTW" label is mandatory on every price total

---

## 10. Progressive KYC UI

### 10.1 Verification Prompt Pattern

KYC prompts appear contextually, never as a blocking wall:

| Level | Trigger Moment | Prompt Style |
|---|---|---|
| Level 0 → 1 | First message attempt | Inline banner: "Verifieer je e-mail om te chatten" |
| Level 1 → 2 | First listing attempt | Bottom sheet: "Bevestig je identiteit om te verkopen" (iDIN flow) |
| Level 2 → 3 | First escrow transaction | Full-screen: "Laatste stap: foto-verificatie" (Onfido) |
| Level 3 → 4 | €2,500+ monthly sales | Banner on seller dashboard: "Word zakelijk verkoper" |

### 10.2 Verification Progress Indicator

Shown on profile screen:

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

- Completed levels show green checkmarks
- Next available level has an action arrow
- Future levels are greyed out
- Progress bar encourages completion without forcing it

---

## 11. Component Library

### 11.1 Core Components

| Component | Description | Priority |
|---|---|---|
| `DeelButton` | Primary, secondary, outline, text, destructive variants | P0 |
| `DeelCard` | Listing card (grid/list), seller card, transaction card | P0 |
| `DeelInput` | Text, search, password, price (€ prefix), postcode (NL format) | P0 |
| `DeelBadge` | Trust badges, status badges, notification counts | P0 |
| `DeelChip` | Filter chips (category, condition, distance), selectable | P0 |
| `DeelAvatar` | User avatar with verification badge overlay | P0 |
| `PriceTag` | Formatted price display with BTW, strikethrough for offers | P0 |
| `TrustBanner` | Escrow protection banner, scam alert banner | P0 |
| `EscrowTimeline` | Horizontal stepper for payment flow | P0 |
| `SearchBar` | Autocomplete with recent + trending suggestions | P0 |
| `LocationBadge` | Distance indicator with pin icon | P0 |
| `ImageGallery` | Swipe gallery with dot indicators, zoom, upload preview | P0 |
| `CategoryIcon` | Duotone category icon with label | P1 |
| `OfferButton` | "Doe een bod" (Make offer) with price input | P1 |
| `RatingDisplay` | Star rating + review count | P1 |
| `ShippingQR` | QR code display for label-free shipping | P1 |
| `TrackingTimeline` | Vertical stepper for shipping status | P1 |
| `EcoBadge` | CO2 savings display, sustainability score | P2 |
| `LanguageSwitch` | NL/EN toggle (accessible, always visible) | P0 |
| `EmptyState` | Illustrated empty state with action button | P0 |
| `ErrorState` | Error with retry button | P0 |
| `SkeletonLoader` | Shimmer loading placeholders | P0 |

---

## 12. Card System

### 12.1 Listing Card (Grid View)

The most-seen component in the app. Must load fast and communicate trust instantly.

```
┌─────────────────────────────┐
│                             │
│     [ Image 4:3 ratio ]     │
│                     ♡       │  ← Favourite button overlay
│  🛡️                         │  ← Trust badge overlay (if verified)
├─────────────────────────────┤
│  €45,00                     │  ← price (bold, price-sm token)
│  Vintage design stoel       │  ← title (body-md, max 2 lines)
│  📍 Amsterdam · 2,3 km      │  ← location + distance (body-sm, neutral-500)
│  🟢 Escrow beschikbaar      │  ← escrow indicator (body-sm, trust-verified)
└─────────────────────────────┘
```

- Image aspect ratio: **4:3** (consistent grid, avoids layout shift)
- Card border: 1px `neutral-200`, no shadow (elevation-0)
- Card radius: `radius-xl` (16px)
- Favourite button: top-right, 44×44px tap target (WCAG 2.2), heart icon
- Shimmer placeholder while image loads
- Price ALWAYS first line below image — users scan for price first
- Title: max 2 lines, ellipsis overflow
- Distance: calculated from user location, shown as "X km"

### 12.2 Listing Card (List View)

```
┌────────┬──────────────────────────────┐
│        │  €45,00                      │
│ Image  │  Vintage design stoel        │
│ 1:1    │  📍 Amsterdam · 2,3 km       │
│  🛡️   │  🟢 Escrow · ⏱️ 3 uur geleden│
│        │                         ♡    │
└────────┴──────────────────────────────┘
```

- Image: square (1:1), 120×120px
- Same info hierarchy as grid card

### 12.3 Transaction Card

Shown in "My Orders" / "My Sales":

```
┌────────┬──────────────────────────────┐
│        │  Vintage design stoel        │
│ Image  │  €45,00 + €6,95 verzending   │
│ 1:1    │                              │
│        │  ● ── ● ── ○ ── ○ ── ○      │ ← Mini escrow timeline
│        │  Status: Verzonden 📦         │
│        │  [ Bekijk details → ]        │
└────────┴──────────────────────────────┘
```

### 12.4 Seller Card

Compact seller info shown on listing detail:

```
┌──────────────────────────────────────┐
│  🧑 [Avatar]  Jan de Vries           │
│               🛡️ iDIN · ⭐ 4.8 (127) │
│               📍 Amsterdam            │
│               ⏱️ Reageert < 1 uur     │
│                                      │
│  [ Bekijk profiel ]  [ Bericht → ]   │
└──────────────────────────────────────┘
```

---

## 13. Button System

### 13.1 Variants

| Variant | Background | Text | Border | Usage |
|---|---|---|---|---|
| **Primary** | `primary` orange | White | None | Main CTA: "Koop nu", "Verkoop", "Betaal" |
| **Secondary** | `secondary` blue | White | None | "Bericht sturen", "Bod doen" |
| **Outline** | Transparent | `secondary` blue | 1.5px `secondary` | Secondary actions: "Bekijk profiel", "Delen" |
| **Ghost** | Transparent | `neutral-700` | None | Tertiary actions: "Annuleren", "Overslaan" |
| **Destructive** | `error` red | White | None | "Account verwijderen", "Transactie annuleren" |
| **Success** | `success` green | White | None | "Levering bevestigen", "Uitbetaling aanvragen" |

### 13.2 Sizes

| Size | Height | Padding (H) | Font Size | Usage |
|---|---|---|---|---|
| Large | 52px | 24px | 16px | Primary page CTAs, full-width |
| Medium | 44px | 16px | 14px | In-card actions, dialogs |
| Small | 36px | 12px | 13px | Inline actions, chips |

### 13.3 States

All buttons have 5 states: default, hover/pressed (10% darker), focused (2px outline offset), disabled (40% opacity), loading (spinner replaces text).

### 13.4 FAB (Sell Button)

The "Sell" button is a custom FAB centred in the bottom nav:

```dart
FloatingActionButton.extended(
  onPressed: () => navigateToSell(),
  backgroundColor: DeelmarktColors.primary,
  icon: PhosphorIcons.plus(color: Colors.white),
  label: Text('Verkoop', style: TextStyle(fontWeight: FontWeight.w600)),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
)
```

- Elevated above the bottom nav bar
- Always visible; never hidden on scroll
- Orange with white icon + text

---

## 14. Navigation

### 14.1 Bottom Navigation Bar

5 tabs with centred FAB for "Sell":

```
┌─────────────────────────────────────────────┐
│  🏠        🔍        [+Verkoop]  💬    👤   │
│  Home    Zoeken                Berichten Profiel│
└─────────────────────────────────────────────┘
```

- Active tab: `primary` orange, bold icon weight
- Inactive: `neutral-500`, regular icon weight
- Badge on Messages tab: red dot with unread count (white text on `error` red)
- Bottom nav persists via `StatefulShellRoute` (GoRouter)
- FAB is physically elevated above the bar
- Minimum tap target: 48×48px per tab (WCAG 2.2)

### 14.2 App Bar Patterns

| Screen Type | App Bar Style |
|---|---|
| Home | Transparent → white on scroll; logo left, notification bell right |
| Search | Search input replaces title; filter icon right |
| Listing Detail | Transparent over image → white on scroll; back + share + favourite |
| Profile | Collapsing header with avatar and stats |
| Transaction | Standard white with title and back button |

---

## 15. Search & Discovery UI

### 15.1 Search Bar

```
┌──────────────────────────────────────┐
│  🔍  Zoek op Deelmarkt...     ⚙️    │  ← Filter icon right
└──────────────────────────────────────┘
```

- Persistent at top of Home and Search tabs
- On tap → expands to full search experience with:
  - Recent searches (with clear all)
  - Trending searches
  - Suggested categories

### 15.2 Filter System

Filter bar appears below search on results screen:

```
[ Categorie ▼ ]  [ Prijs ▼ ]  [ Afstand ▼ ]  [ Conditie ▼ ]  [ Meer ▼ ]
```

- Horizontally scrollable chip row
- Active filters: filled chip in `primary-surface` with `primary` text
- Inactive filters: outline chip
- "Meer" opens full filter bottom sheet
- Applied filter count shown as badge: `[ Prijs (1) ▼ ]`

### 15.3 Map Toggle

Toggle between list/grid and map view:

```
[ ≡ Lijst ]  [ 🗺️ Kaart ]
```

Map view shows listing pins with price labels. Tap pin → listing card preview.

### 15.4 Empty Search State

```
┌──────────────────────────────────────┐
│                                      │
│        🔍  (large, grey)             │
│                                      │
│  Geen resultaten voor "xyz"          │
│                                      │
│  Probeer:                            │
│  · Andere zoektermen                 │
│  · Minder filters                    │
│  · Grotere afstand                   │
│                                      │
│  [ Bewaar zoekopdracht 🔔 ]          │  ← Saved search with alert
└──────────────────────────────────────┘
```

---

## 16. Chat & Messaging UI

### 16.1 Chat Thread Header

```
┌──────────────────────────────────────┐
│ ← Jan de Vries  🛡️ iDIN             │
│   ⏱️ Reageert < 1 uur                │
├──────────────────────────────────────┤
│ ┌────────────────────────────────┐   │
│ │ 📷 Vintage stoel  ·  €45,00   │   │  ← Embedded listing card
│ │ 🟢 Escrow beschikbaar         │   │
│ └────────────────────────────────┘   │
├──────────────────────────────────────┤
```

- Listing card always pinned at top of conversation
- Seller verification badges visible in header
- Response time indicator builds buyer confidence

### 16.2 Quick Actions in Chat

Below the listing card:

```
[ Doe een bod 💰 ]  [ Plan afhalen 📍 ]
```

- "Doe een bod" opens price input → sends structured offer message
- "Plan afhalen" opens map with meetup location selector

### 16.3 Scam Detection Inline Warning

When AI detects suspicious message content:

```
│  Seller: Stuur geld via tikkie.me/pay/xyz   │
│                                              │
│  ┌─ ⚠️ Waarschuwing ─────────────────────┐  │
│  │ Dit bericht bevat een link naar een    │  │
│  │ externe betaalsite. Betaal alleen via  │  │
│  │ DeelMarkt Escrow voor bescherming.     │  │
│  │                                        │  │
│  │ [ Negeer ]  [ Meld verdacht gedrag 🚨 ]│  │
│  └────────────────────────────────────────┘  │
```

### 16.4 Structured Offer Message

```
┌──────────────────────────────────────┐
│  💰 Bod van €35,00                   │
│     op: Vintage design stoel (€45,00)│
│                                      │
│  [ Accepteren ✅ ]  [ Afwijzen ✗ ]   │
│  [ Tegenbod doen ↩️ ]                │
└──────────────────────────────────────┘
```

---

## 17. Listing Creation Flow (Snap-to-List)

### 17.1 Flow Diagram

```
[+Verkoop] tap
    │
    ▼
┌─ Camera ─────────────────┐     Phase 1: Manual form
│  📷 Maak foto's          │     Phase 2: AI auto-fill
│  (1 min, max 12 foto's)  │
│                           │
│  [📷 Foto] [🖼️ Galerij]  │
└──────────┬────────────────┘
           │
           ▼
┌─ AI Pre-fill (Phase 2) ──┐
│  Categorie: Meubels       │  ← AI detected
│  Titel: Vintage design... │  ← AI generated
│  Prijs: €45,00 (hint)     │  ← AI suggested from comparables
│  [ Aanpassen → ]          │
└──────────┬────────────────┘
           │
           ▼
┌─ Listing Form ────────────┐
│  Titel: _______________   │
│  Prijs: € ____________    │
│  Categorie: [Meubels ▼]   │
│  Conditie: [Goed ▼]       │
│  Beschrijving: ________   │
│  📍 Amsterdam (auto)       │
│  🚚 Verzending / Afhalen   │
│                            │
│  Kwaliteitsscore: ████░ 4/5│  ← Listing quality indicator
│                            │
│  [ Concept opslaan ]      │
│  [ Plaats advertentie → ]  │
└────────────────────────────┘
```

### 17.2 Listing Quality Score

Airbnb-style quality indicator encouraging better listings:

| Score | Criteria |
|---|---|
| +1 | ≥ 3 photos |
| +1 | Description > 50 characters |
| +1 | Category + condition selected |
| +1 | Price within market range (AI) |
| +1 | Shipping option enabled |

Shown as a 5-segment bar with colour: 1–2 = red, 3 = yellow, 4–5 = green.

---

## 18. Shipping & Logistics UI

### 18.1 QR Code Shipping Card

Shown to seller after sale:

```
┌──────────────────────────────────────┐
│  📦 Verzend je pakket                │
│                                      │
│  ┌────────────────┐                  │
│  │   [QR CODE]    │  Scan bij een    │
│  │                │  PostNL punt of  │
│  │                │  DHL ServicePoint│
│  └────────────────┘                  │
│                                      │
│  Verzend voor: do 20 mrt, 18:00     │
│                                      │
│  [ Zoek servicepunt 📍 ]             │
└──────────────────────────────────────┘
```

### 18.2 Tracking Timeline (Vertical)

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

### 18.3 Dutch Address Input

Three-field pattern with PostNL auto-fill:

```
┌──────────────────────────────────────┐
│  Postcode    [ 1012 AB ]             │  ← 4 digits + 2 letters
│  Straat      [ Damrak       ] (auto) │  ← Auto-filled from postcode
│  Huisnr.     [ 1    ] Toev. [ A  ]  │  ← Number + optional addition
│  Stad        [ Amsterdam    ] (auto) │  ← Auto-filled from postcode
└──────────────────────────────────────┘
```

---

## 19. Sustainability & Eco UI

### 19.1 CO2 Savings Badge

Shown on listing cards and transaction confirmations:

```
  🌿 −2,4 kg CO2 bespaard
```

- Small, non-intrusive, green text with leaf icon
- Shown on listing detail below price
- On transaction confirmation: "Met deze aankoop heb je 2,4 kg CO2 bespaard!"

### 19.2 Seller Eco Score (Phase 2)

```
  ♻️ Eco Score: ████░  B
```

Based on: number of items sold secondhand, packaging sustainability, shipping distance.

---

## 20. Bilingual & Localisation Patterns

### 20.1 Language Switch

Always accessible — never hidden in deep settings:

```
┌────────────┐
│  NL │ EN   │  ← Toggle in profile header + onboarding
└────────────┘
```

- Segmented control style, not a dropdown
- Changing language is instant (no reload)
- User preference persisted locally and in backend profile

### 20.2 Localisation Rules

| Element | Dutch (NL) | English (EN) |
|---|---|---|
| Currency | €12,50 | €12.50 |
| Date | 16 mrt 2026 | 16 Mar 2026 |
| Date (full) | maandag 16 maart 2026 | Monday 16 March 2026 |
| Time | 14:30 | 14:30 (24h always in NL context) |
| Distance | 2,3 km | 2.3 km |
| Decimal separator | comma (,) | dot (.) |
| Thousands separator | dot (.) | comma (,) |
| Phone | +31 6 12345678 | +31 6 12345678 |
| Postcode | 1012 AB | 1012 AB |

### 20.3 Auto-Translation Indicator

When listing content is auto-translated:

```
  🌐 Automatisch vertaald uit het Engels  [ Toon origineel ]
```

Small, non-intrusive banner above translated content with toggle to show original.

### 20.4 String Key Convention

All UI strings use `easy_localization` with snake_case keys:

```dart
// ✅ Correct
'listing_card.escrow_available'.tr()
'payment.total_including_btw'.tr()

// ❌ Wrong — never hardcode
Text('Beschermd met escrow')
```

---

## 21. States: Loading, Empty, Error

### 21.1 Loading States

**Shimmer skeletons** for all content areas — never a spinner blocking the screen.

Listing card skeleton:
```
┌─────────────────────────────┐
│  ░░░░░░░░░░░░░░░░░░░░░░░░  │  ← Image placeholder (shimmer)
│  ░░░░░░░░░░░░░░░░░░░░░░░░  │
├─────────────────────────────┤
│  ░░░░░░░░                   │  ← Price
│  ░░░░░░░░░░░░░░░            │  ← Title
│  ░░░░░░░░░░                 │  ← Location
└─────────────────────────────┘
```

- Shimmer animation: left-to-right gradient sweep, 1.5s duration, infinite loop
- Skeleton shape matches the actual content layout
- Use `shimmer` Flutter package

### 21.2 Empty States

Every screen has a designed empty state — never a blank screen.

| Screen | Illustration | Message (NL) | Action |
|---|---|---|---|
| Search (no results) | Magnifying glass | "Geen resultaten gevonden" | "Bewaar zoekopdracht" |
| Favourites (empty) | Heart | "Nog geen favorieten" | "Ontdek items" |
| Messages (empty) | Chat bubble | "Nog geen berichten" | "Start met zoeken" |
| My Listings (empty) | Package | "Je hebt nog niets te koop" | "Plaats je eerste advertentie" |
| Orders (empty) | Shopping bag | "Nog geen bestellingen" | "Zoek items" |

### 21.3 Error States

```
┌──────────────────────────────────────┐
│                                      │
│        😕  (illustrated)             │
│                                      │
│  Er ging iets mis                    │
│  Controleer je verbinding en         │
│  probeer het opnieuw.                │
│                                      │
│  [ Opnieuw proberen ↻ ]             │
└──────────────────────────────────────┘
```

- Retry button always present
- For offline: show cached content with banner "Je bent offline — sommige gegevens zijn mogelijk verouderd"

---

## 22. Motion & Animation

### 22.1 Principles

- **Functional first:** Every animation serves navigation, feedback, or state change — never decoration
- **Fast:** Standard duration 200ms, complex transitions 300ms, never > 400ms
- **Easing:** `Curves.easeOutCubic` for entrances, `Curves.easeInCubic` for exits

### 22.2 Animation Inventory

| Interaction | Animation | Duration | Implementation |
|---|---|---|---|
| Favourite tap | Heart scale-up + fill + burst particles | 300ms | Lottie |
| Listing card tap | Hero transition (image expands to detail) | 300ms | `Hero` widget |
| "Verkocht!" confirmation | Checkmark draw + confetti | 800ms | Lottie |
| Pull-to-refresh | Custom DeelMarkt logo spin | Variable | `RefreshIndicator` |
| Page transition | Shared axis (horizontal) | 300ms | `PageRouteBuilder` |
| Bottom sheet open | Slide up + fade backdrop | 250ms | `showModalBottomSheet` |
| Offer sent | Message bubble fly-in | 200ms | `AnimatedContainer` |
| Escrow step complete | Step circle fill + line draw | 400ms | Custom painter |
| Skeleton loading | Left-to-right shimmer | 1500ms loop | `shimmer` package |
| Tab switch | Cross-fade | 200ms | `AnimatedSwitcher` |

### 22.3 Reduced Motion

Respect `MediaQuery.of(context).disableAnimations`. When true: all durations = 0, all animations replaced with instant state changes. This is a WCAG 2.2 requirement.

---

## 23. Accessibility (WCAG 2.2 AA)

### 23.1 Mandatory Requirements

The European Accessibility Act became enforceable June 28, 2025. Fines up to €100,000 or 4% of annual revenue. These are legal requirements, not guidelines.

| Criterion | Requirement | DeelMarkt Implementation |
|---|---|---|
| **1.4.3** Contrast (Minimum) | 4.5:1 for normal text, 3:1 for large text | All colour pairs validated; see §2 |
| **1.4.11** Non-text Contrast | 3:1 for UI components and graphics | All icons, borders, focus indicators validated |
| **2.4.7** Focus Visible | Visible focus indicator on all interactive elements | 2px `primary` outline with 2px offset |
| **2.4.11** Focus Not Obscured (NEW in 2.2) | Focused element must not be fully hidden by sticky headers/footers | Bottom nav and app bar never overlap focused content |
| **2.5.7** Dragging Movements (NEW in 2.2) | Alternative to drag: single-pointer operation | Image reorder: drag OR up/down buttons; filter sliders have text input |
| **2.5.8** Target Size (Minimum) (NEW in 2.2) | 24×24px minimum, 44×44px recommended | All interactive targets ≥ 44×44px; spacing ≥ 8px between targets |
| **3.2.6** Consistent Help (NEW in 2.2) | Help mechanism in same relative location across pages | Help icon always in same position on every screen |
| **3.3.7** Redundant Entry (NEW in 2.2) | Don't ask for same info twice | Address auto-fills; payment details remembered; postcode → city auto-fill |
| Screen reader | Full Semantics tree | Every widget has `Semantics()` labels in NL + EN |
| Keyboard nav | Full keyboard navigation | Focus order follows visual order; skip navigation links |

### 23.2 Contrast Validation Table

| Pair | Foreground | Background | Ratio | Pass? |
|---|---|---|---|---|
| Body text on white | `#1A1A1A` | `#FFFFFF` | 16.8:1 | ✅ AAA |
| Secondary text on white | `#555555` | `#FFFFFF` | 7.5:1 | ✅ AA |
| Primary orange on white | `#F15A24` | `#FFFFFF` | 3.4:1 | ⚠️ Large text only |
| White on primary orange | `#FFFFFF` | `#F15A24` | 3.4:1 | ⚠️ Large text only |
| White on secondary blue | `#FFFFFF` | `#1E4F7A` | 8.1:1 | ✅ AAA |
| White on success green | `#FFFFFF` | `#2EAD4A` | 3.6:1 | ⚠️ Large text only |
| Neutral-900 on neutral-50 | `#1A1A1A` | `#F8F9FB` | 15.7:1 | ✅ AAA |

**Important:** Primary orange (`#F15A24`) on white only passes for large text (≥ 18.66px bold or ≥ 24px regular). For small text on orange backgrounds, always use white text on orange, or use the secondary blue for small text links.

### 23.3 Minimum Touch Targets

```dart
// All interactive widgets must enforce minimum size
ConstrainedBox(
  constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
  child: yourWidget,
)
```

### 23.4 Focus Indicator

```dart
// Global focus style
MaterialApp(
  theme: ThemeData(
    focusColor: DeelmarktColors.primary.withOpacity(0.12),
    // Custom focus indicator for all widgets
  ),
)
```

Visible focus ring: 2px solid `primary` with 2px offset from the element boundary.

---

## 24. Dark Mode

### 24.1 Dark Colour Mapping

| Token | Light Mode | Dark Mode |
|---|---|---|
| Scaffold background | `#F8F9FB` | `#121212` |
| Card surface | `#FFFFFF` | `#1E1E1E` |
| Elevated surface | `#FFFFFF` | `#2C2C2C` |
| Primary text | `#1A1A1A` | `#F2F2F2` |
| Secondary text | `#555555` | `#A0A0A0` |
| Border | `#E5E5E5` | `#333333` |
| Divider | `#E5E5E5` | `#2C2C2C` |
| Primary orange | `#F15A24` | `#FF7A4D` (lighter for dark bg contrast) |
| Secondary blue | `#1E4F7A` | `#5BA3D9` (lighter for dark bg contrast) |
| Success green | `#2EAD4A` | `#4ADE80` |
| Error red | `#E53E3E` | `#F87171` |
| Warning yellow | `#FFC857` | `#FFC857` (unchanged) |
| Trust shield bg | `#F0FDF4` | `#052E16` |
| Error surface | `#FDE8E8` | `#450A0A` |
| Info surface | `#EFF6FF` | `#172554` |

### 24.2 Dark Mode Rules

- System preference by default; manual override in settings
- Images are NOT dimmed (listings must show true colour)
- Elevation in dark mode uses lighter surface tones (not shadows)
- All contrast ratios re-validated for dark palette
- Shimmer loading uses `#2C2C2C` → `#3C3C3C` gradient

```dart
static ThemeData dark = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFFF7A4D),
    secondary: Color(0xFF5BA3D9),
    surface: Color(0xFF1E1E1E),
    error: Color(0xFFF87171),
    onPrimary: Color(0xFF1A1A1A),
    onSecondary: Color(0xFF1A1A1A),
    onSurface: Color(0xFFF2F2F2),
    onError: Color(0xFF1A1A1A),
  ),
);
```

---

## 25. Responsive & Adaptive Breakpoints

### 25.1 Breakpoints

| Token | Range | Layout | Columns |
|---|---|---|---|
| `compact` | < 600px | Mobile | 2 (listing grid) |
| `medium` | 600–840px | Tablet portrait | 3 (listing grid) |
| `expanded` | 840–1200px | Tablet landscape / small desktop | 4 (listing grid) |
| `large` | > 1200px | Desktop | Max 1200px content, 4-5 grid + sidebar |

### 25.2 Adaptive Patterns

| Pattern | Compact | Medium+ |
|---|---|---|
| Navigation | Bottom nav bar | Side rail or navigation drawer |
| Listing grid | 2 columns | 3–5 columns |
| Listing detail | Full screen | Master-detail (list left, detail right) |
| Chat | Full screen | Split view (conversation list + thread) |
| Filters | Bottom sheet | Side panel |
| Seller profile | Scrollable page | Tabbed layout with sidebar |

### 25.3 Flutter Implementation

```dart
class Breakpoints {
  static const compact = 600.0;
  static const medium = 840.0;
  static const expanded = 1200.0;

  static bool isCompact(BuildContext context) =>
    MediaQuery.sizeOf(context).width < compact;
  static bool isMedium(BuildContext context) =>
    MediaQuery.sizeOf(context).width >= compact &&
    MediaQuery.sizeOf(context).width < medium;
  static bool isExpanded(BuildContext context) =>
    MediaQuery.sizeOf(context).width >= medium;
}
```

---

## 26. Listing Detail Page

### 26.1 Full Layout

```
┌──────────────────────────────────────┐
│  ← (back)           🔗 (share) ♡    │  ← Transparent app bar over image
│                                      │
│  ┌────────────────────────────────┐  │
│  │                                │  │
│  │     IMAGE GALLERY              │  │  ← Swipe gallery, dot indicators
│  │     (16:10 aspect ratio)       │  │     Tap to fullscreen + zoom
│  │                                │  │
│  │  1/8              📷           │  │  ← Photo count + fullscreen icon
│  └────────────────────────────────┘  │
│                                      │
│  €45,00                              │  ← Price (heading-lg, bold)
│  🌿 −2,4 kg CO2                     │  ← Eco badge (small, green)
│                                      │
│  Vintage design stoel                │  ← Title (heading-md)
│                                      │
│  🛡️ Beschermd met DeelMarkt Escrow  │  ← Trust banner (see §8.3)
│                                      │
│  ┌────────────────────────────────┐  │
│  │ 🧑 Jan de Vries  🛡️ iDIN      │  │  ← Seller card (see §12.4)
│  │    ⭐ 4.8 (127) · 📍 Amsterdam │  │
│  │    [ Bekijk profiel ]          │  │
│  └────────────────────────────────┘  │
│                                      │
│  Beschrijving                        │
│  ──────────                          │
│  Mooie vintage stoel in goede...     │  ← Description (body-lg)
│  [ Toon meer ▼ ]                     │
│                                      │
│  Details                             │
│  ──────────                          │
│  Categorie: Meubels                  │
│  Conditie: Goed                      │
│  Verzending: PostNL (€6,95)          │
│  Geplaatst: 2 dagen geleden         │
│                                      │
│  📍 Amsterdam, 2,3 km               │  ← Map preview (tappable)
│                                      │
│  ──────── Sticky bottom ──────────── │
│  [ Bericht sturen 💬 ] [Koop nu → ] │  ← Sticky CTA bar
│  ────────────────────────────────── │
└──────────────────────────────────────┘
```

### 26.2 Sticky Bottom CTA Bar

Always visible, never scrolls away:

- Left: "Bericht sturen" (secondary/outline button)
- Right: "Koop nu" or "Doe een bod" (primary orange button)
- Background: white with `elevation-1` shadow
- Height: 72px (including safe area padding)

---

## 27. Seller & Buyer Mode UI

### 27.1 Dynamic Home Dashboard

The home screen adapts based on user's primary activity:

**Buyer Mode (default):**
```
[Search bar]
[Category chips]
[Recommended for you]
[Nearby items]
[Recently viewed]
```

**Seller Mode (when user has active listings):**
```
[Quick stats: views, messages, sales]
[Action needed: 2 items to ship]
[Your active listings]
[Seller tips]
```

Switch is automatic based on recent activity, with manual toggle in profile.

---

## 28. Notification & Feedback System

### 28.1 Toast / Snackbar

For non-critical confirmations:

```
┌──────────────────────────────────────┐
│  ✅ Advertentie geplaatst            │  ← Success toast
└──────────────────────────────────────┘
```

- Bottom of screen, above bottom nav
- Auto-dismiss: 3 seconds
- Swipe to dismiss
- Max 1 toast visible at a time
- Colour: semantic (green surface for success, red surface for error)

### 28.2 Push Notification Categories

| Category | Example | Priority |
|---|---|---|
| Transaction | "Je item is verkocht!" | High — immediate |
| Message | "Nieuw bericht van Jan" | Medium — badge + sound |
| Shipping | "Je pakket is bezorgd" | Medium |
| Price alert | "Prijsdaling op je favorieten" | Low — silent |
| System | "Verifieer je identiteit" | Low — silent |

### 28.3 In-App Review Prompt

Triggered ONLY after a successful transaction (never on app open, never after a dispute):

```
┌──────────────────────────────────────┐
│  Vind je DeelMarkt leuk?            │
│                                      │
│  [ Nee, dank je ]  [ Beoordeel ⭐ ] │
└──────────────────────────────────────┘
```

Uses `in_app_review` Flutter package. Maximum once per 90 days.

---

## 29. Category Structure

### 29.1 Level 1 Categories

| Icon | NL | EN | Example L2 |
|---|---|---|---|
| 🚗 | Voertuigen | Vehicles | Auto's, Motoren, Fietsen, Onderdelen |
| 📱 | Elektronica | Electronics | Telefoons, Computers, Gaming, Audio |
| 🛋️ | Huis & Meubels | Home & Furniture | Meubels, Keuken, Tuin, Verlichting |
| 👗 | Kleding & Mode | Clothing & Fashion | Dames, Heren, Kinderen, Schoenen |
| ⚽ | Sport & Vrije tijd | Sports & Leisure | Fitness, Fietsen, Kamperen, Watersport |
| 🧸 | Kinderen & Baby's | Kids & Baby | Speelgoed, Kleding, Kinderwagens |
| 🔧 | Diensten | Services | Klussen, Les, Verhuizen |
| 📦 | Overig | Other | Verzamelen, Dieren, Tickets |

### 29.2 Display Pattern

Home screen: horizontal scrollable row of category icons (duotone) with labels.

Search: vertical list with L2 subcategories expanding on tap.

---

## 30. Flutter Architecture & Folder Structure

```
lib/
├── core/
│   ├── design_system/
│   │   ├── colors.dart            # DeelmarktColors
│   │   ├── typography.dart        # DeelmarktTypography
│   │   ├── spacing.dart           # Spacing constants
│   │   ├── shadows.dart           # DeelmarktShadows
│   │   ├── radius.dart            # DeelmarktRadius
│   │   ├── theme.dart             # DeelmarktTheme (light + dark)
│   │   └── breakpoints.dart       # Responsive breakpoints
│   ├── l10n/
│   │   ├── nl.json                # Dutch strings
│   │   └── en.json                # English strings
│   ├── router/
│   │   └── app_router.dart        # GoRouter + deep link config
│   └── utils/
│       ├── formatters.dart        # Price, date, distance formatting
│       └── validators.dart        # Postcode, phone, email validation
│
├── widgets/                        # Shared design system components
│   ├── buttons/
│   │   ├── deel_button.dart
│   │   └── fab_sell_button.dart
│   ├── cards/
│   │   ├── listing_card.dart
│   │   ├── seller_card.dart
│   │   └── transaction_card.dart
│   ├── trust/
│   │   ├── trust_banner.dart
│   │   ├── verification_badge.dart
│   │   ├── escrow_timeline.dart
│   │   └── scam_alert.dart
│   ├── inputs/
│   │   ├── deel_input.dart
│   │   ├── price_input.dart
│   │   ├── search_bar.dart
│   │   └── dutch_address_input.dart
│   ├── feedback/
│   │   ├── skeleton_loader.dart
│   │   ├── empty_state.dart
│   │   └── error_state.dart
│   ├── media/
│   │   ├── image_gallery.dart
│   │   └── shipping_qr.dart
│   ├── badges/
│   │   ├── price_tag.dart
│   │   ├── eco_badge.dart
│   │   ├── location_badge.dart
│   │   └── category_chip.dart
│   └── layout/
│       ├── language_switch.dart
│       └── responsive_grid.dart
│
├── features/                       # Feature-first modules
│   ├── home/
│   ├── search/
│   ├── sell/
│   ├── messages/
│   ├── profile/
│   ├── listing_detail/
│   ├── transaction/
│   ├── shipping/
│   └── onboarding/
│
└── main.dart
```

---

## 31. Design Tokens Reference

Quick lookup for all tokens used in this system:

| Category | Token | Value |
|---|---|---|
| **Colour** | `primary` | `#F15A24` |
| | `secondary` | `#1E4F7A` |
| | `success` | `#2EAD4A` |
| | `warning` | `#FFC857` |
| | `error` | `#E53E3E` |
| | `trust-verified` | `#16A34A` |
| | `trust-escrow` | `#2563EB` |
| **Font** | Family | Plus Jakarta Sans |
| | Display | 32px / Bold |
| | Body | 16px / Regular |
| | Price | 20px / Bold |
| **Spacing** | Base unit | 4px |
| | Screen margin | 16px mobile |
| | Section gap | 32px |
| **Radius** | Cards | 16px |
| | Buttons | 12px |
| | Inputs | 10px |
| **Elevation** | Cards | 0 (border only) |
| | Modals | Level 3 |
| | FAB | Level 4 |
| **Animation** | Standard | 200ms |
| | Complex | 300ms |
| | Easing | easeOutCubic |
| **Touch Target** | Minimum | 44×44px |
| **Breakpoint** | Mobile | < 600px |
| | Tablet | 600–840px |
| | Desktop | > 1200px |

---

> **Usage Note:** This design system is a living document. All changes must be documented with rationale. New components require: Figma design → Flutter implementation → Storybook (Widgetbook) entry → accessibility audit. No component ships without all four.

---

*© 2026 — DeelMarkt Design System v1.0 | deelmarkt.com | deelmarkt.eu | CONFIDENTIAL*
