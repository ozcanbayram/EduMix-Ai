import 'package:flutter/material.dart';

@immutable // içerisinde degisken tanımlanmaması için
class ProjectText {
  const ProjectText._(); // Sadece sınıf içeinden erişilebilir.

  static const String appName = 'EduMix';

  static const String firstWelcomeText =
      'Yapay zeka taradınfan oluşturulan sayısız \n bilgi EduMix’te.';

  static const String secondWelcomeText =
      'EduMix ile bir çok kategoride \n hızlıca bilgi edinebilirsin.';

  static const String thirdWelcomeText =
      'Bilgi her zaman vardır \n sadece onu bulmanı bekler. ';
}
