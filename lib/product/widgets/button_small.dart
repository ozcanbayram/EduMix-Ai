import 'package:edumix/core/constants/color_items.dart';
import 'package:flutter/material.dart';

class ButtonSmall extends StatelessWidget {
  const ButtonSmall({
    required this.onPress,
    required this.text,
    super.key,
  });

  final VoidCallback onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: ColorItems.project_white),
      ),
    );
  }
}
