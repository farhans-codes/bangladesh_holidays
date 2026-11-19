import 'date.dart';

/// The notice's legal category; regional applicability is stored separately.
enum HolidayType {
  /// General leave listed in the official calendar.
  general,

  /// Leave declared by executive order.
  executiveOrder,

  /// Community-specific leave requiring explicit individual approval.
  optional,

  /// A caller-supplied organizational closure, without official status.
  company
}

/// Communities used to browse optional holidays, not automatic leave approval.
enum HolidayCommunity {
  /// Muslim optional-holiday list.
  muslim,

  /// Hindu optional-holiday list.
  hindu,

  /// Christian optional-holiday list.
  christian,

  /// Buddhist optional-holiday list.
  buddhist,

  /// Indigenous-community optional-holiday list.
  indigenous
}

/// Bangladesh districts. A null district selects nationwide holidays only.
enum District {
  bagerhat,
  bandarban,
  barguna,
  barishal,
  bhola,
  bogura,
  brahmanbaria,
  chandpur,
  chapainawabganj,
  chattogram,
  chuadanga,
  coxsBazar,
  cumilla,
  dhaka,
  dinajpur,
  faridpur,
  feni,
  gaibandha,
  gazipur,
  gopalganj,
  habiganj,
  jamalpur,
  jashore,
  jhalokathi,
  jhenaidah,
  joypurhat,
  khagrachhari,
  khulna,
  kishoreganj,
  kurigram,
  kushtia,
  lakshmipur,
  lalmonirhat,
  madaripur,
  magura,
  manikganj,
  meherpur,
  moulvibazar,
  munshiganj,
  mymensingh,
  naogaon,
  narail,
  narayanganj,
  narsingdi,
  natore,
  netrokona,
  nilphamari,
  noakhali,
  pabna,
  panchagarh,
  patuakhali,
  pirojpur,
  rajbari,
  rajshahi,
  rangamati,
  rangpur,
  satkhira,
  shariatpur,
  sherpur,
  sirajganj,
  sunamganj,
  sylhet,
  tangail,
  thakurgaon,
}

/// An official publication supporting a holiday or a special working date.
class HolidaySource {
  /// Creates publication metadata; the original notice remains authoritative.
  const HolidaySource({
    required this.id,
    required this.title,
    required this.url,
    required this.publishedOn,
  });

  /// Stable source identifier shared by occurrences supported by this notice.
  final String id;

  /// Human-readable title of the official publication.
  final String title;

  /// HTTPS link to the original publication, typically a government PDF.
  final String url;

  /// Publication date in YYYY-MM-DD form, as printed in the notice.
  final String publishedOn;
}

/// One holiday occurrence. Several occurrences can share a calendar date.
class Holiday {
  /// Creates a dated occurrence with copied, immutable district sets.
  ///
  /// Dates use their supplied year/month/day and are stored at UTC midnight.
  /// Empty IDs/names, optional holidays without a community, conflicting
  /// district restrictions and official holidays without a source throw
  /// [ArgumentError]. Prefer [Holiday.company] for organizational closures.
  Holiday({
    required this.id,
    required DateTime date,
    required this.nameEn,
    required this.nameBn,
    required this.type,
    this.community,
    Iterable<District> districts = const [],
    Iterable<District> excludedDistricts = const [],
    this.isEstimated = false,
    this.source,
    this.notesEn = '',
    this.notesBn = '',
    DateTime? originalDate,
  })  : date = calendarDate(date),
        districts = Set.unmodifiable(districts),
        excludedDistricts = Set.unmodifiable(excludedDistricts),
        originalDate =
            originalDate == null ? null : calendarDate(originalDate) {
    if (id.trim().isEmpty || nameEn.trim().isEmpty || nameBn.trim().isEmpty) {
      throw ArgumentError('Holiday id and both names must be non-empty.');
    }
    if (type == HolidayType.optional && community == null) {
      throw ArgumentError('An optional holiday needs a community.');
    }
    if (this.districts.intersection(this.excludedDistricts).isNotEmpty) {
      throw ArgumentError('A district cannot be both included and excluded.');
    }
    if (type != HolidayType.company && source == null) {
      throw ArgumentError('An official holiday needs a source.');
    }
  }

