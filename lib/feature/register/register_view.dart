import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/feature/home/home_view.dart';
import 'package:edumix/feature/login/login_view.dart';
import 'package:edumix/feature/register/register_model.dart'; // Yeni model dosyasını içe aktar
import 'package:edumix/product/methods/project_general_methods.dart';
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
                  CustomNameField(nameController: _nameController),
                  CustomEmailField(nameController: _emailController),
                  CustomPasswordField(
                    nameController: _passwordController,
                    obscureText: !passwordVisibility,
                    suffixIcon: passwordVisibility
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onPressed: _changePasswordVisibility,
                    textInputAction: TextInputAction.next,
                  ),
                  CustomPasswordField(
                    nameController: _passwordAgainController,
                    obscureText: !passwordAgainVisibility,
                    suffixIcon: passwordAgainVisibility
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onPressed: _changePassworAgaindVisibility,
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),
              ButtonLarge(
                onPressed: _register,
                buttonsText: ProjectText.registerButton,
              ),
              AuthTextButton(
                onPressed: () {
                  navigateTo(context, const LoginView());
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
      showCustomSnackBar(context, ProjectText.warningEmptyInput);
      return;
    }
    if (password != passwordAgain) {
      showCustomSnackBar(context, ProjectText.warningPasswordControll);
      return;
    }

    final user = await _registerModel.register(email, password, displayName);

    if (user != null) {
      //* kayit basarili, mesaj goster ve yonlendir:
      // ignore: use_build_context_synchronously
      showCustomSnackBar(context, ProjectText.successRegister);
      // ignore: use_build_context_synchronously
      navigateReplacementTo(context, const HomeView());
    } else {
      // Kayıt hatası
      // ignore: use_build_context_synchronously
      showCustomSnackBar(context, ProjectText.failedRegister);
    }
  }
}
