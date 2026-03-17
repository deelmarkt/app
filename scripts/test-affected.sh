#!/usr/bin/env bash
# test-affected.sh — Run tests only for staged Dart files.
#
# Mapping rules:
#   lib/core/design_system/colors.dart  → test/core/design_system_test.dart
#                                         test/core/design_system/colors_test.dart
#   lib/features/home/data/repo.dart    → test/features/home/data/repo_test.dart
#   lib/widgets/buttons/deel_button.dart → test/widgets/buttons/deel_button_test.dart
#   test/anything_test.dart             → runs directly
#
# If no matching test files found, exits 0 (nothing to test).
# If core files changed (main.dart, theme, router), runs full suite.

set -euo pipefail

# Get staged .dart files
STAGED=$(git diff --cached --name-only --diff-filter=ACMR -- '*.dart')

if [ -z "$STAGED" ]; then
  echo "No staged Dart files — skipping tests."
  exit 0
fi

# Core files that affect everything — run full suite
CORE_PATTERNS="lib/main.dart lib/core/design_system/theme.dart lib/core/router/app_router.dart lib/core/l10n/l10n.dart"
for pattern in $CORE_PATTERNS; do
  if echo "$STAGED" | grep -q "^$pattern$"; then
    echo "Core file changed ($pattern) — running full test suite."
    flutter test --no-pub
    exit $?
  fi
done

# Collect test files to run
TEST_FILES=""

for file in $STAGED; do
  if [[ "$file" == test/*_test.dart ]]; then
    # Already a test file — run it directly
    TEST_FILES="$TEST_FILES $file"
  elif [[ "$file" == lib/* ]]; then
    # Map lib/ path to test/ path
    # lib/core/design_system/colors.dart → test/core/design_system/colors_test.dart
    test_path="${file/lib\//test/}"
    test_path="${test_path%.dart}_test.dart"
    if [ -f "$test_path" ]; then
      TEST_FILES="$TEST_FILES $test_path"
    fi

    # Also check for directory-level test file
    # lib/core/design_system/colors.dart → test/core/design_system_test.dart
    dir_path=$(dirname "$test_path")
    parent_dir=$(dirname "$dir_path")
    dir_name=$(basename "$dir_path")
    dir_test="${parent_dir}/${dir_name}_test.dart"
    if [ -f "$dir_test" ]; then
      TEST_FILES="$TEST_FILES $dir_test"
    fi
  fi
done

# Deduplicate
TEST_FILES=$(echo "$TEST_FILES" | tr ' ' '\n' | sort -u | tr '\n' ' ')

if [ -z "$(echo "$TEST_FILES" | tr -d ' ')" ]; then
  echo "No matching test files for changed sources — skipping."
  exit 0
fi

echo "Running affected tests:"
for f in $TEST_FILES; do
  echo "  → $f"
done

flutter test --no-pub $TEST_FILES
