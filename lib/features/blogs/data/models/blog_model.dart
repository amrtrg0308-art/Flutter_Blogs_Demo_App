// File: lib/features/blogs/data/models/blog_model.dart
// Purpose: Blog feature implementation.

import 'package:blogs_demo/features/blogs/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.updatedAt,
    required super.imageUrl,
    required super.topics,
    super.posterName,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'updated_at': updatedAt.toIso8601String(),
      'image_url': imageUrl,
      'topics': topics,
    };
  }

  factory BlogModel.fromJson(Map<dynamic, dynamic> map) {
    final safeMap = Map<String, dynamic>.from(map);
    return BlogModel(
      id: safeMap['id'] as String,
      posterId: safeMap['poster_id'] as String,
      title: safeMap['title'] as String,
      content: safeMap['content'] as String,
      updatedAt: safeMap['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(safeMap['updated_at'] as String),
      imageUrl: safeMap['image_url'] as String? ?? '',
      topics: List<String>.from(safeMap['topics'] ?? []),
    );
  }

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    DateTime? updatedAt,
    String? imageUrl,
    List<String>? topics,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      posterName: posterName ?? this.posterName,
    );
  }
}
