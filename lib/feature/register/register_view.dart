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
  final _passwordAgainController = TextEditingController();
  final _nameController = TextEditingController();
  final RegisterModel _registerModel = RegisterModel();

  bool passwordVisibility = false;
  bool passwordAgainVisibility = false;

  void _changePasswordVisibility() {
    setState(() {
      passwordVisibility = !passwordVisibility;
    });
  }

  void _changePassworAgaindVisibility() {
    setState(() {
      passwordAgainVisibility = !passwordAgainVisibility;
    });
  }

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
                    keyboardType: TextInputType.text,
                  ),
                  CustomTextField(
                    nameController: _emailController,
                    prefixIcon: const Icon(Icons.email),
                    textInputAction: TextInputAction.next,
                    labelText: 'E posta',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextField(
                    nameController: _passwordController,
                    obscureText: passwordVisibility,
                    suffixIcon: IconButton(
                      onPressed: _changePasswordVisibility,
                      icon: passwordVisibility
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    textInputAction: TextInputAction.next,
                    labelText: 'Parola',
                    keyboardType: TextInputType.text,
                  ),
                  CustomTextField(
                    nameController: _passwordAgainController,
                    obscureText: passwordAgainVisibility,
                    suffixIcon: IconButton(
                      onPressed: _changePassworAgaindVisibility,
                      icon: passwordAgainVisibility
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    textInputAction: TextInputAction.done,
                    labelText: 'Parola Tekrar',
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
              ButtonLarge(
                onPressed: _register,
                buttonsText: ProjectText.registerButton,
              ),
              AuthTextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Bu bir test mesajıdır.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                text: ProjectText.haveAccountLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Auth kayit metodu:
  Future<void> _register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final passwordAgain = _passwordAgainController.text;
    final displayName = _nameController.text;

    if (email.isEmpty || displayName.isEmpty) {
      _showSnackBar('E-posta ve ad soyad boş olamaz.');
      return;
    }
    if (password != passwordAgain) {
      _showSnackBar('Parolalar aynı değil.');
      return;
    }

    final user = await _registerModel.register(email, password, displayName);

    if (user != null) {
      // Kayıt başarılı
      _showSnackBar('Kayıt başarılı!');
      await Navigator.pushReplacement(
        context,
        // ignore: inference_failure_on_instance_creation
        MaterialPageRoute(builder: (context) => const WelcomePage()),
      );
    } else {
      // Kayıt hatası
      _showSnackBar('Kullanıcı kaydedilemedi.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
