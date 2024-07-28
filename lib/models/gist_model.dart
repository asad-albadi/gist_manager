class Gist {
  final String id;
  final String filename;
  final String? description; // Nullable
  final String content;
  final String createdAt;

  Gist({
    required this.id,
    required this.filename,
    this.description, // Nullable
    required this.content,
    required this.createdAt,
  });

  factory Gist.fromJson(Map<String, dynamic> json) {
    return Gist(
      id: json['id'],
      filename: json['files'].values.first['filename'] ?? 'No filename',
      description: json['description'] ?? 'No description',
      content: json['files'].values.first['content'] ?? 'No content',
      createdAt: json['created_at'] ?? 'Unknown date',
    );
  }
}
