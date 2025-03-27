import 'package:aplikasi3_api/cuaca_model.dart';
import 'package:aplikasi3_api/cuaca_service.dart';
import 'package:flutter/material.dart';



class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  late Future<Weather> _futureWeather;
  String _cityName = 'Jakarta'; // Kota default.

  @override
  void initState() {
    super.initState();
    _futureWeather = _weatherService.fetchWeather(_cityName);
  }

  void _refreshWeather() {
    setState(() {
      _futureWeather = _weatherService.fetchWeather(_cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info Cuaca'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final newCity = await showDialog<String>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Cari Kota'),
                  content: TextField(
                    decoration: InputDecoration(hintText: 'Masukkan nama kota'),
                    onSubmitted: (value) {
                      Navigator.pop(context, value);
                    },
                  ),
                ),
              );
              if (newCity != null && newCity.isNotEmpty) {
                setState(() {
                  _cityName = newCity;
                  _refreshWeather();
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshWeather,
          ),
        ],
      ),
      body: FutureBuilder<Weather>(
        future: _futureWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Gagal memuat data cuaca'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _refreshWeather,
                    child: Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final weather = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Lokasi dan Tanggal
                  Text(
                    weather.cityName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(weather.formattedDate),
                  SizedBox(height: 20),

                  // Icon dan Suhu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        weather.formattedTemperature,
                        style: TextStyle(fontSize: 48),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Deskripsi Cuaca
                  Text(
                    weather.description.toUpperCase(),
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  SizedBox(height: 30),

                  // Info Tambahan (Kelembaban & Angin)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildWeatherInfo(
                        icon: Icons.water_drop,
                        value: '${weather.humidity}%',
                        label: 'Kelembaban',
                      ),
                      _buildWeatherInfo(
                        icon: Icons.air,
                        value: '${weather.windSpeed} km/jam',
                        label: 'Angin',
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Tidak ada data'));
          }
        },
      ),
    );
  }

  Widget _buildWeatherInfo({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.blue),
        SizedBox(height: 8),
        Text(value, style: TextStyle(fontSize: 18)),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}