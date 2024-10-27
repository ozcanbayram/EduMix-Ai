import 'package:edumix/feature/home/home_view.dart';
import 'package:edumix/feature/welcome/welcome_view.dart';
import 'package:edumix/product/services/auth_service.dart'; // AuthService sınıfını içe aktarın
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  AuthWrapper({super.key});
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // Kullanıcının oturum açma durumunu kontrol etmek için getCurrentUser kullanılıyor
    final user = _authService.getCurrentUser();

    if (user != null) {
      // Kullanıcı oturum açmışsa ana sayfaya yönlendirin
      return const HomeView();
    } else {
      // Kullanıcı oturum açmamışsa giriş sayfasına yönlendirin
      return const WelcomePage();
    }
  }
}
