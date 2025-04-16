
class Berita {
  final String judul;
  final String deskripsi;
  final String urlgambar;
  final String publish;
  final String sumber;


Berita ({
  required this.judul,
  required this.deskripsi,
  required this.urlgambar,
  required this.publish,
  required this.sumber
});


// metode untuk mengubahh dari Json ke objek Berita
factory Berita.fromJson(Map<String, dynamic> json){
  return Berita(
    judul: json['title'],
    deskripsi: json['description'],
    urlgambar: json['urlimage'],
    publish: json['publish'],
    sumber: json['source'],
  );
}
}