import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:l_sha_a/controller/auth/signin_cubit.dart';
import 'package:l_sha_a/view/auth/widget/app_button.dart';
import 'package:l_sha_a/view/auth/widget/app_textform.dart';

class SigninBody extends StatelessWidget {
  const SigninBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SigninCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assset/images/logo2.jpeg", height: 250.h, width: 250.w),
          SizedBox(height: 60),
          AppTextform(
            hint: "البريد الاكتروني",
            icon: Icons.person,
            controller: cubit.emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "هذا الحقل لا يجب أن يكون فارغًا";
              }
              return null;
            },
          ),
          SizedBox(height: 30),
          AppTextform(
            hint: "كلمه المرور",
            icon: Icons.lock,
            controller: cubit.passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "هذا الحقل لا يجب أن يكون فارغًا;";
              }
              return null;
            },
          ),
          SizedBox(height: 30),
          AppButton(
            title: "تسجيل الدخول",
            onPressed: () {
              cubit.emitSignInStates();
            },
          ),
        ],
      ),
    );
  }
}
