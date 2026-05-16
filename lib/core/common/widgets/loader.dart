// File: lib/core/common/widgets/loader.dart
// Purpose: Shared core utility, theme, network, or error handling code.

import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
