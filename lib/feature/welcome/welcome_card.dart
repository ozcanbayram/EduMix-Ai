import 'package:edumix/feature/welcome/welcome_model.dart';
import 'package:edumix/product/widgets/description_texts.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({required this.model, super.key});

  final WelcomeModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyTopHigh,
      child: Column(
        children: [
          model.image,
          MainDescriptionWidget(text: model.description),
        ],
      ),
    );
  }
}
