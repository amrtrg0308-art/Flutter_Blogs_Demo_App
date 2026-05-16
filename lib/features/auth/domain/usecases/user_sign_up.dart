// File: lib/features/auth/domain/usecases/user_sign_up.dart
// Purpose: Authentication feature implementation.

import 'package:blogs_demo/core/errors/failure.dart';
import 'package:blogs_demo/core/usecase/use_case.dart';
import 'package:blogs_demo/core/common/entities/user.dart';
import 'package:blogs_demo/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements Usecase<User, UserSignUpParams> {
  final AuthRepo authrepo;

  UserSignUp({required this.authrepo});

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return await authrepo.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
