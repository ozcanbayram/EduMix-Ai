import 'package:edumix/core/constants/color_items.dart';
import 'package:edumix/core/constants/project_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomPasswordField extends StatelessWidget {
  const CustomPasswordField({
    required TextEditingController nameController,
    // required this.prefixIcon,
    required this.textInputAction,
    required this.onPressed,
    this.obscureText = false, // İsteğe bağlı olarak ekleyin
    super.key,
    this.suffixIcon = const Icon(Icons.key),
  }) : _nameController = nameController;

  final TextEditingController _nameController;
  final Icon suffixIcon;
  final TextInputAction textInputAction;
  final bool obscureText; // Yeni parametre

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.normal,
      child: TextField(
        style: const TextStyle(
          color: ColorItems.project_second_text_color,
          fontWeight: FontWeight.w500,
        ),
        textInputAction: textInputAction,
        keyboardType: TextInputType.text,
        controller: _nameController,
        cursorColor: ColorItems.project_blue,
        obscureText: obscureText, // Burada kullanın
        decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: onPressed, icon: suffixIcon),
          prefixIcon: const Icon(Icons.lock),
          filled: true,
          fillColor: ColorItems.project_white,
          labelText: ProjectText.password,
          labelStyle: const TextStyle(
            color: ColorItems.project_text_color,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorItems.project_second_text_color,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorItems.project_second_text_color,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorItems.project_second_text_color,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomEmailField extends StatelessWidget {
  const CustomEmailField({
    required TextEditingController nameController,
    super.key,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.normal,
      child: TextField(
        style: const TextStyle(
          color: ColorItems.project_second_text_color,
          fontWeight: FontWeight.w500,
        ),
        textInputAction: TextInputAction.next, //!
        keyboardType: TextInputType.emailAddress, //!
        controller: _nameController,
        cursorColor: ColorItems.project_blue,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          filled: true,
          fillColor: ColorItems.project_white,
          labelText: ProjectText.email,
          labelStyle: const TextStyle(
            color: ColorItems.project_text_color,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorItems.project_second_text_color,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorItems.project_second_text_color,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorItems.project_second_text_color,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomNameField extends StatelessWidget {
  const CustomNameField({
    required TextEditingController nameController,
    super.key,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.normal,
      child: TextField(
        style: const TextStyle(
          color: ColorItems.project_second_text_color,
          fontWeight: FontWeight.w500,
        ),
        textInputAction: TextInputAction.next, //!
        keyboardType: TextInputType.emailAddress, //!
        controller: _nameController,
        cursorColor: ColorItems.project_blue,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          filled: true,
          fillColor: ColorItems.project_white,
          labelText: ProjectText.name,
          labelStyle: const TextStyle(
            color: ColorItems.project_text_color,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorItems.project_second_text_color,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorItems.project_second_text_color,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: ColorItems.project_second_text_color,
            ),
          ),
        ),
      ),
    );
  }
}
