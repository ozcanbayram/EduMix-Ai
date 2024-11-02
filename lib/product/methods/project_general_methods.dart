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
      backgroundColor: ColorItems.project_gray,
    ),
  );
}

//* Navigator1 = sayfa üzerine getirir (navigateTo)
void navigateTo(BuildContext context, Widget page) {
  Navigator.push(
    context,
    // ignore: inference_failure_on_instance_creation
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0); // Sağdan gelme
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        // Animasyon değerleri
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}

//* Navigator2 = yeni sayfa acarken eskiyi kapatir (navigateReplacementTo)
void navigateReplacementTo(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    // ignore: inference_failure_on_instance_creation
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 2); // Sağdan gelme
        const end = Offset.zero;
        const curve = Curves.easeInOutCirc;

        // Animasyon değerleri
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
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

void navigateWithParameter(
  BuildContext context,
  Widget Function(String) pageBuilder,
  String parameter,
) {
  Navigator.push(
    context,
    // ignore: inference_failure_on_instance_creation
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          pageBuilder(parameter),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1, 0); // Sağdan gelme
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        // Animasyon değerleri
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ),
  );
}
