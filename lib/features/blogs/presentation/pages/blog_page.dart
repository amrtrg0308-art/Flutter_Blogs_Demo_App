// File: lib/features/blogs/presentation/pages/blog_page.dart
// Purpose: Blog feature implementation.

import 'package:blogs_demo/core/common/widgets/loader.dart';
import 'package:blogs_demo/core/theme/app_palette.dart';
import 'package:blogs_demo/core/utils/show_snakbar.dart';
import 'package:blogs_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogs_demo/features/auth/presentation/pages/login.dart';
import 'package:blogs_demo/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:blogs_demo/features/blogs/presentation/pages/add_new_blog.dart';
import 'package:blogs_demo/features/blogs/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(BlogsFetchAllBlogs());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthUserLogout());
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => Login())),
              ModalRoute.withName('/2'),
            );
          },
          icon: Icon(Icons.logout),
        ),
        title: Text('Blogs', style: TextStyle(color: Colors.white)),
        backgroundColor: AppPalette.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewBlog()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            ShowsnakBar(
              context: context,
              content: state.message,
              color: Colors.red.shade900,
            );
          }
        },
        builder: (context, state) {
          if (State is BlogLoading) {
            return const Loader();
          }
          if (state is BlogsFetchAllBlogsSuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, i) {
                final blog = state.blogs[i];
                return BLogCard(
                  blog: blog,
                  color: const Color.fromARGB(255, 47, 47, 47),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
