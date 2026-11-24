// ignore_for_file: deprecated_member_use

// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'বাংলাদেশের ছুটি';

  @override
  String get calendar => 'ক্যালেন্ডার';

  @override
  String get calculateTab => 'হিসাব';

  @override
  String get rules => 'নিয়ম';

  @override
  String get language => 'English';

  @override
  String get switchLanguage => 'ইংরেজিতে দেখুন';

  @override
  String get sample => 'উদাহরণ: ১২–১৮ এপ্রিল ২০২৭';

  @override
  String get district => 'জেলা';

  @override
  String get nationwide => 'শুধু দেশব্যাপী';

  @override
  String get weekends => 'সাপ্তাহিক ছুটি';

  @override
  String get editRules => 'অফিসের নিয়ম বদলান';

  @override
  String get previousMonth => 'আগের মাস';

  @override
  String get nextMonth => 'পরের মাস';

  @override
  String get selectMonth => 'তারিখ বেছে নিন';

  @override
  String get workingDay => 'কর্মদিবস';

  @override
  String get holiday => 'ছুটি';

  @override
  String get weekend => 'সাপ্তাহিক ছুটি';

  @override
  String get selectedRange => 'নির্বাচিত সময়সীমা';

  @override
  String get counted => 'গণনা করা হয়েছে';

  @override
  String get excluded => 'বাদ দেওয়া হয়েছে';

  @override
  String get general => 'সাধারণ ছুটি';

  @override
  String get executiveOrder => 'নির্বাহী আদেশে ছুটি';

  @override
  String get optional => 'ঐচ্ছিক ছুটি';

  @override
  String get company => 'প্রতিষ্ঠানের ছুটি';

  @override
  String get unselectedOptional => 'ঐচ্ছিক · নির্বাচন করা হয়নি';

  @override
  String get estimated => 'চাঁদের ওপর নির্ভরশীল তারিখ';

  @override
  String get viewSource => 'প্রজ্ঞাপন দেখুন';

  @override
  String get sourceUnavailable => 'প্রজ্ঞাপনের লিংক খোলা যায়নি।';

  @override
  String get noHoliday => 'এই অফিসের জন্য কোনো ছুটি নেই।';

  @override
  String get officeOpen => 'সরকারি আদেশে অফিস খোলা';

  @override
  String get calculateAction => 'কর্মদিবসের হিসাব করুন';

  @override
  String get countTitle => 'কর্মদিবস গুনুন';

  @override
  String get countDays => 'দিন গুনুন';

  @override
  String get addDays => 'দিন যোগ করুন';

  @override
  String get from => 'শুরু';

  @override
  String get through => 'শেষ (অন্তর্ভুক্ত)';

  @override
  String get amount => 'কত কর্মদিবস যোগ হবে';

  @override
  String get amountHint => 'পেছনে যেতে ঋণাত্মক সংখ্যা দিন';

  @override
  String get calculate => 'হিসাব করুন';

  @override
  String get resultDate => 'ফলাফলের তারিখ';

  @override
  String get inclusiveHint => 'নির্বাচিত শুরু ও শেষ—দুই দিনই অন্তর্ভুক্ত।';

  @override
  String get addHint => 'শুরুর দিন বাদ যাবে; শূন্য দিলে একই তারিখ থাকবে।';

  @override
  String daysResult(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString কর্মদিবস';
  }

  @override
  String rangeResult(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString দিন · শুরু ও শেষ অন্তর্ভুক্ত';
  }

  @override
  String get invalidRange => 'শেষ তারিখ শুরুর তারিখের আগে হতে পারবে না।';

  @override
  String get invalidAmount => '−৭৩০ থেকে ৭৩০-এর মধ্যে পূর্ণসংখ্যা দিন।';

  @override
  String get coverageError =>
      'এই হিসাব সমর্থিত বছরের বাইরে যাচ্ছে। ২০২৬ ও ২০২৭ সালের তথ্য আছে।';

  @override
  String get pendingResult => 'তারিখ বেছে নিয়ে হিসাব করুন।';

  @override
  String get breakdown => 'দিন অনুযায়ী কারণ';

  @override
  String get uncertainResult =>
      'চাঁদের ওপর নির্ভরশীল ছুটি আছে; তারিখ বদলাতে পারে।';

  @override
  String get rulesIntro =>
      'আপনার অফিসের নিয়ম দিন। পরিবর্তন দুই tab-এই প্রযোজ্য হবে।';

  @override
  String get weekendError => 'অন্তত একটি বার কর্মদিবস রাখুন।';

  @override
  String get followGeneral => 'সাধারণ ছুটি অন্তর্ভুক্ত করুন';

  @override
  String get followExecutive => 'নির্বাহী আদেশের ছুটি অন্তর্ভুক্ত করুন';

  @override
  String get followWorking => 'সরকারি অফিস খোলার নির্দেশ অনুসরণ করুন';

  @override
  String get followWorkingHint =>
      'খোলার নির্দেশ সাপ্তাহিক ছুটির ওপর প্রাধান্য পাবে; অন্য কার্যকর ছুটির ওপর নয়।';

  @override
  String get optionalTitle => 'অনুমোদিত ঐচ্ছিক ছুটি';

  @override
  String get optionalHint =>
      'অফিসের অনুমোদিত তারিখগুলোই বাছুন। সম্প্রদায় বাছলে তার সব ছুটি কার্যকর হবে না।';

  @override
  String get year => 'বছর';

  @override
  String get communityFilter => 'সম্প্রদায়';

  @override
  String get allCommunities => 'সব সম্প্রদায়';

  @override
  String get muslim => 'মুসলিম';

  @override
  String get hindu => 'হিন্দু';

  @override
  String get christian => 'খ্রিষ্টান';

  @override
  String get buddhist => 'বৌদ্ধ';

  @override
  String get indigenous => 'ক্ষুদ্র নৃগোষ্ঠী';

  @override
  String get companyTitle => 'প্রতিষ্ঠানের নিজস্ব ছুটি';

  @override
  String get addCompany => 'নিজস্ব ছুটি যোগ করুন';

  @override
  String get closureName => 'ছুটির নাম';

  @override
  String get save => 'সংরক্ষণ';

  @override
  String get cancel => 'বাতিল';

  @override
  String get remove => 'মুছুন';

  @override
  String get emptyName => 'এই ছুটির নাম দিন।';

  @override
  String get noCompany => 'প্রতিষ্ঠানের নিজস্ব ছুটি যোগ করা হয়নি।';

  @override
  String get appearance => 'থিম';

  @override
  String get systemTheme => 'সিস্টেম';

  @override
  String get lightTheme => 'হালকা';

  @override
  String get darkTheme => 'গাঢ়';

  @override
  String get coverageTitle => 'সংযুক্ত তথ্য: ২০২৬–২০২৭';

  @override
  String get coverageHint =>
      '১৯ নভেম্বর ২০২৬-এ যাচাই করা অফলাইন তথ্য। ব্যাংক, স্কুল, আদালত, শিল্পপ্রতিষ্ঠান ও শুধু নির্দিষ্ট নির্বাচনি এলাকার আলাদা ক্যালেন্ডার এই demo-তে নেই।';

  @override
  String get sessionHint =>
      'নিয়ম এই session-এর জন্য থাকবে। আবার চালু করলে demo আগের অবস্থায় ফিরবে।';

  @override
  String get resetRules => 'অফিসের নিয়ম reset করুন';

  @override
  String get customDate => 'অফিসের নিয়মে তারিখ বদলানো হয়েছে';

  @override
  String get moveDate => 'এই ছুটির তারিখ বদলান';

  @override
  String get removeHoliday => 'এই ছুটি বাদ দিন';

  @override
  String get overridesTitle => 'ছুটির পরিবর্তন';

  @override
  String get overridesHint =>
      'ক্যালেন্ডারের বিস্তারিত থেকে সরকারি ছুটি সরান বা বাদ দিন। Reset করলে প্রকাশিত তারিখ ফিরে আসবে।';

  @override
  String overrideCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countStringটি পরিবর্তন কার্যকর';
  }

  @override
  String get restore => 'প্রকাশিত তারিখ ফিরিয়ে আনুন';

  @override
  String get mon => 'সোম';

  @override
  String get tue => 'মঙ্গল';

  @override
  String get wed => 'বুধ';

  @override
  String get thu => 'বৃহঃ';

  @override
  String get fri => 'শুক্র';

  @override
  String get sat => 'শনি';

  @override
  String get sun => 'রবি';

  @override
  String get none => 'কোনোটিই নয়';

  @override
  String get districtBagerhat => 'বাগেরহাট';

  @override
  String get districtBandarban => 'বান্দরবান';

  @override
  String get districtBarguna => 'বরগুনা';

  @override
  String get districtBarishal => 'বরিশাল';

  @override
  String get districtBhola => 'ভোলা';

  @override
  String get districtBogura => 'বগুড়া';

  @override
  String get districtBrahmanbaria => 'ব্রাহ্মণবাড়িয়া';

  @override
  String get districtChandpur => 'চাঁদপুর';

  @override
  String get districtChapainawabganj => 'চাঁপাইনবাবগঞ্জ';

  @override
  String get districtChattogram => 'চট্টগ্রাম';

  @override
  String get districtChuadanga => 'চুয়াডাঙ্গা';

  @override
  String get districtCoxsBazar => 'কক্সবাজার';

  @override
  String get districtCumilla => 'কুমিল্লা';

  @override
  String get districtDhaka => 'ঢাকা';

  @override
  String get districtDinajpur => 'দিনাজপুর';

  @override
  String get districtFaridpur => 'ফরিদপুর';

  @override
  String get districtFeni => 'ফেনী';

  @override
  String get districtGaibandha => 'গাইবান্ধা';

  @override
  String get districtGazipur => 'গাজীপুর';

  @override
  String get districtGopalganj => 'গোপালগঞ্জ';

  @override
  String get districtHabiganj => 'হবিগঞ্জ';

  @override
  String get districtJamalpur => 'জামালপুর';

  @override
  String get districtJashore => 'যশোর';

  @override
  String get districtJhalokathi => 'ঝালকাঠি';

  @override
  String get districtJhenaidah => 'ঝিনাইদহ';

  @override
  String get districtJoypurhat => 'জয়পুরহাট';

  @override
  String get districtKhagrachhari => 'খাগড়াছড়ি';

  @override
  String get districtKhulna => 'খুলনা';

  @override
  String get districtKishoreganj => 'কিশোরগঞ্জ';

  @override
  String get districtKurigram => 'কুড়িগ্রাম';

  @override
  String get districtKushtia => 'কুষ্টিয়া';

  @override
  String get districtLakshmipur => 'লক্ষ্মীপুর';

  @override
  String get districtLalmonirhat => 'লালমনিরহাট';

  @override
  String get districtMadaripur => 'মাদারীপুর';

  @override
  String get districtMagura => 'মাগুরা';

  @override
  String get districtManikganj => 'মানিকগঞ্জ';

  @override
  String get districtMeherpur => 'মেহেরপুর';

  @override
  String get districtMoulvibazar => 'মৌলভীবাজার';

  @override
  String get districtMunshiganj => 'মুন্সিগঞ্জ';

  @override
  String get districtMymensingh => 'ময়মনসিংহ';

  @override
  String get districtNaogaon => 'নওগাঁ';

  @override
  String get districtNarail => 'নড়াইল';

  @override
  String get districtNarayanganj => 'নারায়ণগঞ্জ';

  @override
  String get districtNarsingdi => 'নরসিংদী';

  @override
  String get districtNatore => 'নাটোর';

  @override
  String get districtNetrokona => 'নেত্রকোনা';

  @override
  String get districtNilphamari => 'নীলফামারী';

  @override
  String get districtNoakhali => 'নোয়াখালী';

  @override
  String get districtPabna => 'পাবনা';

  @override
  String get districtPanchagarh => 'পঞ্চগড়';

  @override
  String get districtPatuakhali => 'পটুয়াখালী';

  @override
  String get districtPirojpur => 'পিরোজপুর';

  @override
  String get districtRajbari => 'রাজবাড়ী';

  @override
  String get districtRajshahi => 'রাজশাহী';

  @override
  String get districtRangamati => 'রাঙামাটি';

  @override
  String get districtRangpur => 'রংপুর';

  @override
  String get districtSatkhira => 'সাতক্ষীরা';

  @override
  String get districtShariatpur => 'শরীয়তপুর';

  @override
  String get districtSherpur => 'শেরপুর';

  @override
  String get districtSirajganj => 'সিরাজগঞ্জ';

  @override
  String get districtSunamganj => 'সুনামগঞ্জ';

  @override
  String get districtSylhet => 'সিলেট';

  @override
  String get districtTangail => 'টাঙ্গাইল';

  @override
  String get districtThakurgaon => 'ঠাকুরগাঁও';

  @override
  String get monCompact => 'সো';

  @override
  String get tueCompact => 'ম';

  @override
  String get wedCompact => 'বু';

  @override
  String get thuCompact => 'বৃ';

  @override
  String get friCompact => 'শু';

  @override
  String get satCompact => 'শ';

  @override
  String get sunCompact => 'র';

  @override
  String rangeSelection(String from, String through) {
    return 'নির্বাচিত সময়সীমা: $from – $through';
  }

  @override
  String traversedDays(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString দিন দেখা হয়েছে · শুরুর দিন বাদ';
  }
}
