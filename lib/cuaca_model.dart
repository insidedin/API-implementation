import 'package:intl/intl.dart';

class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String iconCode;
  final int humidity;
  final double windSpeed;
  final DateTime date;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
    required this.date,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }

  // Format suhu tanpa desimal (opsional)
  String get formattedTemperature => '${temperature.round()}°C';

  // Format tanggal (contoh: "Senin, 27 Mar 2023")
  String get formattedDate {
    return DateFormat('EEEE, d MMM y').format(date);
  }
}