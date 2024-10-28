import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:edumix/feature/welcome/welcome_model.dart';
import 'package:edumix/product/widgets/description_texts.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

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

class WelcomeSelector extends StatelessWidget {
  const WelcomeSelector({
    required TabController tabController,
    super.key,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.normal,
      child: TabPageSelector(
        controller: _tabController,
        color: ColorItems.project_blue,
        selectedColor: ColorItems.project_orange,
        indicatorSize: WidgetSizes.indicatorSize,
        borderStyle: BorderStyle.none,
      ),
    );
  }
}
