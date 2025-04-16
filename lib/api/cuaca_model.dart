class Cuaca {
  final String kota;
  final double suhu;
  final DateTime waktu;
  final int kelembapan;
  final double kecepatanAngin;
  final String kodeIkon;
  final String deskripsi;


Cuaca ({
  required this.kota,
  required this.suhu,
  required this.waktu,
  required this.kelembapan,
  required this.kecepatanAngin,
  required this.kodeIkon,
  required this.deskripsi,
});


// metode untuk mengubahh dari Json ke objek Cuaca
factory Cuaca.fromJson(Map<String, dynamic> json){
  return Cuaca(
    kota: json['name'],
    suhu: json['main']['temp'].toDouble(),
    waktu: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    kelembapan: json['main']['humidity'],
    kecepatanAngin: json['wind']['speed'].toDouble(), //perbaikan wind
    kodeIkon: json['weather'][0]['icon'],
    deskripsi: json['weather'][0]['description'],
  );
}

// konversi suhu menjadi angka bulat (misalnya 25.0 menjadi 25)
String get suhuFormat => '${suhu.round()}';

// mengubah format tanggal menjadi bentuk lokal (misalnya 2023-10-01 menjadi 1 Oktober 2023)
String get waktuFormat {
  return '${waktu.day} ${waktu.month} ${waktu.year}';
}
}