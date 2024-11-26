import 'package:flutter/material.dart';

//! imageler burada tanımlanır ve buradaki metod aracılığıyla kullanılir.

// ignore: constant_identifier_names
@immutable
enum ImageEnums {
  learning_first,
  learning_second,
  learning_third,
  logo,
  forgot
}

extension ImageEnumExtension on ImageEnums {
  String get _toPath => 'asset/images/ic_$name.png';

  Image get toImage => Image.asset(_toPath);
}