  /// Creates an organization-specific closure without implying official status.
  factory Holiday.company({
    required String id,
    required DateTime date,
    required String nameEn,
    required String nameBn,
  }) =>
      Holiday(
        id: id,
        date: date,
        nameEn: nameEn,
        nameBn: nameBn,
        type: HolidayType.company,
      );

  /// Stable within the dataset; a date override does not change this identifier.
  final String id;

  /// Current civil date, represented as a UTC-midnight date container.
  final DateTime date;

  /// English name of this occurrence.
  final String nameEn;

  /// Bangla name of this occurrence.
  final String nameBn;

  /// Legal category, independent of regional applicability.
  final HolidayType type;

  /// Community associated with an optional occurrence, when applicable.
  final HolidayCommunity? community;

  /// Included districts; an empty set means no inclusion restriction.
  final Set<District> districts;

  /// Districts excluded even if otherwise included.
  final Set<District> excludedDistricts;

  /// True when the source marks the date as moon/lunar dependent and no later
  /// confirmation has been incorporated. Passing time does not confirm a date.
  final bool isEstimated;

  /// Official notice supporting the published occurrence; null for company days.
  final HolidaySource? source;

  /// Additional applicability or source notes in English; empty when absent.
  final String notesEn;

  /// Additional applicability or source notes in Bangla; empty when absent.
  final String notesBn;

  /// The published date when the caller has moved this occurrence.
  /// The original source supports this date, not the caller's replacement.
  final DateTime? originalDate;

  /// Whether this occurrence retains a published date from a caller override.
  bool get isDateOverridden => originalDate != null;

  /// Restricted holidays require an explicit district, including exclusions.
  bool appliesTo(District? district) {
    if (district == null) {
      return districts.isEmpty && excludedDistricts.isEmpty;
    }
    return (districts.isEmpty || districts.contains(district)) &&
        !excludedDistricts.contains(district);
  }

  /// Returns a copy on [date], preserving the first published [originalDate].
  ///
  /// [isEstimated] defaults to this occurrence's flag. Changing it represents
  /// the caller's confirmation; the original [source] does not endorse the edit.
  /// Other occurrences, including adjacent festival leave, are unaffected.
  Holiday moveTo(DateTime date, {bool? isEstimated}) => Holiday(
        id: id,
        date: date,
        nameEn: nameEn,
        nameBn: nameBn,
        type: type,
        community: community,
        districts: districts,
        excludedDistricts: excludedDistricts,
        isEstimated: isEstimated ?? this.isEstimated,
        source: source,
        notesEn: notesEn,
        notesBn: notesBn,
        originalDate: originalDate ?? this.date,
      );

  @override
  String toString() => '$id (${dateKey(date)}): $nameEn';
}

/// A caller's change to one official occurrence, addressed by stable ID.
class HolidayOverride {
  /// Moves [holidayId] to a civil [date], optionally changing its uncertainty.
  ///
  /// The calendar validates the ID and coverage when applying this override.
  HolidayOverride.move({
    required this.holidayId,
    required DateTime date,
    this.isEstimated,
  }) : date = calendarDate(date);

  /// Excludes [holidayId] while leaving other occurrences on that date intact.
  const HolidayOverride.remove(this.holidayId)
      : date = null,
        isEstimated = null;

  /// Stable identifier of the official occurrence to change.
  final String holidayId;

  /// Replacement UTC-midnight date, or null for a removal.
  final DateTime? date;

  /// Replacement uncertainty flag, or null to preserve the existing flag.
  final bool? isEstimated;
}

