import 'data/holidays.g.dart';
import 'date.dart';
import 'holiday.dart';

/// An immutable office calendar backed by the bundled official-source snapshot.
///
/// Catalog methods return all recorded holidays unless `applicableOnly` is true.
/// [isHoliday], [dayStatus] and business-day methods always use the office policy.
/// Optional holidays close the office only when their IDs are explicitly chosen.
///
/// Pass a calendar date in Bangladesh, not an unconverted timestamp. Only the
/// supplied year/month/day are used; returned dates are UTC midnight containers.
class BangladeshHolidays {
  /// Creates a calendar with a copied, immutable office policy.
  ///
  /// [weekendDays] uses [DateTime.monday] through [DateTime.sunday]. The default
  /// is Friday/Saturday; an empty set permits every weekday, but all seven days
  /// off is rejected. [include] accepts general and executive-order holidays.
  /// Optional holidays require explicit [selectedOptionalHolidayIds].
  ///
  /// [overrides] changes individual official occurrences before optional IDs
  /// are validated. [extraHolidays] adds company closures with unique IDs.
  /// Invalid rules or IDs throw [ArgumentError]. Dates outside bundled coverage
  /// throw [CoverageException], including replacement and company dates.
  BangladeshHolidays({
    Iterable<int> weekendDays = const {DateTime.friday, DateTime.saturday},
    this.district,
    Iterable<HolidayType> include = const {
      HolidayType.general,
      HolidayType.executiveOrder,
    },
    Iterable<String> selectedOptionalHolidayIds = const [],
    Iterable<HolidayOverride> overrides = const [],
    Iterable<Holiday> extraHolidays = const [],
    this.applyGovernmentWorkingDays = true,
  })  : weekendDays = Set.unmodifiable(weekendDays),
        include = Set.unmodifiable(include),
        selectedOptionalHolidayIds =
            Set.unmodifiable(selectedOptionalHolidayIds) {
    if (this.weekendDays.any((day) => day < 1 || day > 7) ||
        this.weekendDays.length == 7) {
      throw ArgumentError('weekendDays must contain 0–6 weekdays from 1 to 7.');
    }
    if (this.include.any((type) =>
        type != HolidayType.general && type != HolidayType.executiveOrder)) {
      throw ArgumentError('include accepts general and executiveOrder only. '
          'Choose optional holidays by ID; add company holidays separately.');
    }

    final byId = {for (final holiday in generatedHolidays) holiday.id: holiday};
    final overridden = <String>{};
    for (final override in overrides) {
      final holiday = byId[override.holidayId];
      if (holiday == null || !overridden.add(override.holidayId)) {
        throw ArgumentError(
            'Unknown or repeated override: ${override.holidayId}');
      }
      final replacement = override.date;
      if (replacement == null) {
        byId.remove(override.holidayId);
      } else {
        _requireYear(replacement.year);
        byId[holiday.id] = holiday.moveTo(
          replacement,
          isEstimated: override.isEstimated,
        );
      }
    }
    for (final holiday in extraHolidays) {
      _requireYear(holiday.date.year);
      if (holiday.type != HolidayType.company) {
        throw ArgumentError('extraHolidays must use Holiday.company.');
      }
      if (byId.containsKey(holiday.id) || overridden.contains(holiday.id)) {
        throw ArgumentError('Duplicate holiday ID: ${holiday.id}');
      }
      byId[holiday.id] = holiday;
    }
    for (final id in this.selectedOptionalHolidayIds) {
      final holiday = byId[id];
      if (holiday == null || holiday.type != HolidayType.optional) {
        throw ArgumentError('Unknown, removed or non-optional holiday: $id');
      }
      if (!holiday.appliesTo(district)) {
        throw ArgumentError(
            'Optional holiday $id does not apply to this district.');
      }
    }

    final sorted = byId.values.toList()..sort(_compareHolidays);
    _holidays = List.unmodifiable(sorted);
    final index = <String, List<Holiday>>{};
    for (final holiday in sorted) {
      (index[dateKey(holiday.date)] ??= []).add(holiday);
    }
    _byDate = Map.unmodifiable({
      for (final entry in index.entries)
        entry.key: List<Holiday>.unmodifiable(entry.value),
    });
  }

  /// Weekdays normally excluded from work, using [DateTime] weekday constants.
  final Set<int> weekendDays;

  /// Office district; null applies only unrestricted nationwide holidays.
  final District? district;

  /// General and/or executive-order categories that close this office.
  final Set<HolidayType> include;

