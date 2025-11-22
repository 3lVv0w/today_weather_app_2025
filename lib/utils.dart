String formatHour(int dateTimeMillis) {
  final dateTime = DateTime.fromMillisecondsSinceEpoch(dateTimeMillis * 1000);
  final hour = dateTime.hour;
  final amPm = hour >= 12 ? 'PM' : 'AM';
  final displayHour = hour % 12 == 0 ? 12 : hour % 12;
  return '$displayHour $amPm';
}

String formatTemperature(double kelvinTemp) {
  final fahrenheitTemp = (kelvinTemp - 273.15) * 9/5 + 32;
  return '${fahrenheitTemp.toStringAsFixed(0)}°F';
}
