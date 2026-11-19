# bangladesh_holidays

Offline Bangladesh holidays and office-specific working-day calculations for Dart and Flutter.

**Pure Dart, with no runtime dependencies**, network calls, API keys or Flutter
dependency. Answer “when is the fifth working day?” and explain every skipped
date. Supports Dart 3.4 or later, including Flutter applications.

## Quick start

Add the package from pub.dev:

```sh
dart pub add bangladesh_holidays
```

For Flutter projects, use `flutter pub add bangladesh_holidays`. To try an
unpublished checkout locally, use a path dependency instead:

```yaml
dependencies:
  bangladesh_holidays:
    path: ../bangladesh_holidays
```

```dart
import 'package:bangladesh_holidays/bangladesh_holidays.dart';

final calendar = BangladeshHolidays(district: District.dhaka);
final from = DateTime(2027, 4, 12);
final end = DateTime(2027, 4, 19);

calendar.businessDaysBetween(from, end); // 4: 12, 13, 15 and 18 April.
calendar.addBusinessDays(from, 3); // 2027-04-18; starting date excluded.

for (final day in calendar.daysBetween(from, end)) {
  print('${day.date}: ${day.isBusinessDay} ${day.reasons}');
}
```

## Holiday catalog

```dart
calendar.holidaysIn(2027);
calendar.holidaysInMonth(2027, 5);
calendar.holidaysOn(DateTime(2027, 5, 20)); // Buddha Purnima AND Eid leave.
calendar.holidaysBetween(DateTime(2027, 4, 1), DateTime(2027, 5, 1));
calendar.nextHolidays(from: DateTime(2027, 4, 12));
calendar.holidaysIn(2027, types: {HolidayType.optional},
  community: HolidayCommunity.hindu);
calendar.holidaysIn(2027, applicableOnly: true);
```

Catalog queries include unselected optional and regional holidays by default.
Business-day methods and `isHoliday` apply the configured office rules.
`isHoliday` does not treat a weekend alone as a holiday.

Each occurrence has a stable ID, English/Bangla names, category, applicability,
lunar uncertainty and government source. Lists preserve overlapping occurrences.
`nextHolidays` returns all holidays on the next matching date, searches strictly
after `from` and applies office rules by default. Use `inclusive: true` or
`applicableOnly: false` to change those behaviors.

The catalog's `district:` argument filters that query; it does not change the
office's district. A null office district includes nationwide holidays only.
Restricted regional and exclusion-based dates require an explicit district.

## Office rules

```dart
final office = BangladeshHolidays(
  district: District.rangamati,
  weekendDays: {DateTime.friday},
  selectedOptionalHolidayIds: {'2027-optional-saraswati'},
  extraHolidays: [
    Holiday.company(
      id: 'company-anniversary',
      date: DateTime(2027, 6, 1),
      nameEn: 'Company anniversary',
      nameBn: 'প্রতিষ্ঠাবার্ষিকী',
    ),
  ],
  overrides: [
    HolidayOverride.move(
      holidayId: '2027-general-eid-fitr',
      date: DateTime(2027, 3, 11),
      isEstimated: false, // Your confirmation, not a government-data update.
    ),
    HolidayOverride.remove('2027-general-revolution'),
  ],
);
```

- Defaults: Friday/Saturday off; general and executive holidays included.
- Optional dates close the office **only when selected by ID**. Community
  filtering is for discovery, not automatic leave approval. Employee entitlement
  limits remain the application's responsibility.
- Regional applicability is separate from legal category. Chaitra Sankranti is
  general leave in three hill districts and optional for the specified community
  elsewhere.
- Official office-opening orders override the weekly day off only. Other active
  holidays still close the date. Set `applyGovernmentWorkingDays: false` for
  organizations that do not follow those orders.
- An override affects **one occurrence**. Moving Eid does not move its
  surrounding leave days. `originalDate` keeps the published date; `source`
  does not endorse the caller's replacement.
- Unknown/duplicate IDs, invalid weekdays, all seven weekdays off and invalid
  optional selections raise `ArgumentError`. Collections are copied and immutable.

## Dates and coverage

Use Bangladesh **calendar dates**, not unconverted timestamps. Only the input
year/month/day are read; returned dates are UTC-midnight date containers.
Convert an instant to the Bangladesh civil date before calling the API.
Dart normalizes invalid constructor dates, so validate text inputs first.

All ranges use **[start, end)**: start included, end excluded. Empty ranges return
no days; reversed ranges are rejected. `addBusinessDays` excludes the start,
supports negative counts, and returns the normalized start for zero even on a holiday.

Bundled years: **2026 and 2027**, reviewed **19 November 2026**.
`CoverageException` is thrown for unsupported years, including when a forward
or backward search reaches the coverage boundary. Missing data never silently
becomes a working year.

```dart
calendar.supportedYears; // [2026, 2027]
calendar.isCovered(2028); // false
calendar.coverageFor(2027).sources;
```

This is a versioned MOPA snapshot, not a live feed. Lunar-dependent dates remain
`isEstimated: true` until a later confirmation is incorporated; passing time
alone does not remove that flag. Updates require a new package version or
explicit application overrides.

Scope: annual general/executive/optional lists, hill-district applicability and
national amendments in [the source ledger](https://github.com/farhans-codes/bangladesh_holidays/blob/main/doc/sources.md). Bank, school, court,
essential-service, industry-specific and constituency-only calendars are outside
this dataset. Check the source notice for your organization's applicability.

## Mobile Flutter demo

[example/flutter](https://github.com/farhans-codes/bangladesh_holidays/tree/main/example/flutter) demonstrates Calendar, Calculate and Rules
tabs, day-by-day explanations, optional/company holidays and occurrence overrides.
English/Bangla, light/dark themes, phone navigation and a wider-screen rail are
included. Rules last for the current session; restarting resets the demo.
These presentation choices belong only to the example. The package exports
data and calculation APIs, with no widgets or theme requirements.
Clone the repository to run the demo; it is excluded from the pub.dev archive.

```sh
cd example/flutter
flutter pub get
flutter gen-l10n
flutter run
```

Android is the primary demo platform; a Flutter web runner is also included.
No Flutter tests are included. See [manual verification](https://github.com/farhans-codes/bangladesh_holidays/blob/main/doc/manual-verification.md).

## Maintenance

`data/*.json` is the single editable source. The generator validates IDs, real
dates, coverage, sources, categories, bilingual names and district constraints.
It emits immutable Dart data; no JSON is read at runtime.

```sh
dart pub get
dart run tool/generate_data.dart
dart run tool/generate_data.dart --check
dart format --output=none --set-exit-if-changed lib tool example/bangladesh_holidays_example.dart
dart analyze --fatal-infos
dart run tool/verify_package.dart
dart run example/bangladesh_holidays_example.dart
dart pub publish --dry-run
```

See [maintenance](https://github.com/farhans-codes/bangladesh_holidays/blob/main/doc/maintenance.md), [roadmap](https://github.com/farhans-codes/bangladesh_holidays/blob/main/doc/roadmap.md) and
[changelog](https://github.com/farhans-codes/bangladesh_holidays/blob/main/CHANGELOG.md). Contributions should include the original government
notice, changed JSON and regenerated Dart. Code is MIT licensed.
