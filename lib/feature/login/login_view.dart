import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/feature/forgot_password/forgot_password_view.dart';
import 'package:edumix/feature/home/home_view.dart';
import 'package:edumix/feature/login/login_model.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
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

  void _togglePasswordVisibility() {
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
              _buildInputFields(),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  //! Metotlar ve Widgetlar

  Widget _buildInputFields() {
    return Column(
      children: [
        CustomEmailField(nameController: _emailController),
        CustomPasswordField(
          nameController: _passwordController,
          obscureText: !passwordVisibility,
          suffixIcon: passwordVisibility
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: _togglePasswordVisibility,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ButtonLarge(
          onPressed: _login,
          buttonsText: ProjectText.loginButton,
        ),
        AuthTextButton(
          onPressed: () {
            navigateTo(context, const ForgotPasswordView());
          },
          text: ProjectText.forgotPassword,
        ),
      ],
    );
  }

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showCustomSnackBar(context, ProjectText.warningEmptyInput);
      return;
    }

    final user = await _loginModel.login(email, password);
    if (user != null) {
      // Kayıt başarılı, mesaj göster ve yönlendir
      // ignore: use_build_context_synchronously
      showCustomSnackBar(context, ProjectText.successLogin);
      // ignore: use_build_context_synchronously
      navigateReplacementTo(context, const HomeView());
    } else {
      // Kayıt hatası
      // ignore: use_build_context_synchronously
      showCustomSnackBar(context, ProjectText.failedLogin);
    }
  }
}
