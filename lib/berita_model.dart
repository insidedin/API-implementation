class News {
  final String title;
  final String description;
  final String urlToImage;
  final String publishedAt;
  final String sourceName;

  News({
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.sourceName,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] ?? 'https://via.placeholder.com/150',
      publishedAt: json['publishedAt'] ?? 'No Date',
      sourceName: json['source']['name'] ?? 'No Source',
    );
  }
}