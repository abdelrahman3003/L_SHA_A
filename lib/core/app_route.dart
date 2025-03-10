import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_sha_a/controller/auth/signin_cubit.dart';
import 'package:l_sha_a/controller/department/department_cubit.dart';
import 'package:l_sha_a/controller/home/home_cubit.dart';
import 'package:l_sha_a/controller/material/material_cubit.dart';
import 'package:l_sha_a/view/auth/signin_view.dart';
import 'package:l_sha_a/view/home/department/department_view.dart';
import 'package:l_sha_a/view/home/home/home_view.dart';
import 'package:l_sha_a/view/home/material/material_view.dart';

class AppRoutes {
  static const String singinView = '/singinView';
  static const String homeView = '/homepage';
  static const String departmentView = '/departmentView';
  static const String materialView = '/materialView';
  static final homeCubit = HomeCubit();
  static Route generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: homeCubit),
              BlocProvider(create: (context) => SigninCubit()),
            ],
            child: const SigninView(),
          ),
        );

      case homeView:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: homeCubit,
            child: HomeView(),
          ),
        );
      case departmentView:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: homeCubit),
                    BlocProvider(create: (context) => DepartmentCubit()),
                  ],
                  child: DepartmentView(),
                ));
      case materialView:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => MaterialCubit(),
                  child: MaterialView(),
                ));

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
