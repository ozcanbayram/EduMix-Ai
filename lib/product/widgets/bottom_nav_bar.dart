import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:edumix/feature/home/home_view.dart';
import 'package:edumix/feature/save/saved_item_screen.dart';
import 'package:edumix/feature/search/search_view.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    required this.selectedIndex,
    super.key,
  });
  final int selectedIndex;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    // ignore: use_colored_box
    return Container(
      color: ColorItems.project_scaffold_color,
      child: Padding(
        padding: const PagePadding.all(),
        child: GNav(
          padding: const PagePadding.all(),
          gap: 10,
          backgroundColor: ColorItems.project_scaffold_color,
          color: ColorItems.project_text_color,
          rippleColor: ColorItems.project_orange,
          activeColor: ColorItems.project_white,
          tabBackgroundColor: ColorItems.project_blue,
          tabBorderRadius: 8,
          selectedIndex: widget.selectedIndex,
          onTabChange: (value) {
            switch (value) {
              case 0:
                navigateReplacementTo(context, const HomeView());
              case 1:
                navigateReplacementTo(context, const CategorySearchPage());
              case 2:
                navigateReplacementTo(context, const SavedItemsScreen());
            }
          },
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              iconSize: WidgetSizes.bottomBarIconsSize,
              text: ProjectText.home,
            ),
            GButton(
              icon: Icons.search,
              text: ProjectText.search,
              iconSize: WidgetSizes.bottomBarIconsSize,
            ),
            GButton(
              icon: Icons.favorite_border_outlined,
              iconSize: WidgetSizes.bottomBarIconsSize,
              text: ProjectText.likes,
            ),
          ],
        ),
      ),
    );
  }
}
