// File: lib/features/blogs/domain/usecases/upload_blog.dart
// Purpose: Blog feature implementation.

import 'dart:io';

import 'package:blogs_demo/core/errors/failure.dart';
import 'package:blogs_demo/core/usecase/use_case.dart';
import 'package:blogs_demo/features/blogs/domain/entities/blog.dart';
import 'package:blogs_demo/features/blogs/domain/repos/blog_repo.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements Usecase<Blog, UploadBlogParams> {
  final BlogRepo blogrepo;

  UploadBlog({required this.blogrepo});

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogrepo.uploadBlog(
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
      image: params.image,
    );
  }
}

class UploadBlogParams {
  final String title;
  final String content;
  final String posterId;
  final File image;
  final List<String> topics;

  UploadBlogParams({
    required this.title,
    required this.content,
    required this.posterId,
    required this.image,
    required this.topics,
  });
}
