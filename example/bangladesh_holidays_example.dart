import 'package:bangladesh_holidays/bangladesh_holidays.dart';

void main() {
  final calendar = BangladeshHolidays(district: District.dhaka);
  final from = DateTime(2027, 4, 12);
  final end = DateTime(2027, 4, 19);
  print(
      '12–18 April 2027: ${calendar.businessDaysBetween(from, end)} working days');
  print('3 working days after 12 April: ${calendar.addBusinessDays(from, 3)}');
  for (final day in calendar.daysBetween(from, end)) {
    print('${day.date.toIso8601String().substring(0, 10)}: '
        '${day.isBusinessDay ? 'working' : day.reasons.join(', ')}');
  }
  print('20 May overlaps: ${calendar.holidaysOn(DateTime(2027, 5, 20))}');
  print('Official working Saturday: '
      '${calendar.isBusinessDay(DateTime(2026, 10, 17))}');
}
