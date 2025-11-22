
import 'package:flutter_test/flutter_test.dart';
import 'package:today_weather_2025/utils.dart';

void main() {
  test('formatHour should return correctly', () {
    // Arrange
    int timestamp = 1697049600; // Corresponds to Oct 11, 2023 12:00:00 PM UTC

    String result = formatHour(timestamp);

    // Assert
    expect(result, '1 AM');
  });

  test('formatTemperature should convert Kelvin to Fahrenheit correctly', () {
    // Arrange
    double kelvinTemp = 300.0; // Example temperature in Kelvin

    String result = formatTemperature(kelvinTemp);

    // Assert
    expect(result, '80°F');
  });
}