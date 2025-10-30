class WordPress {
  final String titulo;
  final String summary;
  final String url;
  final String imageUrl;

  WordPress({
    required this.titulo,
    required this.summary,
    required this.url,
    required this.imageUrl,
  });

  factory WordPress.fromJson(Map<String, dynamic> json) {
    return WordPress(
      titulo: json['titulo']['rendered'],
      summary: json['excerpt']['rendered']
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .substring(0, 100),
      url: json['link'],
      imageUrl: json['jetpack_featured_media_url'] ?? '',
    );
  }
}