// File: lib/features/blogs/presentation/widgets/blog_editor.dart
// Purpose: Blog feature implementation.

import 'package:blogs_demo/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController con;
  final String hinttext;
  const BlogEditor({super.key, required this.con, required this.hinttext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: AppPalette.greyColor),
      decoration: InputDecoration(hintText: hinttext),
      controller: con,
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hinttext can not be empty';
        }
        return null;
      },
    );
  }
}
