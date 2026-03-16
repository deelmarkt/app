import 'package:flutter/material.dart';

/// DeelMarkt colour tokens.
/// Reference: docs/design-system/tokens.md
class DeelmarktColors {
  DeelmarktColors._();

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
  static const info = Color(0xFF3B82F6);
  static const infoSurface = Color(0xFFEFF6FF);

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
