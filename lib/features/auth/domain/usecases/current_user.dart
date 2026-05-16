// File: lib/features/auth/domain/usecases/current_user.dart
// Purpose: Authentication feature implementation.

import 'package:blogs_demo/core/errors/failure.dart';
import 'package:blogs_demo/core/usecase/use_case.dart';
import 'package:blogs_demo/core/common/entities/user.dart';
import 'package:blogs_demo/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepo authRepo;

  CurrentUser({required this.authRepo});
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepo.currentUser();
  }
}
