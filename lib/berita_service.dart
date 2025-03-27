import 'dart:convert';
import 'package:aplikasi3_api/berita_model.dart';
import 'package:http/http.dart' as http;


class NewsService {
  static const String _apiKey = '3108f07a29ea425bab7256f22a040365';
  static const String _baseUrl = 'https://newsapi.org/v2';

  Future<List<News>> fetchNews() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/top-headlines?country=id&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> articles = data['articles'];
      return articles.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat berita');
    }
  }
}