import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:flutter/material.dart';

//* SnackBar Metodu
void showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: WidgetSizes.normalDescriptionSize),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: ColorItems.project_orange,
    ),
  );
}

//* Navigator1 = sayfa üzerine getirir (navigateTo)
void navigateTo(BuildContext context, Widget page) {
  Navigator.push(
    context,
    // ignore: inference_failure_on_instance_creation
    MaterialPageRoute(builder: (context) => page),
  );
}

//* Navigator2 = yeni sayfa acarken eskiyi kapatir (navigateReplacementTo)
void navigateReplacementTo(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    // ignore: inference_failure_on_instance_creation
    MaterialPageRoute(builder: (context) => page),
  );
}

//* Navigator3 = yeni sayfa acarken belirli sayfaya gelince eskileri kapatir (navigateUntil)
void navigateUntil(BuildContext context, Widget page) {
  // Geçerli sayfayı kapat
  Navigator.popUntil(context, (route) {
    // Belirtilen sayfaya dönmek için koşulu kontrol et
    return route.settings.name == page.runtimeType.toString();
  });
}