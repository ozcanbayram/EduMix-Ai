import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:flutter/material.dart';

class MainDescriptionWidget extends StatelessWidget {
  const MainDescriptionWidget({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: ColorItems.project_text_color,
            fontWeight: FontWeight.bold,
            fontSize: WidgetSizes.normalDescriptionSize,
          ),
    );
  }
}
