DateTime calendarDate(DateTime value) =>
    DateTime.utc(value.year, value.month, value.day);

String dateKey(DateTime value) => '${value.year.toString().padLeft(4, '0')}-'
    '${value.month.toString().padLeft(2, '0')}-'
    '${value.day.toString().padLeft(2, '0')}';

DateTime parseDate(String value) {
  if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
    throw FormatException('Expected YYYY-MM-DD', value);
  }
  final parts = value.split('-').map(int.parse).toList();
  final date = DateTime.utc(parts[0], parts[1], parts[2]);
  if (parts[0] < 1 || dateKey(date) != value) {
    throw FormatException('Invalid calendar date', value);
  }
  return date;
}
