import 'package:bangladesh_holidays/bangladesh_holidays.dart';

// Run from the package root: dart run tool/verify_package.dart
void main() {
  var checks = 0;
  void check(String name, bool pass) {
    if (!pass) throw StateError(name);
    checks++;
    print('OK $name');
  }

  void throws<T>(String name, void Function() action) {
    try {
      action();
    } catch (e) {
      check(name, e is T);
      return;
    }
    throw StateError('Expected $T: $name');
  }

  final c = BangladeshHolidays(district: District.dhaka);
  check('catalog sizes',
      c.holidaysIn(2026).length == 65 && c.holidaysIn(2027).length == 61);
  check('overlap 2026', c.holidaysOn(DateTime(2026, 5, 1)).length == 2);
  check('overlap 2027', c.holidaysOn(DateTime(2027, 5, 20)).length == 2);
  check('4 working days',
      c.businessDaysBetween(DateTime(2027, 4, 12), DateTime(2027, 4, 19)) == 4);
  check('same-day empty',
      c.businessDaysBetween(DateTime(2027, 4, 12), DateTime(2027, 4, 12)) == 0);
  check('add positive',
      c.addBusinessDays(DateTime(2027, 4, 12), 3) == DateTime.utc(2027, 4, 18));
  check('add negative',
      c.addBusinessDays(DateTime(2027, 4, 12), -2) == DateTime.utc(2027, 4, 8));
  check(
      'zero holiday',
      c.addBusinessDays(DateTime(2027, 4, 14, 23), 0) ==
          DateTime.utc(2027, 4, 14));
  check(
      'civil normalization',
      c.holidaysOn(DateTime(2027, 4, 14, 22)).single.date ==
          DateTime.utc(2027, 4, 14));
  check(
      'hill closure only',
      !c.isHoliday(DateTime(2027, 4, 13)) &&
          BangladeshHolidays(district: District.rangamati)
              .isHoliday(DateTime(2027, 4, 13)));
  check('optional unselected', !c.isHoliday(DateTime(2027, 2, 11)));
  final selected = BangladeshHolidays(
      selectedOptionalHolidayIds: {'2027-optional-saraswati'});
  check('optional selected', selected.isHoliday(DateTime(2027, 2, 11)));
  final buddhist = BangladeshHolidays(
      district: District.dhaka,
      selectedOptionalHolidayIds: {'2027-optional-chaitra'});
  check(
      'optional district exclusion', buddhist.isHoliday(DateTime(2027, 4, 13)));
  throws<ArgumentError>(
      'invalid regional selection',
      () => BangladeshHolidays(
          district: District.rangamati,
          selectedOptionalHolidayIds: {'2027-optional-chaitra'}));
  check(
      'working orders',
      c.isBusinessDay(DateTime(2026, 5, 23)) &&
          c.isBusinessDay(DateTime(2026, 10, 17)));
  check(
      'opt out opening',
      !BangladeshHolidays(applyGovernmentWorkingDays: false)
          .isBusinessDay(DateTime(2026, 10, 17)));
  check(
      'May24 opening custom weekend',
      BangladeshHolidays(weekendDays: {7})
          .isBusinessDay(DateTime(2026, 5, 24)));
  final extra = Holiday.company(
      id: 'company',
      date: DateTime(2026, 10, 17),
      nameEn: 'Closed',
      nameBn: 'বন্ধ');
  check(
      'holiday beats opening',
      !BangladeshHolidays(extraHolidays: [extra])
          .isBusinessDay(DateTime(2026, 10, 17)));
  check(
      'extra closure record',
      BangladeshHolidays(extraHolidays: [extra])
              .holidaysOn(extra.date, applicableOnly: true)
              .single
              .id ==
          'company');
  final moved = BangladeshHolidays(overrides: [
    HolidayOverride.move(
        holidayId: '2027-executiveOrder-new-year', date: DateTime(2027, 4, 15))
  ]);
  check(
      'move keeps original',
      moved
              .holidaysOn(DateTime(2027, 4, 15))
              .firstWhere((h) => h.id == '2027-executiveOrder-new-year')
              .originalDate ==
          DateTime.utc(2027, 4, 14));
  check(
      'move clears original closure', !moved.isHoliday(DateTime(2027, 4, 14)));
  check(
      'remove occurrence',
      !BangladeshHolidays(overrides: [
        HolidayOverride.remove('2027-executiveOrder-new-year')
      ]).isHoliday(DateTime(2027, 4, 14)));
  check(
      'national amendments',
      [
        DateTime(2026, 2, 11),
        DateTime(2026, 2, 12),
        DateTime(2026, 3, 18),
        DateTime(2026, 5, 25),
        DateTime(2026, 10, 22),
        DateTime(2026, 11, 7)
      ].every(c.isHoliday));
  check('range coverage edge',
      c.daysBetween(DateTime(2027, 12, 31), DateTime(2028)).length == 1);
  check('next preserves overlap',
      c.nextHolidays(from: DateTime(2026, 4, 30)).length == 2);
  check(
      'inclusive next',
      c
              .nextHolidays(from: DateTime(2027, 4, 14), inclusive: true)
              .single
              .date ==
          DateTime.utc(2027, 4, 14));
  check(
      'default excludes optional',
      c.nextHolidays(from: DateTime(2027, 1, 1)).first.type !=
          HolidayType.optional);
  throws<CoverageException>('missing year', () => c.holidaysIn(2028));
  throws<CoverageException>(
      'forward boundary', () => c.addBusinessDays(DateTime(2027, 12, 31), 1));
  throws<CoverageException>(
      'backward boundary', () => c.addBusinessDays(DateTime(2026), -1));
  throws<CoverageException>(
      'next boundary', () => c.nextHolidays(from: DateTime(2027, 12, 31)));
  throws<CoverageException>('missing year in range',
      () => c.daysBetween(DateTime(2027), DateTime(2029)));
  throws<ArgumentError>('reversed range',
      () => c.daysBetween(DateTime(2027, 4, 19), DateTime(2027, 4, 12)));
  throws<ArgumentError>(
      'invalid weekday', () => BangladeshHolidays(weekendDays: {0}));
  throws<ArgumentError>('all days off',
      () => BangladeshHolidays(weekendDays: {1, 2, 3, 4, 5, 6, 7}));
  throws<ArgumentError>('unknown override',
      () => BangladeshHolidays(overrides: [HolidayOverride.remove('unknown')]));
  throws<ArgumentError>(
      'duplicate override',
      () => BangladeshHolidays(overrides: [
            HolidayOverride.remove('2027-general-victory'),
            HolidayOverride.remove('2027-general-victory')
          ]));
  throws<ArgumentError>('unknown optional',
      () => BangladeshHolidays(selectedOptionalHolidayIds: {'unknown'}));
  throws<UnsupportedError>(
      'immutable result', () => c.holidaysIn(2027).clear());
  final weekends = <int>{5, 6};
  final copied = BangladeshHolidays(weekendDays: weekends);
  weekends.clear();
  check('copied input', copied.weekendDays.length == 2);
  check('no weekend allowed',
      BangladeshHolidays(weekendDays: {}).isBusinessDay(DateTime(2027, 4, 16)));
  throws<CoverageException>(
      'minimum integer count',
      () => c.addBusinessDays(
          DateTime(2027, 4, 12), int.parse('-9223372036854775808')));
  throws<CoverageException>(
      'maximum integer count',
      () => c.addBusinessDays(
          DateTime(2027, 4, 12), int.parse('9223372036854775807')));
  throws<ArgumentError>('invalid month', () => c.holidaysInMonth(2027, 13));
  check(
      'weekend is not a holiday',
      !c.isHoliday(DateTime(2027, 4, 16)) &&
          !c.isBusinessDay(DateTime(2027, 4, 16)));
  final overlap = c.dayStatus(DateTime(2027, 5, 20));
  check('overlap counted once',
      overlap.holidays.length == 2 && overlap.reasons.length == 1);
  check(
      'explicit closure reasons',
      buddhist
          .dayStatus(DateTime(2027, 4, 13))
          .reasons
          .contains(NonWorkingReason.optionalHoliday));
  throws<UnsupportedError>('immutable policy', () => c.weekendDays.clear());
  throws<UnsupportedError>(
      'immutable coverage', () => c.coverageFor(2027).sources.clear());
  print('Passed $checks package scenarios.');
}
