import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AuthTextButton extends StatelessWidget {
  const AuthTextButton({
    required this.onPressed,
    required this.text,
    super.key,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyBottomMedium + context.padding.horizontalLow,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: WidgetSizes.normalTextSize,
            color: ColorItems.project_text_color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
