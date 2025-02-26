import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_sha_a/controller/auth/signin_cubit.dart';
import 'package:l_sha_a/core/app_route.dart';
import 'package:l_sha_a/view/auth/widget/signin_body.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SigninCubit>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: BlocListener<SigninCubit, SigninState>(
                listener: (context, state) {
                  if (state is SigninFailedState) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("خطأ"),
                        content: Text(state.errorMessage),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("حسناً"),
                          )
                        ],
                      ),
                    );
                  }
                  if (state is SigninLoadingState) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const AlertDialog(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 16),
                            Text("جاري تسجيل الدخول..."),
                          ],
                        ),
                      ),
                    );
                    Navigator.of(context).pop();
                  }
                  if (state is SigninSuccessState) {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.homeView);
                  }
                },
                child: SigninBody()),
          ),
        ),
      ),
    );
  }
}
