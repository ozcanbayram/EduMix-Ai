import 'package:edumix/core/constants/color_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: ColorItems.project_blue,
  //APPBAR THEME
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
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

  //ELEVATED BUTTON THEME
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorItems.project_blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      shadowColor: ColorItems.project_black,
    ),
  ),
);

class ThemeSizes {
  final double toolBarHeight = 75;
}
