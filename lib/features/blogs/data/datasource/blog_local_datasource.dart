// File: lib/features/blogs/data/datasource/blog_local_datasource.dart
// Purpose: Blog feature implementation.

import 'package:blogs_demo/features/blogs/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDatasource {
  void uploadLocalBlogs({required List<BlogModel> blogs});

  List<BlogModel> loadBlogs();
}

class BlogLocalDatasourceImpl implements BlogLocalDatasource {
  final Box box;

  BlogLocalDatasourceImpl({required this.box});
  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    for (int i = 0; i < box.length; i++) {
      final raw = box.get(i.toString());
      if (raw is Map) {
        blogs.add(BlogModel.fromJson(raw));
      }
    }
    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();
    for (int i = 0; i < blogs.length; i++) {
      box.put(i.toString(), blogs[i].toJson());
    }
  }
}
