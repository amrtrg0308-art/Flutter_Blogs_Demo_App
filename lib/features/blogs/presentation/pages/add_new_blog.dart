// ignore_for_file: avoid_print
// File: lib/features/blogs/presentation/pages/add_new_blog.dart
// Purpose: Blog feature implementation.


import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:blogs_demo/core/common/cubits/App_user_cubit/app_user_cubit.dart';
import 'package:blogs_demo/core/common/widgets/loader.dart';
import 'package:blogs_demo/core/theme/app_palette.dart';
import 'package:blogs_demo/core/utils/pick_image.dart';
import 'package:blogs_demo/core/utils/show_snakbar.dart';
import 'package:blogs_demo/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:blogs_demo/features/blogs/presentation/pages/blog_page.dart';
import 'package:blogs_demo/features/blogs/presentation/widgets/blog_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlog extends StatefulWidget {
  const AddNewBlog({super.key});

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  final TextEditingController titleControler = TextEditingController();
  final TextEditingController contentControler = TextEditingController();
  final List<String> selectedItems = [];
  File? image;
  final formkey = GlobalKey<FormState>();

  void selectImage() async {
    print('selectImage called');
    final pickedImage = await pickAnImage();
    print('Picked image: $pickedImage');
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
        print('Image set: ${image?.path}');
      });
    }
  }

  @override
  void dispose() {
    titleControler.dispose();
    contentControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppPalette.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              if (formkey.currentState!.validate() &&
                  selectedItems.isNotEmpty &&
                  image != null) {
                final posterId =
                    (context.read<AppUserCubit>().state as AppUserLoggedIn)
                        .user
                        .id;
                context.read<BlogBloc>().add(
                  BlogUpload(
                    title: titleControler.text.trim(),
                    content: contentControler.text.trim(),
                    posterId: posterId,
                    topics: selectedItems,
                    image: image!,
                  ),
                );
              }
            },
            icon: Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogSuccess) {
            ShowsnakBar(
              context: context,
              content: 'Blog Uploaded',
              color: Colors.green.shade900,
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BlogPage()),
              (route) => false,
            );
          } else if (state is BlogFailure) {
            ShowsnakBar(
              context: context,
              content: state.message,
              color: Colors.red.shade900,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    image != null
                        ? InkWell(
                            onTap: () => selectImage(),
                            child: SizedBox(
                              height: 160,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(image!, fit: BoxFit.contain),
                              ),
                            ),
                          )
                        : DottedBorder(
                            options: RoundedRectDottedBorderOptions(
                              strokeCap: StrokeCap.round,
                              color: AppPalette.borderColor,
                              dashPattern: const [10, 4],
                              radius: Radius.circular(15),
                            ),
                            child: InkWell(
                              onTap: () {
                                selectImage();
                              },
                              child: Container(
                                padding: EdgeInsets.all(30),
                                height: 150,
                                width: double.infinity,
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'Select your image',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            [
                                  'Technology',
                                  'Businuss',
                                  'Programing',
                                  'Entertainment',
                                ]
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedItems.contains(e)) {
                                          selectedItems.remove(e);
                                        } else {
                                          selectedItems.add(e);
                                        }
                                        setState(() {});
                                      },
                                      child: Chip(
                                        color: selectedItems.contains(e)
                                            ? const WidgetStatePropertyAll(
                                                AppPalette.gradient1,
                                              )
                                            : null,
                                        side: selectedItems.contains(e)
                                            ? null
                                            : BorderSide(
                                                color: AppPalette.borderColor,
                                              ),
                                        label: Text(
                                          e,
                                          style: TextStyle(
                                            color: selectedItems.contains(e)
                                                ? Colors.black
                                                : AppPalette.greyColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    SizedBox(height: 20),
                    BlogEditor(con: titleControler, hinttext: 'Blog title'),
                    SizedBox(height: 10),
                    BlogEditor(con: contentControler, hinttext: 'Blog content'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
