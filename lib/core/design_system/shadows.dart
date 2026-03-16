import 'package:flutter/material.dart';

/// DeelMarkt elevation/shadow tokens.
/// Cards use border strokes (no shadow). Shadows for floating elements only.
/// Reference: docs/design-system/tokens.md
class DeelmarktShadows {
  DeelmarktShadows._();

  static const elevation1 = [
    BoxShadow(offset: Offset(0, 1), blurRadius: 3, color: Color(0x14000000)),
  ];
  static const elevation2 = [
    BoxShadow(offset: Offset(0, 4), blurRadius: 12, color: Color(0x1A000000)),
  ];
  static const elevation3 = [
    BoxShadow(offset: Offset(0, 8), blurRadius: 24, color: Color(0x1F000000)),
  ];
  static const elevation4 = [
    BoxShadow(offset: Offset(0, 12), blurRadius: 32, color: Color(0x26000000)),
  ];
}
