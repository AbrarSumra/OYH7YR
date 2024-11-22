import 'package:flutter/material.dart';

class KMobileTextField extends StatelessWidget {
  const KMobileTextField({
    super.key,
    this.hintText,
    this.icon,
    this.controller,
    this.maxLength,
    this.maxLines,
    this.suffixIcon,
    this.obscureText = false,
    this.hintTextColor = Colors.grey,
    this.iconColor = Colors.black,
    this.keyboardType = TextInputType.text,
    this.fontColor = Colors.grey,
    this.validator,
    this.onChanged,
  });

  final String? hintText;
  final IconData? icon;
  final IconButton? suffixIcon;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final bool obscureText;
  final Color hintTextColor;
  final Color fontColor;
  final Color iconColor;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(color: fontColor),
      maxLength: maxLength,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: '',
        hintStyle: TextStyle(color: hintTextColor),
        suffixIcon: suffixIcon,
        prefixIcon: Icon(
          icon,
          color: iconColor,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
            width: 2.0,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
            width: 2.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.deepOrange,
            width: 2.0,
          ),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