  /// Explicitly approved optional occurrences that close this office.
  final Set<String> selectedOptionalHolidayIds;

  /// Whether official office-opening dates override the weekly weekend rule.
  /// Set false for organizations that do not follow those government orders.
  final bool applyGovernmentWorkingDays;

  late final List<Holiday> _holidays;
  late final Map<String, List<Holiday>> _byDate;

  /// Bundled years, in ascending order, as an immutable list.
  List<int> get supportedYears =>
      List.unmodifiable(generatedCoverage.map((item) => item.year));

  /// Whether queries for [year] are supported by this version's snapshot.
  bool isCovered(int year) =>
      generatedCoverage.any((item) => item.year == year);

  /// Sources and verification scope for [year].
  ///
  /// Throws [CoverageException] when [year] is not bundled.
  YearCoverage coverageFor(int year) {
    _requireYear(year);
    return generatedCoverage.firstWhere((item) => item.year == year);
  }

  /// All recorded occurrences in [year], including unselected optional holidays.
  /// [district] filters the catalog independently of the office's district.
  ///
  /// [types] and [community] narrow the catalog without approving leave.
  /// [applicableOnly] additionally applies this calendar's office rules.
  /// Results are immutable and sorted by date, then ID. An unsupported [year]
  /// throws [CoverageException]. A null [district] adds no catalog filter.
  List<Holiday> holidaysIn(
    int year, {
    Set<HolidayType>? types,
    HolidayCommunity? community,
    District? district,
    bool applicableOnly = false,
  }) {
    _requireYear(year);
    return _filter(
      _holidays.where((holiday) => holiday.date.year == year),
      types: types,
      community: community,
      district: district,
      applicableOnly: applicableOnly,
    );
  }

  /// Occurrences in [month] (1–12), with the same filters as [holidaysIn].
  ///
  /// An invalid month throws [ArgumentError]; an unsupported year throws
  /// [CoverageException].
  List<Holiday> holidaysInMonth(
    int year,
    int month, {
    Set<HolidayType>? types,
    HolidayCommunity? community,
    District? district,
    bool applicableOnly = false,
  }) {
    if (month < 1 || month > 12) {
      throw ArgumentError.value(month, 'month', 'Expected 1–12');
    }
    return List.unmodifiable(holidaysIn(
      year,
      types: types,
      community: community,
      district: district,
      applicableOnly: applicableOnly,
    ).where((holiday) => holiday.date.month == month));
  }

  /// All occurrences on a date. An empty list never means missing year data.
  ///
  /// Filters follow [holidaysIn]; an unsupported year throws
  /// [CoverageException]. Time of day is ignored without converting time zones.
  List<Holiday> holidaysOn(
    DateTime date, {
    Set<HolidayType>? types,
    HolidayCommunity? community,
    District? district,
    bool applicableOnly = false,
  }) {
    _requireYear(date.year);
    return _filter(
      _byDate[dateKey(date)] ?? const [],
      types: types,
      community: community,
      district: district,
      applicableOnly: applicableOnly,
    );
  }

  /// Occurrences in `[start, end)`: start included, end excluded.
  ///
  /// Filters follow [holidaysIn]. Reversed ranges throw [ArgumentError].
  /// Every touched year must be covered or [CoverageException] is thrown.
  /// Empty ranges still require the starting year to be covered.
  List<Holiday> holidaysBetween(
    DateTime start,
    DateTime end, {
    Set<HolidayType>? types,
    HolidayCommunity? community,
    District? district,
    bool applicableOnly = false,
  }) {
    final first = calendarDate(start);
    final limit = calendarDate(end);
    _requireRange(first, limit);
    return _filter(
      _holidays.where((holiday) =>
          !holiday.date.isBefore(first) && holiday.date.isBefore(limit)),
      types: types,
      community: community,
      district: district,
      applicableOnly: applicableOnly,
    );
  }

  /// Whether an applicable holiday closes this office (weekends alone do not).
  bool isHoliday(DateTime date) =>
      holidaysOn(date, applicableOnly: true).isNotEmpty;

  /// Every holiday on the next matching date, not just the first occurrence.
  /// By default searches strictly after [from] and uses the office policy.
  /// Throws [CoverageException] on reaching the first unbundled year.
  List<Holiday> nextHolidays({
    required DateTime from,
    bool inclusive = false,
    bool applicableOnly = true,
  }) {
    var date = calendarDate(from);
    _requireYear(date.year);
    if (!inclusive) date = date.add(const Duration(days: 1));
    while (true) {
      final holidays = holidaysOn(date, applicableOnly: applicableOnly);
      if (holidays.isNotEmpty) return holidays;
      date = date.add(const Duration(days: 1));
    }
  }

