import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/feature/welcome/welcome_view.dart';
import 'package:edumix/product/services/auth_service.dart';
import 'package:edumix/product/widgets/button_large.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthService _authService = AuthService(); // AuthService örneği

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ProjectText.appName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: ButtonLarge(
          onPressed: _signOut, // Çıkış fonksiyonunu bağlayın
          buttonsText: 'Çık',
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    await _authService.signOut(); // Çıkış işlemi

    // Çıkış sonrası giriş sayfasına yönlendirme
    await Navigator.pushReplacement(
      context,
      // ignore: inference_failure_on_instance_creation
      MaterialPageRoute(builder: (context) => const WelcomePage()),
    );
  }
}
