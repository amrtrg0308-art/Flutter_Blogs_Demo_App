// File: lib/features/blogs/presentation/pages/blog_viewer.dart
// Purpose: Blog feature implementation.

import 'package:blogs_demo/core/theme/app_palette.dart';
import 'package:blogs_demo/core/utils/calculate_reading_time.dart';
import 'package:blogs_demo/core/utils/format_date.dart';
import 'package:blogs_demo/features/blogs/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogViewer extends StatelessWidget {
  final Blog blog;
  const BlogViewer({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title, style: TextStyle(fontSize: 20),),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "By ${blog.posterName}",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "${formateDAte(blog.updatedAt)} . ${calculateReadingTime(blog.content)}min",
                style: TextStyle(color: AppPalette.greyColor, fontSize: 10),
              ),
              const SizedBox(height: 20),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(blog.imageUrl),
                ),
              ),
              const SizedBox(height: 20),
              Text(blog.content, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
