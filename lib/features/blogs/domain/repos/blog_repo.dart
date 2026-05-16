// File: lib/features/blogs/domain/repos/blog_repo.dart
// Purpose: Blog feature implementation.

import 'dart:io';

import 'package:blogs_demo/core/errors/failure.dart';
import 'package:blogs_demo/features/blogs/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepo {
  Future<Either<Failure, Blog>> uploadBlog({
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
    required File image,
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();
}
