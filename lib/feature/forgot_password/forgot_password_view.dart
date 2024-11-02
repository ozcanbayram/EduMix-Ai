import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/enums/image_enum.dart';
import 'package:edumix/product/methods/project_general_methods.dart';
import 'package:edumix/product/services/auth_service.dart';
import 'package:edumix/product/widgets/button_large.dart';
import 'package:edumix/product/widgets/custom_text_field.dart';
import 'package:edumix/product/widgets/description_texts.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final AuthService _authService = AuthService(); // AuthService örneği

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ProjectText.appName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const PagePadding.all(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildForgotImage(context),
              const MainDescriptionWidget(text: ProjectText.forgotPassword),
              CustomEmailField(nameController: _emailController),
              _buildSendButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForgotImage(BuildContext context) {
    return Padding(
      padding: context.padding.medium,
      child: ImageEnums.forgot.toImage,
    );
  }

  Widget _buildSendButton() {
    return ButtonLarge(
      onPressed: _resetPassword,
      buttonsText: ProjectText.sendEmail,
    );
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      showCustomSnackBar(context, ProjectText.warningEmptyEmail);
      return;
    }

    await _authService.resetPassword(email);
    // Şifre sıfırlama bağlantısı gönderildi mesajını göster
    showCustomSnackBar(context, ProjectText.sendedResetPasswordConnection);
    Navigator.pop(context); // Kullanıcıyı bir önceki sayfaya yönlendir
  }
}
