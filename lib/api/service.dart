import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasi3_api/api/cuaca_model.dart';

class CuacaService {
  //memanggil API dari openweathermap.org
  static String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static String apiKey = 'b9c71cc8ed95037b724bb7bb87101f20';

  // metode untuk mendapatkan data cuaca berdasarkan nama kota
  Future<Cuaca> fetchCuaca(String kota) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/weather?q=$kota&appid=$apiKey&units=metric')); //tambahan

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Cuaca.fromJson(data);
    } else {
      throw Exception('Gagal memuat data cuaca');
    }
  }
}

class BeritaService {
  //memanggil API dari newsapi.org
  static String baseUrl = 'https://newsapi.org/v2';
  static String apiKey = '3108f07a29ea425bab7256f22a040365';

  // metode untuk mendapatkan data berita berdasarkan kategori
}

class GeminiService {
  //memanggil API dari gemini.com
  static String apiKey = 'AIzaSyAroqZyeknAI6h-NmkeMZltXN_CsmEC_cM';
}
