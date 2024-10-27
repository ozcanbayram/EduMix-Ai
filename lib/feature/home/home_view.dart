import 'package:edumix/core/constants/project_text.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
