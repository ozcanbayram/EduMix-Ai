import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/feature/forgot_password/forgot_password.dart';
import 'package:edumix/feature/home/home_view.dart';
import 'package:edumix/feature/login/login_model.dart';
import 'package:edumix/product/widgets/auth_text_button.dart';
import 'package:edumix/product/widgets/button_large.dart';
import 'package:edumix/product/widgets/custom_text_field.dart';
import 'package:edumix/product/widgets/logo_widget.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginModel _loginModel = LoginModel();

  bool passwordVisibility = false;

  void _changePasswordVisibility() {
    setState(() {
      passwordVisibility = !passwordVisibility;
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
                    nameController: _emailController,
                    prefixIcon: const Icon(Icons.email),
                    textInputAction: TextInputAction.next,
                    labelText: ProjectText.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextField(
                    nameController: _passwordController,
                    obscureText: !passwordVisibility,
                    suffixIcon: IconButton(
                      onPressed: _changePasswordVisibility,
                      icon: passwordVisibility
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    textInputAction: TextInputAction.done,
                    labelText: ProjectText.password,
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
              ButtonLarge(
                onPressed: _login,
                buttonsText: ProjectText.loginButton,
              ),
              AuthTextButton(
                onPressed: () {
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    // ignore: inference_failure_on_instance_creation
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                text: ProjectText.forgotPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar(ProjectText.warningEmptyInput);
      return;
    }

    final user = await _loginModel.login(email, password);
    if (user != null) {
      _showSnackBar(ProjectText.successLogin);
      await Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        // ignore: inference_failure_on_instance_creation
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    } else {
      _showSnackBar(ProjectText.failedLogin);
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
