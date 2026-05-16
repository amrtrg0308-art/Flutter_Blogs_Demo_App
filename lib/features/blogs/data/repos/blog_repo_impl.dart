// ignore_for_file: avoid_print
// File: lib/features/blogs/data/repos/blog_repo_impl.dart
// Purpose: Blog feature implementation.


import 'dart:io';

import 'package:blogs_demo/core/errors/exceptions.dart';
import 'package:blogs_demo/core/errors/failure.dart';
import 'package:blogs_demo/core/network/connection_checker.dart';
import 'package:blogs_demo/features/blogs/data/datasource/blog_local_datasource.dart';
import 'package:blogs_demo/features/blogs/data/datasource/blog_remote_datasource.dart';
import 'package:blogs_demo/features/blogs/data/models/blog_model.dart';
import 'package:blogs_demo/features/blogs/domain/entities/blog.dart';
import 'package:blogs_demo/features/blogs/domain/repos/blog_repo.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepoImpl implements BlogRepo {
  final BlogRemoteDatasource blogRemoteDatasource;
  final ConnectionChecker connectionChecker;
  final BlogLocalDatasource blogLocalDatasource;

  /// Implementation of the blog repository.
  ///
  /// Uses remote Supabase operations when online, and caches results locally
  /// for offline access.

  /// Default constructor for the blog repository implementation.
  BlogRepoImpl({
    required this.blogRemoteDatasource,
    required this.connectionChecker,
    required this.blogLocalDatasource,
  });
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
    required File image,
  }) async {
    try {
      print('Starting blog upload with title: $title');
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(message: "No internet connection"));
      }
      // Create initial blog model for image upload
      BlogModel tempBlogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        updatedAt: DateTime.now(),
        imageUrl: '',
        topics: topics,
      );

      // First upload the image
      final imageUrl = await blogRemoteDatasource.uploadBlogImage(
        image: image,
        blog: tempBlogModel,
      );

      print('Image uploaded successfully: $imageUrl');

      // Then create blog model with image URL
      BlogModel blogModel = BlogModel(
        id: tempBlogModel.id,
        posterId: posterId,
        title: title,
        content: content,
        updatedAt: DateTime.now(),
        imageUrl: imageUrl,
        topics: topics,
      );

      print('Uploading blog with data: ${blogModel.toJson()}');
      final uploadedBlog = await blogRemoteDatasource.uploadBlog(
        blog: blogModel,
      );

      print('Blog uploaded successfully with id: ${uploadedBlog.id}');
      return right(uploadedBlog);
    } on ServerException catch (e) {
      print('ServerException in uploadBlog: ${e.message}');
      return left(Failure(message: e.message));
    } catch (e) {
      print('Unexpected error in uploadBlog: $e');
      return left(Failure(message: 'Error uploading blog: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        // Use the local cache when network access is unavailable.
        print('Fetching all blogs from local datasource...');
        final blogs = blogLocalDatasource.loadBlogs();
        print('Fetched ${blogs.length} blogs successfully');
        return right(blogs);
      }
      print('Fetching all blogs from remote datasource...');
      final blogs = await blogRemoteDatasource.getAllBlogs();
      blogLocalDatasource.uploadLocalBlogs(blogs: blogs);
      print('Blog uploaded to the local datasource successfully.');
      print('Fetched ${blogs.length} blogs successfully');
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      print('Unexpected error in getAllBlogs: $e');
      return left(Failure(message: 'Error fetching blogs: ${e.toString()}'));
    }
  }
}
