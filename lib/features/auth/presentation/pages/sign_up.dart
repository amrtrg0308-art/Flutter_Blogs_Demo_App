// ignore_for_file: avoid_print
// File: lib/features/auth/presentation/pages/sign_up.dart
// Purpose: Authentication feature implementation.

import 'package:blogs_demo/core/theme/app_palette.dart';
import 'package:blogs_demo/core/utils/show_snakbar.dart';
import 'package:blogs_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogs_demo/features/auth/presentation/pages/login.dart';
import 'package:blogs_demo/features/auth/presentation/widgets/auth_field.dart';
import 'package:blogs_demo/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:blogs_demo/features/blogs/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isenable = true;

  @override
  void dispose() {
    name.dispose();
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
                content: 'Sign Up Done',
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
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  AuthFeild(
                    hinttext: 'Name',
                    cont: name,
                    isEnable: isenable,
                    keyboardtype: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  AuthFeild(
                    hinttext: 'Email',
                    cont: email,
                    isEnable: isenable,
                    keyboardtype: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  AuthFeild(
                    keyboardtype: TextInputType.text,
                    isEnable: isenable,
                    hinttext: 'Password',
                    cont: password,
                    isHided: true,
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return AuthGradintButton(
                        text: state is AuthLoading
                            ? 'Signing up...'
                            : 'Sign Up',
                        ontap: state is AuthLoading
                            ? null
                            : () {
                                if (formkey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    AuthSignUp(
                                      name: name.text.trim(),
                                      email: email.text.trim(),
                                      password: password.text.trim(),
                                    ),
                                  );
                                  email.clear();
                                }
                                name.clear();
                                password.clear();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlogPage(),
                                  ),
                                  ModalRoute.withName('/'),
                                );
                              },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) {
                            return Login();
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
                        text: 'Have an account? ',
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
