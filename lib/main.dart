// File: lib/main.dart
// Purpose: Application entrypoint and root widget.

import 'package:blogs_demo/core/common/cubits/App_user_cubit/app_user_cubit.dart';
import 'package:blogs_demo/core/theme/app_theme.dart';
import 'package:blogs_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogs_demo/features/auth/presentation/pages/login.dart';
import 'package:blogs_demo/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:blogs_demo/features/blogs/presentation/pages/blog_page.dart';
import 'package:blogs_demo/init_dependences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // Ensure Flutter bindings are initialized before using plugins.
  WidgetsFlutterBinding.ensureInitialized();

  // Register app dependencies and services before running the app.
  await initDependences();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<BlogBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Trigger authentication status check when the app starts.
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Application name
      title: 'Blogs Demo',

      theme: AppTheme.darkThemeMode,

      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLogedIn) {
          if (isLogedIn) {
            return const BlogPage();
          }
          return const Login();
        },
      ),
    );
  }
}
//
