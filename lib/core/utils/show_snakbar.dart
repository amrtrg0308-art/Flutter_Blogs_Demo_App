// File: lib/core/utils/show_snakbar.dart
// Purpose: Shared core utility, theme, network, or error handling code.

import 'package:flutter/material.dart';

void ShowsnakBar({
  required BuildContext context,
  required String content,
  required Color color,
  double height = 20,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Container(
          height: height,
          color: color,
          child: Center(
            child: Text(content, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        backgroundColor: color,
      ),
    );
}