  /// Office-specific closures and any government instruction opening a weekend.
  DayStatus dayStatus(DateTime date) {
    final normalized = calendarDate(date);
    _requireYear(normalized.year);
    GovernmentWorkingDay? workingDay;
    if (applyGovernmentWorkingDays) {
      for (final item in generatedWorkingDays) {
        if (item.date == normalized) {
          workingDay = item;
          break;
        }
      }
    }
    return DayStatus(
      date: normalized,
      isWeekend: weekendDays.contains(normalized.weekday),
      holidays: holidaysOn(normalized, applicableOnly: true),
      governmentWorkingDay: workingDay,
    );
  }

  /// Whether [date] is open under this office's holiday and weekend rules.
  ///
  /// Throws [CoverageException] for an unsupported year.
  bool isBusinessDay(DateTime date) => dayStatus(date).isBusinessDay;

  /// Detailed daily explanations for `[start, end)`, including working dates.
  ///
  /// Returns an immutable chronological list. Reversed ranges throw
  /// [ArgumentError]; unsupported years throw [CoverageException].
  List<DayStatus> daysBetween(DateTime start, DateTime end) {
    final first = calendarDate(start);
    final limit = calendarDate(end);
    _requireRange(first, limit);
    return List.unmodifiable([
      for (var date = first;
          date.isBefore(limit);
          date = date.add(const Duration(days: 1)))
        dayStatus(date),
    ]);
  }

  /// Counts working dates in `[start, end)` using this calendar's office rules.
  ///
  /// Shares the range and coverage rules of [daysBetween].
  int businessDaysBetween(DateTime start, DateTime end) =>
      daysBetween(start, end).where((day) => day.isBusinessDay).length;

  /// Moves [count] working days, excluding the starting day in either direction.
  /// Zero returns the same normalized date, even if it is not a working day.
  ///
  /// A negative [count] searches backward. Reaching an unsupported year throws
  /// [CoverageException]; no extrapolation is made beyond the snapshot.
  DateTime addBusinessDays(DateTime from, int count) {
    var date = calendarDate(from);
    _requireYear(date.year);
    final step = Duration(days: count < 0 ? -1 : 1);
    var remaining = count;
    // Keep the sign: the smallest VM integer cannot be represented as positive.
    while (remaining != 0) {
      date = date.add(step);
      if (isBusinessDay(date)) remaining += count < 0 ? 1 : -1;
    }
    return date;
  }

  /// All published office-opening orders in [year], regardless of office policy.
  ///
  /// This informational list remains available when [applyGovernmentWorkingDays]
  /// is false. An unsupported year throws [CoverageException].
  List<GovernmentWorkingDay> governmentWorkingDaysIn(int year) {
    _requireYear(year);
    return List.unmodifiable(
      generatedWorkingDays.where((day) => day.date.year == year),
    );
  }

  bool _applies(Holiday holiday) =>
      holiday.appliesTo(district) &&
      switch (holiday.type) {
        HolidayType.optional => selectedOptionalHolidayIds.contains(holiday.id),
        HolidayType.company => true,
        _ => include.contains(holiday.type),
      };

  List<Holiday> _filter(
    Iterable<Holiday> holidays, {
    Set<HolidayType>? types,
    HolidayCommunity? community,
    District? district,
    required bool applicableOnly,
  }) =>
      List.unmodifiable(holidays.where((holiday) =>
          (types == null || types.contains(holiday.type)) &&
          (community == null || holiday.community == community) &&
          (district == null || holiday.appliesTo(district)) &&
          (!applicableOnly || _applies(holiday))));

  void _requireYear(int year) {
    if (!isCovered(year)) throw CoverageException(year, supportedYears);
  }

  void _requireRange(DateTime start, DateTime end) {
    if (end.isBefore(start)) {
      throw ArgumentError('end must be on or after start.');
    }
    _requireYear(start.year);
    if (start == end) return;
    final lastYear = end.subtract(const Duration(days: 1)).year;
    for (var year = start.year + 1; year <= lastYear; year++) {
      _requireYear(year);
    }
  }

  static int _compareHolidays(Holiday a, Holiday b) {
    final dateOrder = a.date.compareTo(b.date);
    return dateOrder == 0 ? a.id.compareTo(b.id) : dateOrder;
  }
}
