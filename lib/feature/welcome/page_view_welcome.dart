import 'package:edumix/feature/welcome/welcome_card.dart';
import 'package:edumix/feature/welcome/welcome_model.dart';
import 'package:flutter/material.dart';

class PageViewWelcome extends StatelessWidget {
  const PageViewWelcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: WelcomeElements.welcomeItems.length,
      itemBuilder: (context, index) {
        return WelcomeCard(
          model: WelcomeElements.welcomeItems[index],
        );
      },
    );
  }
}
