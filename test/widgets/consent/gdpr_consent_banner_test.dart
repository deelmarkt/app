import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:deelmarkt/core/design_system/theme.dart';
import 'package:deelmarkt/widgets/consent/gdpr_consent_banner.dart';

Widget _buildApp({
  VoidCallback? onAcceptAll,
  VoidCallback? onNecessaryOnly,
  ThemeData? theme,
}) {
  return MaterialApp(
    theme: theme ?? DeelmarktTheme.light,
    home: Scaffold(
      body: GdprConsentBanner(
        onAcceptAll: onAcceptAll ?? () {},
        onNecessaryOnly: onNecessaryOnly ?? () {},
      ),
    ),
  );
}

void main() {
  group('GdprConsentBanner rendering', () {
    testWidgets('renders shield icon', (tester) async {
      await tester.pumpWidget(_buildApp());
      expect(
        find.byIcon(PhosphorIcons.shieldCheck(PhosphorIconsStyle.fill)),
        findsOneWidget,
      );
    });

    testWidgets('renders title text', (tester) async {
      await tester.pumpWidget(_buildApp());
      expect(find.text('consent.title'), findsOneWidget);
    });

    testWidgets('renders body text', (tester) async {
      await tester.pumpWidget(_buildApp());
      expect(find.text('consent.body'), findsOneWidget);
    });

    testWidgets('renders privacy policy link', (tester) async {
      await tester.pumpWidget(_buildApp());
      expect(find.text('consent.privacy_policy'), findsOneWidget);
    });

    testWidgets('renders accept all button', (tester) async {
      await tester.pumpWidget(_buildApp());
      expect(find.text('consent.accept_all'), findsOneWidget);
    });

    testWidgets('renders necessary only button', (tester) async {
      await tester.pumpWidget(_buildApp());
      expect(find.text('consent.necessary_only'), findsOneWidget);
    });

    testWidgets('renders ModalBarrier', (tester) async {
      await tester.pumpWidget(_buildApp());
      expect(find.byType(ModalBarrier), findsWidgets);
    });
  });

  group('GdprConsentBanner interaction', () {
    testWidgets('accept all fires callback', (tester) async {
      var fired = false;
      await tester.pumpWidget(_buildApp(onAcceptAll: () => fired = true));
      await tester.tap(find.text('consent.accept_all'));
      expect(fired, isTrue);
    });

    testWidgets('necessary only fires callback', (tester) async {
      var fired = false;
      await tester.pumpWidget(_buildApp(onNecessaryOnly: () => fired = true));
      await tester.tap(find.text('consent.necessary_only'));
      expect(fired, isTrue);
    });
  });

  group('GdprConsentBanner accessibility', () {
    testWidgets('has Semantics wrapper', (tester) async {
      await tester.pumpWidget(_buildApp());
      // Verify Semantics is present with label on the banner.
      final semanticsFinder = find.descendant(
        of: find.byType(GdprConsentBanner),
        matching: find.byType(Semantics),
      );
      expect(semanticsFinder, findsWidgets);
    });

    testWidgets('renders without overflow at 320px', (tester) async {
      tester.view.physicalSize = const Size(320, 568);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_buildApp());
      expect(tester.takeException(), isNull);
    });

    testWidgets('PopScope blocks back navigation', (tester) async {
      await tester.pumpWidget(_buildApp());
      final popScope = tester.widget<PopScope>(find.byType(PopScope));
      expect(popScope.canPop, isFalse);
    });
  });

  group('GdprConsentBanner theme', () {
    testWidgets('renders in dark mode without error', (tester) async {
      await tester.pumpWidget(_buildApp(theme: DeelmarktTheme.dark));
      expect(find.byType(GdprConsentBanner), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
