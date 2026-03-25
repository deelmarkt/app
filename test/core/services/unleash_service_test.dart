import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:deelmarkt/core/services/unleash_service.dart';

void main() {
  group('UnleashService providers', () {
    test('unleashClientProvider returns null when not initialised', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final client = container.read(unleashClientProvider);
      expect(client, isNull);
    });

    test('isFeatureEnabledProvider returns false when client is null', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final enabled = container.read(isFeatureEnabledProvider('test_flag'));
      expect(enabled, isFalse);
    });

    test('isFeatureEnabledProvider returns false for all known flags', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(
        container.read(
          isFeatureEnabledProvider(FeatureFlags.snapToListEnabled),
        ),
        isFalse,
      );
      expect(
        container.read(
          isFeatureEnabledProvider(FeatureFlags.streamChatMigration),
        ),
        isFalse,
      );
      expect(
        container.read(
          isFeatureEnabledProvider(FeatureFlags.phase2PromotedListings),
        ),
        isFalse,
      );
    });

    test('different flag names produce different provider instances', () {
      final a = isFeatureEnabledProvider('flag_a');
      final b = isFeatureEnabledProvider('flag_b');
      final a2 = isFeatureEnabledProvider('flag_a');

      expect(a, isNot(equals(b)));
      expect(a, equals(a2));
    });
  });

  group('FeatureFlags constants', () {
    test('flag names are non-empty snake_case strings', () {
      final flags = [
        FeatureFlags.snapToListEnabled,
        FeatureFlags.streamChatMigration,
        FeatureFlags.phase2PromotedListings,
      ];

      for (final flag in flags) {
        expect(flag, isNotEmpty);
        expect(flag, matches(RegExp(r'^[a-z0-9_]+$')));
      }
    });
  });
}
