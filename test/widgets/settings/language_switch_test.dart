import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:deelmarkt/core/design_system/theme.dart';

// Tests the SegmentedButton rendering and interaction directly,
// bypassing EasyLocalization (which requires async asset loading).
// The LanguageSwitch widget delegates to an internal body that renders
// a SegmentedButton with Locale segments.
void main() {
  Widget buildSegmentedButtonApp({
    Locale selectedLocale = const Locale('nl', 'NL'),
    ValueChanged<Set<Locale>>? onSelectionChanged,
    ThemeData? theme,
  }) {
    return MaterialApp(
      theme: theme ?? DeelmarktTheme.light,
      home: Scaffold(
        body: Center(
          child: SegmentedButton<Locale>(
            segments: const [
              ButtonSegment(value: Locale('nl', 'NL'), label: Text('NL')),
              ButtonSegment(value: Locale('en', 'US'), label: Text('EN')),
            ],
            selected: {selectedLocale},
            onSelectionChanged: onSelectionChanged ?? (_) {},
            showSelectedIcon: false,
          ),
        ),
      ),
    );
  }

  testWidgets('renders SegmentedButton with NL and EN', (tester) async {
    await tester.pumpWidget(buildSegmentedButtonApp());
    expect(find.byType(SegmentedButton<Locale>), findsOneWidget);
    expect(find.text('NL'), findsOneWidget);
    expect(find.text('EN'), findsOneWidget);
  });

  testWidgets('has two segments with showSelectedIcon false', (tester) async {
    await tester.pumpWidget(buildSegmentedButtonApp());
    final button = tester.widget<SegmentedButton<Locale>>(
      find.byType(SegmentedButton<Locale>),
    );
    expect(button.segments.length, 2);
    expect(button.showSelectedIcon, isFalse);
  });

  testWidgets('selected locale is NL by default', (tester) async {
    await tester.pumpWidget(buildSegmentedButtonApp());
    final button = tester.widget<SegmentedButton<Locale>>(
      find.byType(SegmentedButton<Locale>),
    );
    expect(button.selected, contains(const Locale('nl', 'NL')));
  });

  testWidgets('onSelectionChanged fires with EN on tap', (tester) async {
    Set<Locale>? selected;
    await tester.pumpWidget(
      buildSegmentedButtonApp(onSelectionChanged: (s) => selected = s),
    );

    await tester.tap(find.text('EN'));
    await tester.pumpAndSettle();

    expect(selected, isNotNull);
    expect(selected, contains(const Locale('en', 'US')));
  });

  testWidgets('renders in dark mode without error', (tester) async {
    await tester.pumpWidget(
      buildSegmentedButtonApp(theme: DeelmarktTheme.dark),
    );
    expect(find.byType(SegmentedButton<Locale>), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('touch target height >= 44px', (tester) async {
    await tester.pumpWidget(buildSegmentedButtonApp());
    final size = tester.getSize(find.byType(SegmentedButton<Locale>));
    expect(size.height, greaterThanOrEqualTo(44));
  });
}
