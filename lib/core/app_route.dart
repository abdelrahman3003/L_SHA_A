import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_sha_a/controller/auth/signin_cubit.dart';
import 'package:l_sha_a/view/auth/signin_view.dart';
import 'package:l_sha_a/view/home/home_view.dart';

class AppRoutes {
  static const String singinView = '/singinView';
  static const String homeView = '/homepage';

  static Route generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case singinView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SigninCubit>.value(
            value: SigninCubit(),
            child: const SigninView(),
          ),
        );
      case homeView:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("No route defind for ${setting.name}"),
            ),
          ),
        );
    }
  }
}
