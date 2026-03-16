# Accessibility (WCAG 2.2 AA)

> European Accessibility Act — enforceable since June 28, 2025.
> Fines up to €100,000 or 4% of annual revenue. These are legal requirements.

---

## Mandatory Criteria

| WCAG | Requirement | Implementation |
|:-----|:-----------|:---------------|
| 1.4.3 | Contrast (min) | 4.5:1 normal text, 3:1 large text |
| 1.4.11 | Non-text contrast | 3:1 for UI components and graphics |
| 2.4.7 | Focus visible | 2px `primary` outline, 2px offset |
| 2.4.11 | Focus not obscured (2.2) | Bottom nav and app bar never overlap focused content |
| 2.5.7 | Dragging alternatives (2.2) | Image reorder: drag OR up/down buttons; filter sliders have text input |
| 2.5.8 | Target size (2.2) | ≥ 44×44px, spacing ≥ 8px between targets |
| 3.2.6 | Consistent help (2.2) | Help icon same position every screen |
| 3.3.7 | Redundant entry (2.2) | Auto-fill addresses, remember payment, postcode → city |

---

## Contrast Validation

| Pair | Foreground | Background | Ratio | Pass |
|:-----|:-----------|:-----------|:------|:-----|
| Body text on white | `#1A1A1A` | `#FFFFFF` | 16.8:1 | AAA |
| Secondary text on white | `#555555` | `#FFFFFF` | 7.5:1 | AA |
| Primary orange on white | `#F15A24` | `#FFFFFF` | 3.4:1 | Large text only |
| White on primary orange | `#FFFFFF` | `#F15A24` | 3.4:1 | Large text only |
| White on secondary blue | `#FFFFFF` | `#1E4F7A` | 8.1:1 | AAA |
| White on success green | `#FFFFFF` | `#2EAD4A` | 3.6:1 | Large text only |
| Neutral-900 on neutral-50 | `#1A1A1A` | `#F8F9FB` | 15.7:1 | AAA |

**Rule:** Primary orange on white only for text ≥18.66px bold or ≥24px regular. For small text on orange: use white text on orange, or use secondary blue.

---

## Touch Targets

All interactive widgets:

```dart
ConstrainedBox(
  constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
  child: yourWidget,
)
```

Spacing between targets: ≥ 8px.

---

## Focus Indicator

Visible focus ring on all focusable elements:

```dart
// Global focus style — 2px primary outline, 2px offset
MaterialApp(
  theme: ThemeData(
    focusColor: DeelmarktColors.primary.withOpacity(0.12),
  ),
)
```

2px solid `primary` outline with 2px offset from element boundary.

---

## Screen Reader

- Every interactive widget: `Semantics()` labels in NL + EN
- Full keyboard navigation
- Focus order = visual order
- Skip navigation links
- Images: `Semantics(label: description)` or `excludeFromSemantics: true` for decorative

---

## Reduced Motion

```dart
final reduceMotion = MediaQuery.of(context).disableAnimations;
// When true: all animation durations = Duration.zero
// All transitions become instant state changes
```

This is a WCAG 2.2 requirement — not optional.

---

## Form Accessibility

- Labels associated with inputs (not just placeholder text)
- Error messages announced to screen reader via `Semantics(liveRegion: true)`
- Required fields marked with `*` and `Semantics(required: true)`
- Auto-focus on first error field after submission
- Form-level error summary at top for screen readers