/// An official instruction opening an otherwise weekly day off.
/// It suppresses the weekend rule only; explicit holidays still close the day.
class GovernmentWorkingDay {
  /// Creates an office-opening record, normalizing [date] to UTC midnight.
  GovernmentWorkingDay({
    required DateTime date,
    required this.nameEn,
    required this.nameBn,
    required this.source,
  }) : date = calendarDate(date);

  /// Civil date on which the official opening instruction applies.
  final DateTime date;

  /// English description of the opening instruction.
  final String nameEn;

  /// Bangla description of the opening instruction.
  final String nameBn;

  /// Official notice authorizing this opening date.
  final HolidaySource source;
}

/// Coverage describes the bundled snapshot, not a live synchronization promise.
class YearCoverage {
  /// Creates snapshot metadata with a copied, immutable source list.
  YearCoverage({
    required this.year,
    required this.verifiedOn,
    required Iterable<HolidaySource> sources,
    required this.scope,
  }) : sources = List.unmodifiable(sources);

  /// Gregorian year represented by this snapshot.
  final int year;

  /// Last source-review date in YYYY-MM-DD form.
  final String verifiedOn;

  /// Annual notice and incorporated amendments for this year.
  final List<HolidaySource> sources;

  /// Human-readable inclusions and exclusions of the dataset.
  final String scope;
}

/// Why a day is excluded from business-day calculations.
enum NonWorkingReason {
  /// A configured weekly day off without an applicable office-opening order.
  weekend,

  /// An included general or executive-order holiday.
  publicHoliday,

  /// An optional occurrence explicitly selected for this office.
  optionalHoliday,

  /// A caller-supplied company closure.
  companyHoliday
}

/// A date and all reasons relevant to the configured office calendar.
class DayStatus {
  /// Creates a day's explanation with a copied, immutable list of closures.
  ///
  /// Calendar queries supply a normalized [date] and already-applicable
  /// [holidays]; this constructor does not apply an office policy itself.
  DayStatus({
    required this.date,
    required this.isWeekend,
    required Iterable<Holiday> holidays,
    this.governmentWorkingDay,
  }) : holidays = List.unmodifiable(holidays);

  /// Date being explained; calendar queries return a UTC-midnight civil date.
  final DateTime date;

  /// Whether the weekday is configured as a weekend, before official overrides.
  final bool isWeekend;

  /// Only closures applicable to this office, including selected optional days.
  final List<Holiday> holidays;

  /// Opening order applied by this calendar, if its policy enables the order.
  final GovernmentWorkingDay? governmentWorkingDay;

  /// Whether no holiday closes the date and its weekend rule allows work.
  bool get isBusinessDay =>
      holidays.isEmpty && (!isWeekend || governmentWorkingDay != null);

  /// Whether an applicable closure still carries lunar/date uncertainty.
  bool get hasEstimatedHoliday => holidays.any((h) => h.isEstimated);

  /// Distinct active exclusion reasons; empty for a working date.
  Set<NonWorkingReason> get reasons => Set.unmodifiable({
        if (isWeekend && governmentWorkingDay == null) NonWorkingReason.weekend,
        for (final holiday in holidays)
          switch (holiday.type) {
            HolidayType.general ||
            HolidayType.executiveOrder =>
              NonWorkingReason.publicHoliday,
            HolidayType.optional => NonWorkingReason.optionalHoliday,
            HolidayType.company => NonWorkingReason.companyHoliday,
          },
      });
}

/// A requested date lies outside the bundled dataset.
class CoverageException implements Exception {
  /// Reports [year] as unavailable, retaining a copy of the supported years.
  CoverageException(this.year, Iterable<int> supportedYears)
      : supportedYears = List.unmodifiable(supportedYears);

  /// First unsupported year encountered by the query or calculation.
  final int year;

  /// Bundled alternatives available in this package version.
  final List<int> supportedYears;

  @override
  String toString() => 'CoverageException: no data for $year. '
      'Supported years: ${supportedYears.join(', ')}.';
}
