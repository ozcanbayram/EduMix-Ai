import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/feature/home/home_view.dart';
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
                navigateTo(context, const HomeView());
              case 1:
                navigateTo(context, const CategorySearchPage());
              case 2:
              // navigateReplacementTo(context, const CategorySearchPage());
            }
          },
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              iconSize: 30,
              text: 'Anasayfa',
            ),
            GButton(
              icon: Icons.search,
              text: 'Kategori Ara',
              iconSize: 30,
            ),
            GButton(
              icon: Icons.favorite_border_outlined,
              iconSize: 30,
              text: 'Beğeniler',
            ),
          ],
        ),
      ),
    );
  }
}
