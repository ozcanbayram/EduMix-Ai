import 'package:edumix/core/enums/image_enum.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.medium,
      child: ImageEnums.logo.toImage,
    );
  }
}
