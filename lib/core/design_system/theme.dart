import 'package:flutter/material.dart';

import 'colors.dart';
import 'radius.dart';
import 'typography.dart';

/// DeelMarkt app theme (Material 3).
/// Reference: docs/design-system/tokens.md
class DeelmarktTheme {
  DeelmarktTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: DeelmarktTypography.fontFamily,
    textTheme: DeelmarktTypography.textTheme,
    primaryColor: DeelmarktColors.primary,
    scaffoldBackgroundColor: DeelmarktColors.neutral50,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: DeelmarktColors.primary,
      onPrimary: Colors.white,
      secondary: DeelmarktColors.secondary,
      onSecondary: Colors.white,
      error: DeelmarktColors.error,
      onError: Colors.white,
      surface: DeelmarktColors.white,
      onSurface: DeelmarktColors.neutral900,
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
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DeelmarktRadius.xl),
        side: const BorderSide(color: DeelmarktColors.neutral200),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: DeelmarktColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DeelmarktRadius.lg),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: DeelmarktTypography.fontFamily,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DeelmarktColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DeelmarktRadius.md),
        borderSide: const BorderSide(color: DeelmarktColors.neutral200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DeelmarktRadius.md),
        borderSide: const BorderSide(color: DeelmarktColors.neutral200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DeelmarktRadius.md),
        borderSide: const BorderSide(color: DeelmarktColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DeelmarktRadius.md),
        borderSide: const BorderSide(color: DeelmarktColors.error),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: DeelmarktTypography.fontFamily,
    textTheme: DeelmarktTypography.textTheme,
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
}
