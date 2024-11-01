import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: ColorItems.project_blue,
  //APPBAR THEME
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    backgroundColor: ColorItems.project_scaffold_color,
    toolbarHeight: WidgetSizes.toolBarHeight,
    centerTitle: true,
    titleTextStyle: TextStyle(
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
    bodyLarge: TextStyle(
      color: ColorItems.project_second_text_color,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(color: ColorItems.project_second_text_color),
    bodySmall: TextStyle(color: ColorItems.project_second_text_color),
    displayLarge: TextStyle(color: ColorItems.project_second_text_color),
    displayMedium: TextStyle(
      color: ColorItems.project_second_text_color,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(color: ColorItems.project_second_text_color),
    headlineLarge: TextStyle(
      color: ColorItems.project_second_text_color,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      color: ColorItems.project_second_text_color,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(color: ColorItems.project_second_text_color),
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

  // LIST TILE THEME
  listTileTheme: const ListTileThemeData(
    contentPadding: PagePadding.all(),
    titleTextStyle: TextStyle(
      fontSize: WidgetSizes.mediumTextSize,
      fontWeight: FontWeight.bold,
      color: ColorItems.project_text_color,
    ),
    subtitleTextStyle: TextStyle(
      fontSize: WidgetSizes.normalTextSize,
      fontWeight: FontWeight.w500,
      color: ColorItems.project_gray,
    ),
  ),

  // CARD THEME
  cardTheme: CardTheme(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    color: ColorItems.project_white,
  ),

  // INPUT DECORATION THEME
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: ColorItems.project_white,
    labelStyle: const TextStyle(
      color: ColorItems.project_text_color,
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: ColorItems.project_second_text_color,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: ColorItems.project_second_text_color,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: ColorItems.project_second_text_color,
      ),
    ),
    prefixIconColor: ColorItems.project_text_color,
  ),
);
