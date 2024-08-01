// gist_model.dart

class Gist {
  final String id;
  final String filename;
  final String? description;
  final String content;
  final String createdAt;
  final String url; // Add the URL field

  Gist({
    required this.id,
    required this.filename,
    this.description,
    required this.content,
    required this.createdAt,
    required this.url, // Initialize the URL field
  });

  factory Gist.fromJson(Map<String, dynamic> json) {
    return Gist(
      id: json['id'],
      filename: json['files'].values.first['filename'] ?? 'No filename',
      description: json['description'] ?? 'No description',
      content: json['files'].values.first['content'] ?? 'No content',
      createdAt: json['created_at'] ?? 'Unknown date',
      url: json['html_url'], // Parse the URL field
    );
  }
}
