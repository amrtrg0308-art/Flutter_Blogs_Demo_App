// File: lib/core/utils/pick_image.dart
// Purpose: Shared core utility, theme, network, or error handling code.

import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickAnImage() async {
  try {
    final ImagePicker picker = ImagePicker();

    final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      return File(xFile.path);
    }

    return null;
  } catch (e) {
    return null;
  }
}
