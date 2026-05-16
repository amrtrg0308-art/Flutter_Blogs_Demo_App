// ignore_for_file: avoid_print
// File: lib/features/auth/data/data_sources/auth_remote_datasource.dart
// Purpose: Authentication feature implementation.

import 'dart:async';
import 'package:blogs_demo/core/errors/exceptions.dart';
import 'package:blogs_demo/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUser();

  Future<void> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final SupabaseClient supabaseClient;

  AuthRemoteDatasourceImpl({required this.supabaseClient});

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      print(
        '=======================================Starting Supabase signin with email: $email========================',
      );
      final respnse = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      print(
        '======================================User signin successfully: ${respnse.user?.id}',
      );
      if (respnse.user == null) {
        throw ServerException("User signin failed");
      }
      return UserModel.fromJson(respnse.user!.toJson());
    } on AuthApiException catch (e) {
      print('AuthApiException: ${e.message}');
      throw ServerException(e.message);
    } on ServerException catch (e) {
      print('ServerException: ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error in login: $e');
      throw ServerException("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      print(
        '=======================================Starting Blogs signup with email: $email========================',
      );
      final respnse = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      print(
        '======================================User created successfully: ${respnse.user?.id}',
      );

      print('Display name updated: $name');
      if (respnse.user == null) {
        throw ServerException("User creation failed");
      }
      return UserModel.fromJson(respnse.user!.toJson());
    } on ServerException {
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      throw ServerException("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('pprofiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(userData.first);
      }

      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<void> logout() async {
    try {
      print('loging out user=============================');
      await supabaseClient.auth.signOut();
      print('loging out done============================');
    } on ServerException catch (e){
      throw ServerException(e.toString());
    } catch (e) {
      throw ServerException('Unkown error : ${e.toString()}');
    }
  }
}
