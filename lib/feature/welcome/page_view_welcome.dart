import 'package:flutter/material.dart';
import 'package:edumix/feature/welcome/welcome_model.dart';
import 'package:edumix/feature/welcome/welcome_card.dart';

class PageViewWelcome extends StatelessWidget {
  const PageViewWelcome({
    required this.pageController,
    required this.onPageChanged,
    super.key,
  });
  final PageController pageController;
  final ValueChanged<int> onPageChanged; //her sayfa degistiginde tetiklenir

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      onPageChanged: onPageChanged,
      itemCount: WelcomeElements.welcomeItems.length,
      itemBuilder: (context, index) {
        return WelcomeCard(
          model: WelcomeElements.welcomeItems[index],
        );
      },
    );
  }
}
