// import 'package:edumix/product/constant/image_enum.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ProjectText.appName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: const Column(),
    );
  }
}
