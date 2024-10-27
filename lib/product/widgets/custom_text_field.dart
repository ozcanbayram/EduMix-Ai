import 'package:edumix/core/constants/color_items.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required TextEditingController nameController,
    required this.prefixIcon,
    required this.textInputAction,
    required this.labelText,
    required this.keyboardType,
    this.obscureText = false, // İsteğe bağlı olarak ekleyin
    super.key,
    this.suffixIcon,
  }) : _nameController = nameController;

  final TextEditingController _nameController;
  final Icon prefixIcon;
  final IconButton? suffixIcon;
  final TextInputAction textInputAction;
  final String labelText;
  final bool obscureText; // Yeni parametre
  final TextInputType keyboardType;

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
        keyboardType: keyboardType,
        controller: _nameController,
        cursorColor: ColorItems.project_blue,
        obscureText: obscureText, // Burada kullanın
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: ColorItems.project_white,
          labelText: labelText,
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
