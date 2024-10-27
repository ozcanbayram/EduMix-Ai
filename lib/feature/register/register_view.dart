import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/feature/register/register_model.dart'; // Yeni model dosyasını içe aktar
import 'package:edumix/feature/welcome/welcome_view.dart';
import 'package:edumix/product/widgets/auth_text_button.dart';
import 'package:edumix/product/widgets/button_large.dart';
import 'package:edumix/product/widgets/custom_text_field.dart';
import 'package:edumix/product/widgets/logo_widget.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final RegisterModel _registerModel = RegisterModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProjectText.appName),
      ),
      body: Padding(
        padding: const PagePadding.all(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const LogoWidget(),
              Column(
                children: [
                  CustomTextField(
                    nameController: _nameController,
                    prefixIcon: const Icon(Icons.person),
                    textInputAction: TextInputAction.next,
                    labelText: 'Ad Soyad',
                  ),
                  CustomTextField(
                    nameController: _emailController,
                    prefixIcon: const Icon(Icons.email),
                    textInputAction: TextInputAction.next,
                    labelText: 'E posta',
                  ),
                  CustomTextField(
                    nameController: _passwordController,
                    prefixIcon: const Icon(Icons.lock),
                    textInputAction: TextInputAction.done,
                    labelText: 'Parola',
                  ),
                  CustomTextField(
                    nameController: _passwordController,
                    prefixIcon: const Icon(Icons.lock),
                    textInputAction: TextInputAction.done,
                    labelText: 'Parola Tekrar',
                  ),
                ],
              ),
              ButtonLarge(
                onPressed: _register,
                buttonsText: ProjectText.registerButton,
              ),
              AuthTextButton(
                onPressed: () {},
                text: ProjectText.haveAccountLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Auth metodu:

  Future<void> _register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final displayName = _nameController.text;

    final user = await _registerModel.register(
      email,
      password,
      displayName,
    ); // Model üzerinden kayıt islemi
    if (user != null) {
      // Kayıt basarili
      await Navigator.pushReplacement(
        context,
        // ignore: inference_failure_on_instance_creation
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    } else {
      // Hata
      print('Kullanıcı kaydedilemedi.');
    }
  }
}
