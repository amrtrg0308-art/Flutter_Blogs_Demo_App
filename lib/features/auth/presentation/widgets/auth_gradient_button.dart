// File: lib/features/auth/presentation/widgets/auth_gradient_button.dart
// Purpose: Authentication feature implementation.

import 'package:blogs_demo/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AuthGradintButton extends StatelessWidget {
  const AuthGradintButton({super.key, required this.text, this.ontap});

  final String text;
  final VoidCallback? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        gradient: LinearGradient(
          colors: [AppPalette.gradient1, AppPalette.gradient2],
          begin: AlignmentGeometry.bottomRight,
          end: AlignmentGeometry.topLeft,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.transparentColor,
          shadowColor: AppPalette.transparentColor,
          fixedSize: const Size(365, 55),
        ),
        onPressed: ontap,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
    );
  }
}
