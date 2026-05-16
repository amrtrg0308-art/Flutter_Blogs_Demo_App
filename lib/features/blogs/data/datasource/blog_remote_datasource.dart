// File: lib/features/blogs/data/datasource/blog_remote_datasource.dart
// Purpose: Blog feature implementation.

import 'dart:io';

import 'package:blogs_demo/core/errors/exceptions.dart';
import 'package:blogs_demo/features/blogs/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDatasource {
  Future<BlogModel> uploadBlog({required BlogModel blog});
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDatasourceImpl implements BlogRemoteDatasource {
  final SupabaseClient supabaseClient;

  BlogRemoteDatasourceImpl({required this.supabaseClient});
  @override
  Future<BlogModel> uploadBlog({required BlogModel blog}) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blog.toJson())
          .select();
      return BlogModel.fromJson(blogData.first as Map);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabaseClient.storage
          .from('blog_images_id')
          .upload(blog.id, image);
      return supabaseClient.storage
          .from('blog_images_id')
          .getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final response = await supabaseClient
          .from('blogs')
          .select('*, pprofiles (name)');
      final blogList = (response as List).cast<Map>();
      return blogList.map((blogMap) {
        return BlogModel.fromJson(
          blogMap,
        ).copyWith(posterName: blogMap['pprofiles']['name'] as String?);
      }).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
