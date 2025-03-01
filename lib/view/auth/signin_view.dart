import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_sha_a/controller/auth/signin_cubit.dart';
import 'package:l_sha_a/controller/home/home_cubit.dart';
import 'package:l_sha_a/core/app_route.dart';
import 'package:l_sha_a/core/dialog.dart';
import 'package:l_sha_a/view/auth/widget/signin_body.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: BlocListener<SigninCubit, SigninState>(
                listener: (context, state) {
                  if (state is SigninFailedState) {
                    Navigator.pop(context);
                    errorDialog(context, state.errorMessage);
                  }
                  if (state is SigninLoadingState) {
                    loadingDialog(context);
                  }
                  if (state is SigninSuccessState) {
                    Navigator.pop(context);
                    context.read<HomeCubit>().email =
                        context.read<SigninCubit>().emailController.text;
                    Navigator.of(context).pushReplacementNamed(
                        AppRoutes.homeView,
                        arguments:
                            context.read<SigninCubit>().emailController.text);
                  }
                },
                child: SigninBody()),
          ),
        ),
      ),
    );
  }
}
