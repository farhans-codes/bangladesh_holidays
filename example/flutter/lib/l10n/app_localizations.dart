// ignore_for_file: deprecated_member_use
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Bangladesh Holidays'**
  String get appTitle;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @calculateTab.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculateTab;

  /// No description provided for @rules.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get rules;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'বাংলা'**
  String get language;

  /// No description provided for @switchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Switch to Bangla'**
  String get switchLanguage;

  /// No description provided for @sample.
  ///
  /// In en, this message translates to:
  /// **'Example: 12–18 April 2027'**
  String get sample;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @nationwide.
  ///
  /// In en, this message translates to:
  /// **'Nationwide only'**
  String get nationwide;

  /// No description provided for @weekends.
  ///
  /// In en, this message translates to:
  /// **'Weekly days off'**
  String get weekends;

  /// No description provided for @editRules.
  ///
  /// In en, this message translates to:
  /// **'Edit office rules'**
  String get editRules;

  /// No description provided for @previousMonth.
  ///
  /// In en, this message translates to:
  /// **'Previous month'**
  String get previousMonth;

  /// No description provided for @nextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get nextMonth;

  /// No description provided for @selectMonth.
  ///
  /// In en, this message translates to:
  /// **'Choose a date'**
  String get selectMonth;

  /// No description provided for @workingDay.
  ///
  /// In en, this message translates to:
  /// **'Working day'**
  String get workingDay;

  /// No description provided for @holiday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get holiday;

  /// No description provided for @weekend.
  ///
  /// In en, this message translates to:
  /// **'Weekend'**
  String get weekend;

  /// No description provided for @selectedRange.
  ///
  /// In en, this message translates to:
  /// **'Selected range'**
  String get selectedRange;

  /// No description provided for @counted.
  ///
  /// In en, this message translates to:
  /// **'Counted'**
  String get counted;

  /// No description provided for @excluded.
  ///
  /// In en, this message translates to:
  /// **'Excluded'**
  String get excluded;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General holiday'**
  String get general;

  /// No description provided for @executiveOrder.
  ///
  /// In en, this message translates to:
  /// **'Executive holiday'**
  String get executiveOrder;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional holiday'**
  String get optional;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Company holiday'**
  String get company;

  /// No description provided for @unselectedOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional · not selected'**
  String get unselectedOptional;

  /// No description provided for @estimated.
  ///
  /// In en, this message translates to:
  /// **'Lunar-dependent date'**
  String get estimated;

  /// No description provided for @viewSource.
  ///
  /// In en, this message translates to:
  /// **'View source'**
  String get viewSource;

  /// No description provided for @sourceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Could not open the source link.'**
  String get sourceUnavailable;

  /// No description provided for @noHoliday.
  ///
  /// In en, this message translates to:
  /// **'No holiday for this office.'**
  String get noHoliday;

  /// No description provided for @officeOpen.
  ///
  /// In en, this message translates to:
  /// **'Office opens by government order'**
  String get officeOpen;

  /// No description provided for @calculateAction.
  ///
  /// In en, this message translates to:
  /// **'Calculate working days'**
  String get calculateAction;

  /// No description provided for @countTitle.
  ///
  /// In en, this message translates to:
  /// **'Count working days'**
  String get countTitle;

  /// No description provided for @countDays.
  ///
  /// In en, this message translates to:
  /// **'Count days'**
  String get countDays;

  /// No description provided for @addDays.
  ///
  /// In en, this message translates to:
  /// **'Add days'**
  String get addDays;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @through.
  ///
  /// In en, this message translates to:
  /// **'Through (included)'**
  String get through;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Working days to add'**
  String get amount;

  /// No description provided for @amountHint.
  ///
  /// In en, this message translates to:
  /// **'Use a negative number to go back'**
  String get amountHint;

  /// No description provided for @calculate.
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get calculate;

  /// No description provided for @resultDate.
  ///
  /// In en, this message translates to:
  /// **'Resulting date'**
  String get resultDate;

  /// No description provided for @inclusiveHint.
  ///
  /// In en, this message translates to:
  /// **'Both selected dates are included.'**
  String get inclusiveHint;

  /// No description provided for @addHint.
  ///
  /// In en, this message translates to:
  /// **'The starting date is excluded; zero keeps the same date.'**
  String get addHint;

  /// No description provided for @daysResult.
  ///
  /// In en, this message translates to:
  /// **'{count} working days'**
  String daysResult(int count);

  /// No description provided for @rangeResult.
  ///
  /// In en, this message translates to:
  /// **'{count} calendar days · both ends included'**
  String rangeResult(int count);

  /// No description provided for @invalidRange.
  ///
  /// In en, this message translates to:
  /// **'Choose an end date on or after the start date.'**
  String get invalidRange;

  /// No description provided for @invalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter a whole number between −730 and 730.'**
  String get invalidAmount;

  /// No description provided for @coverageError.
  ///
  /// In en, this message translates to:
  /// **'This calculation reaches an unsupported year. Data covers 2026 and 2027.'**
  String get coverageError;

  /// No description provided for @pendingResult.
  ///
  /// In en, this message translates to:
  /// **'Choose your dates, then calculate.'**
  String get pendingResult;

  /// No description provided for @breakdown.
  ///
  /// In en, this message translates to:
  /// **'Day-by-day breakdown'**
  String get breakdown;

  /// No description provided for @uncertainResult.
  ///
  /// In en, this message translates to:
  /// **'Includes lunar-dependent holidays; dates may change.'**
  String get uncertainResult;

  /// No description provided for @rulesIntro.
  ///
  /// In en, this message translates to:
  /// **'Make the calendar match your office. Changes apply to both tabs.'**
  String get rulesIntro;

  /// No description provided for @weekendError.
  ///
  /// In en, this message translates to:
  /// **'Keep at least one working weekday.'**
  String get weekendError;

  /// No description provided for @followGeneral.
  ///
  /// In en, this message translates to:
  /// **'Include general holidays'**
  String get followGeneral;

  /// No description provided for @followExecutive.
  ///
  /// In en, this message translates to:
  /// **'Include executive holidays'**
  String get followExecutive;

  /// No description provided for @followWorking.
  ///
  /// In en, this message translates to:
  /// **'Follow official office-opening orders'**
  String get followWorking;

  /// No description provided for @followWorkingHint.
  ///
  /// In en, this message translates to:
  /// **'An opening order overrides the weekly day off, but not another active holiday.'**
  String get followWorkingHint;

  /// No description provided for @optionalTitle.
  ///
  /// In en, this message translates to:
  /// **'Approved optional holidays'**
  String get optionalTitle;

  /// No description provided for @optionalHint.
  ///
  /// In en, this message translates to:
  /// **'Select only dates approved for your office. Browsing a community does not select its holidays.'**
  String get optionalHint;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @communityFilter.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get communityFilter;

  /// No description provided for @allCommunities.
  ///
  /// In en, this message translates to:
  /// **'All communities'**
  String get allCommunities;

  /// No description provided for @muslim.
  ///
  /// In en, this message translates to:
  /// **'Muslim'**
  String get muslim;

  /// No description provided for @hindu.
  ///
  /// In en, this message translates to:
  /// **'Hindu'**
  String get hindu;

  /// No description provided for @christian.
  ///
  /// In en, this message translates to:
  /// **'Christian'**
  String get christian;

  /// No description provided for @buddhist.
  ///
  /// In en, this message translates to:
  /// **'Buddhist'**
  String get buddhist;

  /// No description provided for @indigenous.
  ///
  /// In en, this message translates to:
  /// **'Indigenous communities'**
  String get indigenous;

  /// No description provided for @companyTitle.
  ///
  /// In en, this message translates to:
  /// **'Company closures'**
  String get companyTitle;

  /// No description provided for @addCompany.
  ///
  /// In en, this message translates to:
  /// **'Add a closure'**
  String get addCompany;

  /// No description provided for @closureName.
  ///
  /// In en, this message translates to:
  /// **'Closure name'**
  String get closureName;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @emptyName.
  ///
  /// In en, this message translates to:
  /// **'Enter a name for this closure.'**
  String get emptyName;

  /// No description provided for @noCompany.
  ///
  /// In en, this message translates to:
  /// **'No company closures added.'**
  String get noCompany;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @coverageTitle.
  ///
  /// In en, this message translates to:
  /// **'Bundled data: 2026–2027'**
  String get coverageTitle;

  /// No description provided for @coverageHint.
  ///
  /// In en, this message translates to:
  /// **'Offline snapshot checked 19 November 2026. Bank, school, court, industry-specific and constituency-only calendars are outside this demo.'**
  String get coverageHint;

  /// No description provided for @sessionHint.
  ///
  /// In en, this message translates to:
  /// **'Rules are kept for this session. Restarting resets the demo.'**
  String get sessionHint;

  /// No description provided for @resetRules.
  ///
  /// In en, this message translates to:
  /// **'Reset office rules'**
  String get resetRules;

  /// No description provided for @customDate.
  ///
  /// In en, this message translates to:
  /// **'Date changed by your office'**
  String get customDate;

  /// No description provided for @moveDate.
  ///
  /// In en, this message translates to:
  /// **'Move this holiday'**
  String get moveDate;

  /// No description provided for @removeHoliday.
  ///
  /// In en, this message translates to:
  /// **'Ignore this holiday'**
  String get removeHoliday;

  /// No description provided for @overridesTitle.
  ///
  /// In en, this message translates to:
  /// **'Holiday overrides'**
  String get overridesTitle;

  /// No description provided for @overridesHint.
  ///
  /// In en, this message translates to:
  /// **'Move or ignore an official holiday from its calendar detail. Reset restores the published dates.'**
  String get overridesHint;

  /// No description provided for @overrideCount.
  ///
  /// In en, this message translates to:
  /// **'{count} changes applied'**
  String overrideCount(int count);

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore published dates'**
  String get restore;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get sat;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @districtBagerhat.
  ///
  /// In en, this message translates to:
  /// **'Bagerhat'**
  String get districtBagerhat;

  /// No description provided for @districtBandarban.
  ///
  /// In en, this message translates to:
  /// **'Bandarban'**
  String get districtBandarban;

  /// No description provided for @districtBarguna.
  ///
  /// In en, this message translates to:
  /// **'Barguna'**
  String get districtBarguna;

  /// No description provided for @districtBarishal.
  ///
  /// In en, this message translates to:
  /// **'Barishal'**
  String get districtBarishal;

  /// No description provided for @districtBhola.
  ///
  /// In en, this message translates to:
  /// **'Bhola'**
  String get districtBhola;

  /// No description provided for @districtBogura.
  ///
  /// In en, this message translates to:
  /// **'Bogura'**
  String get districtBogura;

  /// No description provided for @districtBrahmanbaria.
  ///
  /// In en, this message translates to:
  /// **'Brahmanbaria'**
  String get districtBrahmanbaria;

  /// No description provided for @districtChandpur.
  ///
  /// In en, this message translates to:
  /// **'Chandpur'**
  String get districtChandpur;

  /// No description provided for @districtChapainawabganj.
  ///
  /// In en, this message translates to:
  /// **'Chapainawabganj'**
  String get districtChapainawabganj;

  /// No description provided for @districtChattogram.
  ///
  /// In en, this message translates to:
  /// **'Chattogram'**
  String get districtChattogram;

  /// No description provided for @districtChuadanga.
  ///
  /// In en, this message translates to:
  /// **'Chuadanga'**
  String get districtChuadanga;

  /// No description provided for @districtCoxsBazar.
  ///
  /// In en, this message translates to:
  /// **'Cox\'s Bazar'**
  String get districtCoxsBazar;

  /// No description provided for @districtCumilla.
  ///
  /// In en, this message translates to:
  /// **'Cumilla'**
  String get districtCumilla;

  /// No description provided for @districtDhaka.
  ///
  /// In en, this message translates to:
  /// **'Dhaka'**
  String get districtDhaka;

  /// No description provided for @districtDinajpur.
  ///
  /// In en, this message translates to:
  /// **'Dinajpur'**
  String get districtDinajpur;

  /// No description provided for @districtFaridpur.
  ///
  /// In en, this message translates to:
  /// **'Faridpur'**
  String get districtFaridpur;

  /// No description provided for @districtFeni.
  ///
  /// In en, this message translates to:
  /// **'Feni'**
  String get districtFeni;

  /// No description provided for @districtGaibandha.
  ///
  /// In en, this message translates to:
  /// **'Gaibandha'**
  String get districtGaibandha;

  /// No description provided for @districtGazipur.
  ///
  /// In en, this message translates to:
  /// **'Gazipur'**
  String get districtGazipur;

  /// No description provided for @districtGopalganj.
  ///
  /// In en, this message translates to:
  /// **'Gopalganj'**
  String get districtGopalganj;

  /// No description provided for @districtHabiganj.
  ///
  /// In en, this message translates to:
  /// **'Habiganj'**
  String get districtHabiganj;

  /// No description provided for @districtJamalpur.
  ///
  /// In en, this message translates to:
  /// **'Jamalpur'**
  String get districtJamalpur;

  /// No description provided for @districtJashore.
  ///
  /// In en, this message translates to:
  /// **'Jashore'**
  String get districtJashore;

  /// No description provided for @districtJhalokathi.
  ///
  /// In en, this message translates to:
  /// **'Jhalokathi'**
  String get districtJhalokathi;

  /// No description provided for @districtJhenaidah.
  ///
  /// In en, this message translates to:
  /// **'Jhenaidah'**
  String get districtJhenaidah;

  /// No description provided for @districtJoypurhat.
  ///
  /// In en, this message translates to:
  /// **'Joypurhat'**
  String get districtJoypurhat;

  /// No description provided for @districtKhagrachhari.
  ///
  /// In en, this message translates to:
  /// **'Khagrachhari'**
  String get districtKhagrachhari;

  /// No description provided for @districtKhulna.
  ///
  /// In en, this message translates to:
  /// **'Khulna'**
  String get districtKhulna;

  /// No description provided for @districtKishoreganj.
  ///
  /// In en, this message translates to:
  /// **'Kishoreganj'**
  String get districtKishoreganj;

  /// No description provided for @districtKurigram.
  ///
  /// In en, this message translates to:
  /// **'Kurigram'**
  String get districtKurigram;

  /// No description provided for @districtKushtia.
  ///
  /// In en, this message translates to:
  /// **'Kushtia'**
  String get districtKushtia;

  /// No description provided for @districtLakshmipur.
  ///
  /// In en, this message translates to:
  /// **'Lakshmipur'**
  String get districtLakshmipur;

  /// No description provided for @districtLalmonirhat.
  ///
  /// In en, this message translates to:
  /// **'Lalmonirhat'**
  String get districtLalmonirhat;

  /// No description provided for @districtMadaripur.
  ///
  /// In en, this message translates to:
  /// **'Madaripur'**
  String get districtMadaripur;

  /// No description provided for @districtMagura.
  ///
  /// In en, this message translates to:
  /// **'Magura'**
  String get districtMagura;

  /// No description provided for @districtManikganj.
  ///
  /// In en, this message translates to:
  /// **'Manikganj'**
  String get districtManikganj;

  /// No description provided for @districtMeherpur.
  ///
  /// In en, this message translates to:
  /// **'Meherpur'**
  String get districtMeherpur;

  /// No description provided for @districtMoulvibazar.
  ///
  /// In en, this message translates to:
  /// **'Moulvibazar'**
  String get districtMoulvibazar;

  /// No description provided for @districtMunshiganj.
  ///
  /// In en, this message translates to:
  /// **'Munshiganj'**
  String get districtMunshiganj;

  /// No description provided for @districtMymensingh.
  ///
  /// In en, this message translates to:
  /// **'Mymensingh'**
  String get districtMymensingh;

  /// No description provided for @districtNaogaon.
  ///
  /// In en, this message translates to:
  /// **'Naogaon'**
  String get districtNaogaon;

  /// No description provided for @districtNarail.
  ///
  /// In en, this message translates to:
  /// **'Narail'**
  String get districtNarail;

  /// No description provided for @districtNarayanganj.
  ///
  /// In en, this message translates to:
  /// **'Narayanganj'**
  String get districtNarayanganj;

  /// No description provided for @districtNarsingdi.
  ///
  /// In en, this message translates to:
  /// **'Narsingdi'**
  String get districtNarsingdi;

  /// No description provided for @districtNatore.
  ///
  /// In en, this message translates to:
  /// **'Natore'**
  String get districtNatore;

  /// No description provided for @districtNetrokona.
  ///
  /// In en, this message translates to:
  /// **'Netrokona'**
  String get districtNetrokona;

  /// No description provided for @districtNilphamari.
  ///
  /// In en, this message translates to:
  /// **'Nilphamari'**
  String get districtNilphamari;

  /// No description provided for @districtNoakhali.
  ///
  /// In en, this message translates to:
  /// **'Noakhali'**
  String get districtNoakhali;

  /// No description provided for @districtPabna.
  ///
  /// In en, this message translates to:
  /// **'Pabna'**
  String get districtPabna;

  /// No description provided for @districtPanchagarh.
  ///
  /// In en, this message translates to:
  /// **'Panchagarh'**
  String get districtPanchagarh;

  /// No description provided for @districtPatuakhali.
  ///
  /// In en, this message translates to:
  /// **'Patuakhali'**
  String get districtPatuakhali;

  /// No description provided for @districtPirojpur.
  ///
  /// In en, this message translates to:
  /// **'Pirojpur'**
  String get districtPirojpur;

  /// No description provided for @districtRajbari.
  ///
  /// In en, this message translates to:
  /// **'Rajbari'**
  String get districtRajbari;

  /// No description provided for @districtRajshahi.
  ///
  /// In en, this message translates to:
  /// **'Rajshahi'**
  String get districtRajshahi;

  /// No description provided for @districtRangamati.
  ///
  /// In en, this message translates to:
  /// **'Rangamati'**
  String get districtRangamati;

  /// No description provided for @districtRangpur.
  ///
  /// In en, this message translates to:
  /// **'Rangpur'**
  String get districtRangpur;

  /// No description provided for @districtSatkhira.
  ///
  /// In en, this message translates to:
  /// **'Satkhira'**
  String get districtSatkhira;

  /// No description provided for @districtShariatpur.
  ///
  /// In en, this message translates to:
  /// **'Shariatpur'**
  String get districtShariatpur;

  /// No description provided for @districtSherpur.
  ///
  /// In en, this message translates to:
  /// **'Sherpur'**
  String get districtSherpur;

  /// No description provided for @districtSirajganj.
  ///
  /// In en, this message translates to:
  /// **'Sirajganj'**
  String get districtSirajganj;

  /// No description provided for @districtSunamganj.
  ///
  /// In en, this message translates to:
  /// **'Sunamganj'**
  String get districtSunamganj;

  /// No description provided for @districtSylhet.
  ///
  /// In en, this message translates to:
  /// **'Sylhet'**
  String get districtSylhet;

  /// No description provided for @districtTangail.
  ///
  /// In en, this message translates to:
  /// **'Tangail'**
  String get districtTangail;

  /// No description provided for @districtThakurgaon.
  ///
  /// In en, this message translates to:
  /// **'Thakurgaon'**
  String get districtThakurgaon;

  /// No description provided for @monCompact.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get monCompact;

  /// No description provided for @tueCompact.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tueCompact;

  /// No description provided for @wedCompact.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wedCompact;

  /// No description provided for @thuCompact.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thuCompact;

  /// No description provided for @friCompact.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get friCompact;

  /// No description provided for @satCompact.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get satCompact;

  /// No description provided for @sunCompact.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sunCompact;

  /// No description provided for @rangeSelection.
  ///
  /// In en, this message translates to:
  /// **'Selected range: {from} – {through}'**
  String rangeSelection(String from, String through);

  /// No description provided for @traversedDays.
  ///
  /// In en, this message translates to:
  /// **'Examined {count} calendar days · start excluded'**
  String traversedDays(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
