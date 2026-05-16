// File: lib/features/blogs/domain/entities/blog.dart
// Purpose: Blog feature implementation.

class Blog {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final DateTime updatedAt;
  final String imageUrl;
  final List<String> topics;
  final String? posterName;

  Blog({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.updatedAt,
    required this.imageUrl,
    required this.topics,
    this.posterName,
  });
}
