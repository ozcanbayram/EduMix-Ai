import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:edumix/core/constants/widget_sizes.dart';
import 'package:edumix/core/enums/image_enum.dart';
import 'package:edumix/product/services/auth_service.dart';
import 'package:edumix/product/widgets/button_large.dart';
import 'package:edumix/product/widgets/custom_text_field.dart';
import 'package:edumix/product/widgets/page_padding.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
              Padding(
                padding: context.padding.medium,
                child: ImageEnums.forgot.toImage,
              ),
              Text(
                textAlign: TextAlign.center,
                'E-posta adresine parolanı yenilemen \niçin bir bağlantı göndereceğiz.',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ColorItems.project_text_color,
                      fontWeight: FontWeight.bold,
                      fontSize: WidgetSizes.normalDescriptionSize,
                    ),
              ),
              CustomTextField(
                nameController: _emailController,
                prefixIcon: const Icon(Icons.email),
                textInputAction: TextInputAction.done,
                labelText: 'E-posta',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ButtonLarge(onPressed: _resetPassword, buttonsText: 'sifirla'),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showSnackBar('E-posta adresi boş olamaz.');
      return;
    }

    await _authService.resetPassword(email);
    _showSnackBar('Parola sıfırlama e-postası gönderildi.');
    Navigator.pop(context); // Kullanıcıyı bir önceki sayfaya yönlendir
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
