// File: lib/features/auth/domain/usecases/user_logout.dart
// Purpose: Authentication feature implementation.

import 'package:blogs_demo/core/errors/failure.dart';
import 'package:blogs_demo/core/usecase/use_case.dart';
import 'package:blogs_demo/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class UserLogout implements Usecase<Unit, NoParams>{
  final AuthRepo authrepo;

  UserLogout({required this.authrepo});

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await authrepo.logout();
  }
  
}