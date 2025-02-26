import 'package:flutter/material.dart';
import 'package:l_sha_a/core/app_colors.dart';
import 'package:l_sha_a/core/app_styles.dart';

class AppTextform extends StatelessWidget {
  const AppTextform({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    this.validator,
  });

  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // اتجاه النص كله عربي
      child: TextFormField(
        textAlign: TextAlign.right,
        cursorColor: Colors.white,
        controller: controller,
        validator: validator,
        style: AppStyles.font18WhiteRegular,
        decoration: InputDecoration(
          fillColor: AppColors.primary,
          filled: true,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: AppStyles.font18WhiteLightRegular,
          prefixIcon: Icon(icon, color: AppColors.white),
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
