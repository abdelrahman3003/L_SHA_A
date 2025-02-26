import 'package:flutter/material.dart';
import 'package:l_sha_a/core/app_colors.dart';
import 'package:l_sha_a/core/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.title, this.onPressed});
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(title, style: AppStyles.font18WhiteRegular),
    );
  }
}
