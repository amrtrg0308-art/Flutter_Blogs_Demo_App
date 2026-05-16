// File: lib/features/auth/domain/usecases/user_login.dart
// Purpose: Authentication feature implementation.

import 'package:blogs_demo/core/errors/failure.dart';
import 'package:blogs_demo/core/usecase/use_case.dart';
import 'package:blogs_demo/core/common/entities/user.dart' show User;
import 'package:blogs_demo/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements Usecase<User, UserLoginParams> {
  final AuthRepo authrepo;

  const UserLogin({required this.authrepo});
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return authrepo.loginWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
