// File: lib/features/blogs/domain/usecases/get_all_blogs.dart
// Purpose: Blog feature implementation.

import 'package:blogs_demo/core/errors/failure.dart';
import 'package:blogs_demo/core/usecase/use_case.dart';
import 'package:blogs_demo/features/blogs/domain/entities/blog.dart';
import 'package:blogs_demo/features/blogs/domain/repos/blog_repo.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements Usecase<List<Blog>, NoParams> {
  final BlogRepo blogRepo;

  GetAllBlogs({required this.blogRepo});

  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepo.getAllBlogs();
  }
}
