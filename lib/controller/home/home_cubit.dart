import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:l_sha_a/core/app_route.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
//  DepartmentData departmentData = DepartmentData();
  String? email;
  List<String> departmentNames = [
    'علوم حساب',
    "نظم المعلومات",
    "المجالات",
    "الادارة والماحسبة",
    "كل الاقسام",
    "المقالات"
  ];
  String? errorLogMessage;
  String? cuurentDepartment;
  String? cuurentMaterila;
  selectDepartment(String text, BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.departmentView);
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      errorLogMessage = "Error logging out: $e";
    }
  }

  Future<void> emitlogoutStates() async {
    emit(LogoutLoadingState());

    await logout();
    if (errorLogMessage == null) {
      emit(LogoutSuccessState());
    } else {
      emit(LogoutFailedState(
        errorMessage:
            errorLogMessage ?? "حدث خطأ غير معروف. يرجى المحاولة مرة أخرى",
      ));
    }
  }
}
