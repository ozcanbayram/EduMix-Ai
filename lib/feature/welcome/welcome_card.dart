import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:edumix/feature/welcome/welcome_model.dart';
import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({required this.model, super.key});

  final WelcomeModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        model.image,
        Text(
          textAlign: TextAlign.center,
          model.description ,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorItems.project_text_color,
                fontWeight: FontWeight.bold,
                fontSize: WidgetSizes.normalDescriptionSize,
              ),
        ),
      ],
    );
  }
}
