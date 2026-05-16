// File: lib/features/auth/domain/repo/auth_repo.dart
// Purpose: Authentication feature implementation.

import 'package:blogs_demo/core/errors/failure.dart';
import 'package:blogs_demo/core/common/entities/user.dart';

import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepo {
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> currentUser();

  Future<Either<Failure, Unit>> logout();
}
