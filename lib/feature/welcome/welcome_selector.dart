import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

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
