import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum ImageEnums { learning_first, learning_second, learning_third }

extension ImageEnumExtension on ImageEnums {
  String get _toPath => 'asset/images/ic_$name.png';

  Image get toImage => Image.asset(_toPath);
}
