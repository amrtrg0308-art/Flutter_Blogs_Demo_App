// File: lib/features/auth/data/repos/auth_repo_impl.dart
// Purpose: Authentication feature implementation.

import 'package:blogs_demo/core/errors/exceptions.dart';
import 'package:blogs_demo/core/errors/failure.dart';
import 'package:blogs_demo/core/network/connection_checker.dart';
import 'package:blogs_demo/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:blogs_demo/core/common/entities/user.dart';
import 'package:blogs_demo/features/auth/data/models/user_model.dart';
import 'package:blogs_demo/features/auth/domain/repo/auth_repo.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepoImpl implements AuthRepo {
  final ConnectionChecker connectionChecker;
  final AuthRemoteDatasource authRemoteDatasource;

  /// Repository implementation that abstracts auth persistence and remote calls.
  AuthRepoImpl({
    required this.authRemoteDatasource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = authRemoteDatasource.currentUserSession;
        if (session == null) {
          return left(Failure(message: "User is not logged in"));
        }

        return right(
          UserModel(
            id: session.user.id,
            name: '',
            email: session.user.email ?? '',
          ),
        );
      }
      final user = await authRemoteDatasource.getCurrentUser();
      if (user == null) {
        return left(Failure(message: "User is not logged in"));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(message: "No internet connection"));
      }
      final user = await authRemoteDatasource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(
        Failure(message: "An unknown error occurred: ${e.toString()}"),
      );
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(message: "No internet connection"));
      }
      final user = await authRemoteDatasource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(
        Failure(message: "An unknown error occurred: ${e.toString()}"),
      );
    }
  }
  
  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      if (!await (connectionChecker.isConnected)){
        return left(Failure(message: "No internet connection"));
      }
      authRemoteDatasource.logout();
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    } catch (e) {
      return left(Failure(message: 'Unknown error: ${e.toString()}'));
    }
  }
}
