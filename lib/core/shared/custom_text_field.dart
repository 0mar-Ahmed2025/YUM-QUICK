import 'package:flutter/material.dart';
import 'package:yum_quick/core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.lableText,
    required this.textFieldName,
    this.keyboardType,
  });

  final TextEditingController controller;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? lableText;
  final String textFieldName;
  final TextInputType? keyboardType;

  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textFieldName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            // color: textColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          validator: validator,
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
            filled: true,
            fillColor: AppColors.textField,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none, // إزالة الحدود كما في التصميم
            ),
            enabledBorder: borderBuilder(),
            focusedBorder: borderBuilder(),
            focusedErrorBorder: borderBuilder(),
            errorBorder: borderBuilder(),
          ),
        ),
      ],
    );
  }

  InputBorder borderBuilder({Color color = AppColors.lightYellow}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
      // إزالة الحدود كما في التصميم
    );
  }
}
