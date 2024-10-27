import 'package:edumix/core/constants/color_items.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required TextEditingController nameController,
    required this.prefixIcon,
    required this.textInputAction,
    required this.labelText,
    super.key,
  }) : _nameController = nameController;

  final TextEditingController _nameController;
  final Icon prefixIcon;
  final TextInputAction textInputAction;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.normal,
      child: TextField(
        style: const TextStyle(
          color: ColorItems.project_second_text_color,
          fontWeight: FontWeight.w500,
        ),
        //* bir sonraki field'a geçmek için ya da tamamlamak için:
        textInputAction: textInputAction,
        //* number, phone ... gibi input ayarları yapılabilir.
        keyboardType: TextInputType.text,
        //* otomotik tamamlama özelliği
        // autofillHints: const [AutofillHints.email],

        controller: _nameController,
        cursorColor: ColorItems.project_blue,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: ColorItems.project_white,

          labelText: labelText,
          labelStyle: const TextStyle(
            color: ColorItems.project_text_color,
            fontWeight: FontWeight.w500,
          ), // labelText rengi
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
