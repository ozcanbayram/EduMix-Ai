import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/enums/image_enum.dart';
import 'package:flutter/material.dart';

class WelcomeModel {
  WelcomeModel({
    required this.description,
    required this.image,
  });

  final String description;
  final Image image;
}

class WelcomeElements {
  static final List<WelcomeModel> welcomeItems = [
    WelcomeModel(
      description: ProjectText.firstWelcomeText,
      image: ImageEnums.learning_first.toImage,
    ),
    WelcomeModel(
      description: ProjectText.secondWelcomeText,
      image: ImageEnums.learning_second.toImage,
    ),
    WelcomeModel(
      description: ProjectText.thirdWelcomeText,
      image: ImageEnums.learning_third.toImage,
    ),
  ];
}
