import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_sha_a/controller/auth/signin_cubit.dart';
import 'package:l_sha_a/controller/department/department_cubit.dart';
import 'package:l_sha_a/controller/home/home_cubit.dart';
import 'package:l_sha_a/view/auth/signin_view.dart';
import 'package:l_sha_a/view/home/department_view.dart';
import 'package:l_sha_a/view/home/home_view.dart';

class AppRoutes {
  static const String singinView = '/singinView';
  static const String homeView = '/homepage';
  static const String departmentView = '/departmentView';
  static final homeCubit = HomeCubit();
  static Route generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case "/" || singinView:
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
        final int departmentName = setting.arguments as int;
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: homeCubit),
                    BlocProvider(create: (context) => DepartmentCubit()),
                  ],
                  child: DepartmentView(departmentIndex: departmentName),
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
