import 'package:aplikasi3_api/api/cuaca_model.dart';
import 'package:aplikasi3_api/api/service.dart';
import 'package:flutter/material.dart';

/// Halaman utama untuk menampilkan informasi cuaca berdasarkan nama kota.
class CuacaPage extends StatefulWidget {
  const CuacaPage({super.key});

  @override
  State<CuacaPage> createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage> {
  final CuacaService cuacaService = CuacaService(); // Instance service API
  late Future<Cuaca> futureCuaca; // Menyimpan data cuaca yang diambil
  String nama = 'Jakarta'; // Nama kota default

  /// Inisialisasi pertama saat widget dibangun
  @override
  void initState() {
    super.initState();
    futureCuaca = cuacaService.fetchCuaca(nama); // Ambil data cuaca awal
  }

  /// Fungsi untuk menyegarkan data cuaca berdasarkan kota saat ini
  void refreshCuaca() {
    setState(() {
      futureCuaca = cuacaService.fetchCuaca(nama);
    });
  }

  /// Membangun tampilan antarmuka pengguna
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info Cuaca'),
        actions: [
          // Tombol pencarian kota
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final kota = await showDialog<String>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Cari Kota'),
                  content: TextField(
                    decoration: InputDecoration(hintText: 'Masukkan nama kota'),
                    onSubmitted: (value) {
                      Navigator.pop(context, value); // Kembalikan nama kota
                    },
                  ),
                ),
              );

              // Jika input valid, perbarui nama kota dan data
              if (kota != null && kota.isNotEmpty) {
                setState(() {
                  nama = kota;
                  refreshCuaca();
                });
              }
            },
          ),

          // Tombol untuk menyegarkan data cuaca
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshCuaca,
          ),
        ],
      ),

      // FutureBuilder untuk menangani data dari API
      body: FutureBuilder<Cuaca>(
        future: futureCuaca,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Saat data sedang dimuat
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Jika terjadi error saat memuat data
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Gagal memuat data cuaca'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: refreshCuaca,
                    child: Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            // Jika data berhasil dimuat
            final cuaca = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Nama Kota dan Waktu
                  Text(
                    cuaca.kota,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(cuaca.waktuFormat),
                  SizedBox(height: 20),

                  // Icon cuaca dan suhu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://openweathermap.org/img/wn/${cuaca.kodeIkon}@2x.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${cuaca.suhuFormat}°C',
                        style: TextStyle(fontSize: 48),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),

                  // Deskripsi cuaca
                  Text(
                    cuaca.deskripsi.toUpperCase(),
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),

                  SizedBox(height: 30),

                  // Kelembapan dan kecepatan angin
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      cuacaInfo(
                        icon: Icons.water_drop,
                        value: '${cuaca.kelembapan}%',
                        label: 'Kelembaban',
                      ),
                      cuacaInfo(
                        icon: Icons.air,
                        value: '${cuaca.kecepatanAngin} km/jam',
                        label: 'Angin',
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            // Jika tidak ada data sama sekali
            return Center(child: Text('Tidak ada data'));
          }
        },
      ),
    );
  }
}

/// Widget kecil untuk menampilkan informasi cuaca tambahan seperti kelembapan atau angin
Widget cuacaInfo({
  required IconData icon,
  required String value,
  required String label,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, size: 40),
      SizedBox(height: 10),
      Text(value, style: TextStyle(fontSize: 18)),
      SizedBox(height: 5),
      Text(label, style: TextStyle(fontSize: 16)),
    ],
  );
}
