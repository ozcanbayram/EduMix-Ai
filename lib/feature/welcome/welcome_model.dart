import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/enums/image_enum.dart';
import 'package:flutter/material.dart';

class WelcomeModel {
  WelcomeModel({
    required this.description,
    required this.image,
    required this.index,
  });

  final String description;
  final Image image;
  int index;
}

class WelcomeElements {
  static final List<WelcomeModel> welcomeItems = [
    WelcomeModel(
      index: 1,
      description: ProjectText.firstWelcomeText,
      image: ImageEnums.learning_first.toImage,
    ),
    WelcomeModel(
      index: 2,
      description: ProjectText.secondWelcomeText,
      image: ImageEnums.learning_second.toImage,
    ),
    WelcomeModel(
      index: 3,
      description: ProjectText.thirdWelcomeText,
      image: ImageEnums.learning_third.toImage,
    ),
  ];
}
