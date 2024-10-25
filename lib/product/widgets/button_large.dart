import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ButtonLarge extends StatelessWidget {
  const ButtonLarge({
    required this.onPressed,
    super.key,
  });

  // final Function? onPressed;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          context.padding.verticalNormal + context.padding.horizontalMedium,
      child: SizedBox(
        height: WidgetSizes.buttonLargeHeight,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: const Text(
            ProjectText.registerButton,
            style: TextStyle(
              color: ColorItems.project_white,
              fontSize: WidgetSizes.normalTextSize,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
