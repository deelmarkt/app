/// Shared formatters for price, date, distance.
///
/// Reference: CLAUDE.md §3.2 ("Formatting → core/utils/formatters.dart")
abstract final class Formatters {
  /// Format cents to Euro string with Dutch locale (€45,00).
  ///
  /// Uses comma as decimal separator per Dutch convention.
  static String euroFromCents(int cents) {
    final euros = cents / 100;
    return '\u20AC${euros.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  /// Format a DateTime as a short date + time string.
  ///
  /// NL: "25 mrt 2026 18:00"
  /// EN: "25 Mar 2026 18:00"
  ///
  /// Uses [locale] to determine month abbreviation.
  static String shortDateTime(DateTime dt, {String locale = 'nl'}) {
    final months =
        locale == 'nl'
            ? [
              'jan',
              'feb',
              'mrt',
              'apr',
              'mei',
              'jun',
              'jul',
              'aug',
              'sep',
              'okt',
              'nov',
              'dec',
            ]
            : [
              'Jan',
              'Feb',
              'Mar',
              'Apr',
              'May',
              'Jun',
              'Jul',
              'Aug',
              'Sep',
              'Oct',
              'Nov',
              'Dec',
            ];
    final month = months[dt.month - 1];
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '${dt.day} $month ${dt.year} $h:$m';
  }
}
