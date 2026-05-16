// File: lib/features/blogs/presentation/bloc/blog_state.dart
// Purpose: Blog feature implementation.

part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogSuccess extends BlogState {}

final class BlogFailure extends BlogState {
  final String message;

  BlogFailure({required this.message});
}

final class BlogsFetchAllBlogsSuccess extends BlogState {
  final List<Blog> blogs;

  BlogsFetchAllBlogsSuccess({required this.blogs});
}
