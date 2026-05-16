// File: lib/features/blogs/presentation/widgets/blog_card.dart
// Purpose: Blog feature implementation.

import 'package:blogs_demo/core/utils/calculate_reading_time.dart';
import 'package:blogs_demo/features/blogs/domain/entities/blog.dart';
import 'package:blogs_demo/features/blogs/presentation/pages/blog_viewer.dart';
import 'package:flutter/material.dart';

class BLogCard extends StatelessWidget {
  final Blog blog;
  final Color color;

  const BLogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BlogViewer(blog: blog)),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(16).copyWith(bottom: 4, top: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: blog.topics
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Chip(
                              label: Text(
                                e,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Text(
                  blog.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(10),
                    child: Image.network(blog.imageUrl),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              '${calculateReadingTime(blog.content)} min',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
