import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:deelmarkt/core/design_system/colors.dart';
import 'package:deelmarkt/core/design_system/spacing.dart';
import 'package:deelmarkt/core/design_system/radius.dart';
import 'package:deelmarkt/core/design_system/theme.dart';

void main() {
  group('DeelmarktColors', () {
    test('primary orange matches brand hex #F15A24', () {
      expect(DeelmarktColors.primary, const Color(0xFFF15A24));
    });

    test('secondary blue matches brand hex #1E4F7A', () {
      expect(DeelmarktColors.secondary, const Color(0xFF1E4F7A));
    });

    test('trust colours are distinct from semantic colours', () {
      expect(DeelmarktColors.trustVerified, isNot(DeelmarktColors.success));
      expect(DeelmarktColors.trustWarning, isNot(DeelmarktColors.error));
    });
  });

  group('Spacing', () {
    test('base unit is 4px', () {
      expect(Spacing.s1, 4);
    });

    test('all spacing values are multiples of 4', () {
      final values = [
        Spacing.s1,
        Spacing.s2,
        Spacing.s3,
        Spacing.s4,
        Spacing.s5,
        Spacing.s6,
        Spacing.s8,
        Spacing.s10,
        Spacing.s12,
        Spacing.s16,
      ];
      for (final v in values) {
        expect(v % 4, 0, reason: '$v is not a multiple of 4');
      }
    });
  });

  group('DeelmarktRadius', () {
    test('card radius is xl (16px)', () {
      expect(DeelmarktRadius.xl, 16);
    });

    test('button radius is lg (12px)', () {
      expect(DeelmarktRadius.lg, 12);
    });

    test('input radius is md (10px)', () {
      expect(DeelmarktRadius.md, 10);
    });
  });

  group('DeelmarktTheme', () {
    test('light theme uses Material 3', () {
      expect(DeelmarktTheme.light.useMaterial3, true);
    });

    test('dark theme uses Material 3', () {
      expect(DeelmarktTheme.dark.useMaterial3, true);
    });

    test('light theme scaffold is neutral-50', () {
      expect(
        DeelmarktTheme.light.scaffoldBackgroundColor,
        DeelmarktColors.neutral50,
      );
    });

    test('light theme primary is DeelMarkt orange', () {
      expect(DeelmarktTheme.light.colorScheme.primary, DeelmarktColors.primary);
    });
  });

  group('DeelMarktApp', () {
    testWidgets('renders without crashing', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: DeelmarktTheme.light,
          darkTheme: DeelmarktTheme.dark,
          home: const Scaffold(body: Center(child: Text('DeelMarkt'))),
        ),
      );

      expect(find.text('DeelMarkt'), findsOneWidget);
    });
  });
}
