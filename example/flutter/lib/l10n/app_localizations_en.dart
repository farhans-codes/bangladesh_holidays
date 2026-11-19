// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Bangladesh Holidays';

  @override
  String get calendar => 'Calendar';

  @override
  String get calculateTab => 'Calculate';

  @override
  String get rules => 'Rules';

  @override
  String get language => 'বাংলা';

  @override
  String get switchLanguage => 'Switch to Bangla';

  @override
  String get sample => 'Example: 12–18 April 2027';

  @override
  String get district => 'District';

  @override
  String get nationwide => 'Nationwide only';

  @override
  String get weekends => 'Weekly days off';

  @override
  String get editRules => 'Edit office rules';

  @override
  String get previousMonth => 'Previous month';

  @override
  String get nextMonth => 'Next month';

  @override
  String get selectMonth => 'Choose a date';

  @override
  String get workingDay => 'Working day';

  @override
  String get holiday => 'Holiday';

  @override
  String get weekend => 'Weekend';

  @override
  String get selectedRange => 'Selected range';

  @override
  String get counted => 'Counted';

  @override
  String get excluded => 'Excluded';

  @override
  String get general => 'General holiday';

  @override
  String get executiveOrder => 'Executive holiday';

  @override
  String get optional => 'Optional holiday';

  @override
  String get company => 'Company holiday';

  @override
  String get unselectedOptional => 'Optional · not selected';

  @override
  String get estimated => 'Lunar-dependent date';

  @override
  String get viewSource => 'View source';

  @override
  String get sourceUnavailable => 'Could not open the source link.';

  @override
  String get noHoliday => 'No holiday for this office.';

  @override
  String get officeOpen => 'Office opens by government order';

  @override
  String get calculateAction => 'Calculate working days';

  @override
  String get countTitle => 'Count working days';

  @override
  String get countDays => 'Count days';

  @override
  String get addDays => 'Add days';

  @override
  String get from => 'From';

  @override
  String get through => 'Through (included)';

  @override
  String get amount => 'Working days to add';

  @override
  String get amountHint => 'Use a negative number to go back';

  @override
  String get calculate => 'Calculate';

  @override
  String get resultDate => 'Resulting date';

  @override
  String get inclusiveHint => 'Both selected dates are included.';

  @override
  String get addHint =>
      'The starting date is excluded; zero keeps the same date.';

  @override
  String daysResult(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString working days';
  }

  @override
  String rangeResult(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString calendar days · both ends included';
  }

  @override
  String get invalidRange => 'Choose an end date on or after the start date.';

  @override
  String get invalidAmount => 'Enter a whole number between −730 and 730.';

  @override
  String get coverageError =>
      'This calculation reaches an unsupported year. Data covers 2026 and 2027.';

  @override
  String get pendingResult => 'Choose your dates, then calculate.';

  @override
  String get breakdown => 'Day-by-day breakdown';

  @override
  String get uncertainResult =>
      'Includes lunar-dependent holidays; dates may change.';

  @override
  String get rulesIntro =>
      'Make the calendar match your office. Changes apply to both tabs.';

  @override
  String get weekendError => 'Keep at least one working weekday.';

  @override
  String get followGeneral => 'Include general holidays';

  @override
  String get followExecutive => 'Include executive holidays';

  @override
  String get followWorking => 'Follow official office-opening orders';

  @override
  String get followWorkingHint =>
      'An opening order overrides the weekly day off, but not another active holiday.';

  @override
  String get optionalTitle => 'Approved optional holidays';

  @override
  String get optionalHint =>
      'Select only dates approved for your office. Browsing a community does not select its holidays.';

  @override
  String get year => 'Year';

  @override
  String get communityFilter => 'Community';

  @override
  String get allCommunities => 'All communities';

  @override
  String get muslim => 'Muslim';

  @override
  String get hindu => 'Hindu';

  @override
  String get christian => 'Christian';

  @override
  String get buddhist => 'Buddhist';

  @override
  String get indigenous => 'Indigenous communities';

  @override
  String get companyTitle => 'Company closures';

  @override
  String get addCompany => 'Add a closure';

  @override
  String get closureName => 'Closure name';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get remove => 'Remove';

  @override
  String get emptyName => 'Enter a name for this closure.';

  @override
  String get noCompany => 'No company closures added.';

  @override
  String get appearance => 'Appearance';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get coverageTitle => 'Bundled data: 2026–2027';

  @override
  String get coverageHint =>
      'Offline snapshot checked 19 November 2026. Bank, school, court, industry-specific and constituency-only calendars are outside this demo.';

  @override
  String get sessionHint =>
      'Rules are kept for this session. Restarting resets the demo.';

  @override
  String get resetRules => 'Reset office rules';

  @override
  String get customDate => 'Date changed by your office';

  @override
  String get moveDate => 'Move this holiday';

  @override
  String get removeHoliday => 'Ignore this holiday';

  @override
  String get overridesTitle => 'Holiday overrides';

  @override
  String get overridesHint =>
      'Move or ignore an official holiday from its calendar detail. Reset restores the published dates.';

  @override
  String overrideCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString changes applied';
  }

  @override
  String get restore => 'Restore published dates';

  @override
  String get mon => 'Mon';

  @override
  String get tue => 'Tue';

  @override
  String get wed => 'Wed';

  @override
  String get thu => 'Thu';

  @override
  String get fri => 'Fri';

  @override
  String get sat => 'Sat';

  @override
  String get sun => 'Sun';

  @override
  String get none => 'None';

  @override
  String get districtBagerhat => 'Bagerhat';

  @override
  String get districtBandarban => 'Bandarban';

  @override
  String get districtBarguna => 'Barguna';

  @override
  String get districtBarishal => 'Barishal';

  @override
  String get districtBhola => 'Bhola';

  @override
  String get districtBogura => 'Bogura';

  @override
  String get districtBrahmanbaria => 'Brahmanbaria';

  @override
  String get districtChandpur => 'Chandpur';

  @override
  String get districtChapainawabganj => 'Chapainawabganj';

  @override
  String get districtChattogram => 'Chattogram';

  @override
  String get districtChuadanga => 'Chuadanga';

  @override
  String get districtCoxsBazar => 'Cox\'s Bazar';

  @override
  String get districtCumilla => 'Cumilla';

  @override
  String get districtDhaka => 'Dhaka';

  @override
  String get districtDinajpur => 'Dinajpur';

  @override
  String get districtFaridpur => 'Faridpur';

  @override
  String get districtFeni => 'Feni';

  @override
  String get districtGaibandha => 'Gaibandha';

  @override
  String get districtGazipur => 'Gazipur';

  @override
  String get districtGopalganj => 'Gopalganj';

  @override
  String get districtHabiganj => 'Habiganj';

  @override
  String get districtJamalpur => 'Jamalpur';

  @override
  String get districtJashore => 'Jashore';

  @override
  String get districtJhalokathi => 'Jhalokathi';

  @override
  String get districtJhenaidah => 'Jhenaidah';

  @override
  String get districtJoypurhat => 'Joypurhat';

  @override
  String get districtKhagrachhari => 'Khagrachhari';

  @override
  String get districtKhulna => 'Khulna';

  @override
  String get districtKishoreganj => 'Kishoreganj';

  @override
  String get districtKurigram => 'Kurigram';

  @override
  String get districtKushtia => 'Kushtia';

  @override
  String get districtLakshmipur => 'Lakshmipur';

  @override
  String get districtLalmonirhat => 'Lalmonirhat';

  @override
  String get districtMadaripur => 'Madaripur';

  @override
  String get districtMagura => 'Magura';

  @override
  String get districtManikganj => 'Manikganj';

  @override
  String get districtMeherpur => 'Meherpur';

  @override
  String get districtMoulvibazar => 'Moulvibazar';

  @override
  String get districtMunshiganj => 'Munshiganj';

  @override
  String get districtMymensingh => 'Mymensingh';

  @override
  String get districtNaogaon => 'Naogaon';

  @override
  String get districtNarail => 'Narail';

  @override
  String get districtNarayanganj => 'Narayanganj';

  @override
  String get districtNarsingdi => 'Narsingdi';

  @override
  String get districtNatore => 'Natore';

  @override
  String get districtNetrokona => 'Netrokona';

  @override
  String get districtNilphamari => 'Nilphamari';

  @override
  String get districtNoakhali => 'Noakhali';

  @override
  String get districtPabna => 'Pabna';

  @override
  String get districtPanchagarh => 'Panchagarh';

  @override
  String get districtPatuakhali => 'Patuakhali';

  @override
  String get districtPirojpur => 'Pirojpur';

  @override
  String get districtRajbari => 'Rajbari';

  @override
  String get districtRajshahi => 'Rajshahi';

  @override
  String get districtRangamati => 'Rangamati';

  @override
  String get districtRangpur => 'Rangpur';

  @override
  String get districtSatkhira => 'Satkhira';

  @override
  String get districtShariatpur => 'Shariatpur';

  @override
  String get districtSherpur => 'Sherpur';

  @override
  String get districtSirajganj => 'Sirajganj';

  @override
  String get districtSunamganj => 'Sunamganj';

  @override
  String get districtSylhet => 'Sylhet';

  @override
  String get districtTangail => 'Tangail';

  @override
  String get districtThakurgaon => 'Thakurgaon';

  @override
  String get monCompact => 'Mon';

  @override
  String get tueCompact => 'Tue';

  @override
  String get wedCompact => 'Wed';

  @override
  String get thuCompact => 'Thu';

  @override
  String get friCompact => 'Fri';

  @override
  String get satCompact => 'Sat';

  @override
  String get sunCompact => 'Sun';

  @override
  String rangeSelection(String from, String through) {
    return 'Selected range: $from – $through';
  }

  @override
  String traversedDays(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Examined $countString calendar days · start excluded';
  }
}
