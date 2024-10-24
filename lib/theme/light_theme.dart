import 'package:edumix/core/constants/color_items.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  //APPBAR THEME
  appBarTheme: AppBarTheme(
    backgroundColor: ColorItems.project_scaffold_color,
    toolbarHeight: ThemeSizes().toolBarHeight,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: ColorItems.project_text_color,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  ),
  //SCAFFOLD THEME
  scaffoldBackgroundColor: ColorItems.project_scaffold_color,
  //TEXT THEME
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: ColorItems.project_second_text_color,
    ),
  ),
);

class ThemeSizes {
  final double toolBarHeight = 75;
}
