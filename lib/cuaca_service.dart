import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasi3_api/cuaca_model.dart';

class WeatherService {
  static const String _apiKey =
      'b9c71cc8ed95037b724bb7bb87101f20'; // Ganti dengan API key Anda.
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Weather> fetchWeather(String cityName) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric&lang=id', // `lang=id` untuk deskripsi cuaca dalam Bahasa Indonesia.
      ),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal memuat data cuaca');
    }
  }
}
