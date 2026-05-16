// File: lib/features/blogs/presentation/bloc/blog_bloc.dart
// Purpose: Blog feature implementation.

import 'dart:io';

import 'package:blogs_demo/core/usecase/use_case.dart';
import 'package:blogs_demo/features/blogs/domain/entities/blog.dart';
import 'package:blogs_demo/features/blogs/domain/usecases/get_all_blogs.dart';
import 'package:blogs_demo/features/blogs/domain/usecases/upload_blog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
    : _getAllBlogs = getAllBlogs,
      _uploadBlog = uploadBlog,
      super(BlogInitial()) {
    // Show loading state for any incoming blog event.
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });
    on<BlogUpload>(_onBlogIpload);
    on<BlogsFetchAllBlogs>(_onFetchAllBlogs);
  }

  void _onBlogIpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        title: event.title,
        content: event.content,
        posterId: event.posterId,
        image: event.image,
        topics: event.topics,
      ),
    );
    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogSuccess()),
    );
  }

  void _onFetchAllBlogs(
    BlogsFetchAllBlogs event,
    Emitter<BlogState> emit,
  ) async {
    // Fetch the blog list, preferring remote data and falling back to local cache.
    final res = await _getAllBlogs(NoParams());

    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogsFetchAllBlogsSuccess(blogs: r)),
    );
  }
}
