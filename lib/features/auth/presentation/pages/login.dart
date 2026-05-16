// File: lib/features/auth/presentation/pages/login.dart
// Purpose: Authentication feature implementation.

import 'package:blogs_demo/core/common/widgets/loader.dart';
import 'package:blogs_demo/core/theme/app_palette.dart';
import 'package:blogs_demo/core/utils/show_snakbar.dart';
import 'package:blogs_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogs_demo/features/auth/presentation/pages/sign_up.dart';
import 'package:blogs_demo/features/auth/presentation/widgets/auth_field.dart';
import 'package:blogs_demo/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blogs_demo/features/blogs/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isenable = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              isenable = false;
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: SizedBox(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [Text('Signing in'), Loader()],
                      ),
                    ),
                  ),
                );
            } else if (state is AuthFailure) {
              isenable = true;
              ShowsnakBar(
                context: context,
                content: state.message,
                color: Colors.red.shade900,
              );
            } else if (state is AuthSuccess) {
              isenable = true;
              ShowsnakBar(
                context: context,
                content: 'welcome ${state.user.name}',
                color: Colors.green.shade900,
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.greyColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AuthFeild(
                    hinttext: 'Email',
                    cont: email,
                    isEnable: isenable,
                    keyboardtype: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  AuthFeild(
                    hinttext: 'Password',
                    cont: password,
                    isHided: true,
                    isEnable: isenable,
                    keyboardtype: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  AuthGradintButton(
                    text: state is AuthLoading ? 'Sign in...' : 'Sign In',
                    ontap: state is AuthLoading
                        ? null
                        : () {
                            if (formkey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthLogin(
                                  email.text.trim(),
                                  password.text.trim(),
                                ),
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BlogPage();
                                  },
                                ),
                                ModalRoute.withName('blogs'),
                              );
                            }
                          },
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUp();
                          },
                        ),
                        ModalRoute.withName('/'),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: AppPalette.gradient2),
                          ),
                        ],
                        text: 'don\'t Have an account? ',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
