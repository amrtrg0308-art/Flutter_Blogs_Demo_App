// File: lib/features/auth/presentation/widgets/auth_field.dart
// Purpose: Authentication feature implementation.

import 'package:flutter/material.dart';

class AuthFeild extends StatelessWidget {
  const AuthFeild({
    super.key,
    required this.hinttext,
    required this.cont,
    this.isHided = false,
    required this.isEnable,
    required this.keyboardtype,
  });

  final String hinttext;
  final TextEditingController cont;
  final bool isHided;
  final bool isEnable;
  final TextInputType keyboardtype;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardtype,
      enabled: isEnable,
      controller: cont,
      obscureText: isHided,
      obscuringCharacter: '°',
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(hintText: hinttext),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hinttext can not be empty';
        }
        return null;
      },
    );
  }
}
