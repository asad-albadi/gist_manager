class Gist {
  final String id;
  final String filename;
  final String? description;
  final String content;
  final String createdAt;
  final String url;
  final bool isPublic;
  final bool isStarred;

  Gist({
    required this.id,
    required this.filename,
    this.description,
    required this.content,
    required this.createdAt,
    required this.url,
    required this.isPublic,
    required this.isStarred,
  });

  factory Gist.fromJson(Map<String, dynamic> json, bool isStarred) {
    return Gist(
      id: json['id'],
      filename: json['files'].values.first['filename'] ?? 'No filename',
      description: json['description'] ?? 'No description',
      content: json['files'].values.first['content'] ?? 'No content',
      createdAt: json['created_at'] ?? 'Unknown date',
      url: json['html_url'],
      isPublic: json['public'],
      isStarred: isStarred,
    );
  }

  Gist copyWith({
    String? id,
    String? filename,
    String? description,
    String? content,
    String? createdAt,
    String? url,
    bool? isPublic,
    bool? isStarred,
  }) {
    return Gist(
      id: id ?? this.id,
      filename: filename ?? this.filename,
      description: description ?? this.description,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      url: url ?? this.url,
      isPublic: isPublic ?? this.isPublic,
      isStarred: isStarred ?? this.isStarred,
    );
  }
}
