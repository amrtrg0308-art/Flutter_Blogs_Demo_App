// ignore_for_file: avoid_print
// File: lib/init_dependences.dart
// Purpose: Service locator setup and dependency registration.

import 'package:blogs_demo/core/common/cubits/App_user_cubit/app_user_cubit.dart';
import 'package:blogs_demo/core/network/connection_checker.dart';
import 'package:blogs_demo/core/secrets/app_secrets.dart';
import 'package:blogs_demo/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:blogs_demo/features/auth/data/repos/auth_repo_impl.dart';
import 'package:blogs_demo/features/auth/domain/repo/auth_repo.dart';
import 'package:blogs_demo/features/auth/domain/usecases/current_user.dart';
import 'package:blogs_demo/features/auth/domain/usecases/user_login.dart';
import 'package:blogs_demo/features/auth/domain/usecases/user_logout.dart';
import 'package:blogs_demo/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blogs_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogs_demo/features/blogs/data/datasource/blog_local_datasource.dart';
import 'package:blogs_demo/features/blogs/data/datasource/blog_remote_datasource.dart';
import 'package:blogs_demo/features/blogs/data/repos/blog_repo_impl.dart';
import 'package:blogs_demo/features/blogs/domain/repos/blog_repo.dart';
import 'package:blogs_demo/features/blogs/domain/usecases/get_all_blogs.dart';
import 'package:blogs_demo/features/blogs/domain/usecases/upload_blog.dart';
import 'package:blogs_demo/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependences() async {
  // Register authentication-related dependencies.
  _intiAuth();

  // Register blog-related dependencies.
  _intitBlog();

  final supabase = await Supabase.initialize(
    url: AppSecrets.url,
    anonKey: AppSecrets.anonKey,
  );

  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  final blogBox = await Hive.openBox('blogs');
  serviceLocator.registerSingleton<Box<dynamic>>(blogBox);

  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());

  // * Core support classes
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(internetConnection: serviceLocator()),
  );
}

void _intiAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(supabaseClient: serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepo>(
    () => AuthRepoImpl(
      authRemoteDatasource: serviceLocator(),
      connectionChecker: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(() => UserSignUp(authrepo: serviceLocator()));

  serviceLocator.registerFactory(() => UserLogin(authrepo: serviceLocator()));

  serviceLocator.registerFactory(() => UserLogout(authrepo: serviceLocator()));

  serviceLocator.registerFactory(() => CurrentUser(authRepo: serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
      userLogout: serviceLocator(),
    ),
  );
}

void _intitBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDatasource>(
      () => BlogRemoteDatasourceImpl(supabaseClient: serviceLocator()),
    )
    ..registerFactory<BlogLocalDatasource>(
      () => BlogLocalDatasourceImpl(box: serviceLocator()),
    )
    ..registerFactory<BlogRepo>(
      () => BlogRepoImpl(
        blogRemoteDatasource: serviceLocator(),
        connectionChecker: serviceLocator(),
        blogLocalDatasource: serviceLocator(),
      ),
    )
    ..registerFactory(() => UploadBlog(blogrepo: serviceLocator()))
    ..registerFactory(() => GetAllBlogs(blogRepo: serviceLocator()))
    ..registerLazySingleton(
      () =>
          BlogBloc(uploadBlog: serviceLocator(), getAllBlogs: serviceLocator()),
    );
}
