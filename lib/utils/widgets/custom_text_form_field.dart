import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unilever_driver/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.onTap,
    this.autovalidateMode,
    this.obscureText,
    this.onChanged,
    this.filled,
    this.inputFormatters,
    this.hint,
    this.hintColor,
    this.hintFontSize,
    this.maxLines,
    this.keyboardType,
    this.errorTextColor,
    this.textColor,
    this.prefixIcon,
    this.validator,
  });

  final VoidCallback? onTap;
  final Function(String? value)? onChanged;
  final String? Function(String? value)? validator;
  final TextEditingController controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final bool? filled;
  final Color? textColor;
  final Color? errorTextColor;

  final String? hint;
  final Color? hintColor;
  final double? hintFontSize;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;

  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap ?? () {},
      onChanged: onChanged ?? (v) {},
      validator: validator,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      maxLines: obscureText == null ? maxLines : 1,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: hintColor,
          fontSize: hintFontSize,
        ),
        isDense: true,
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: const OutlineInputBorder(),
        filled: filled,
        fillColor: AppColors.white,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white,
          ),
        ),
        errorStyle: TextStyle(
          fontSize: 15,
          color: errorTextColor ?? AppColors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: textColor ?? AppColors.black,
      ),
      obscuringCharacter: "•",
    );
  }
}
