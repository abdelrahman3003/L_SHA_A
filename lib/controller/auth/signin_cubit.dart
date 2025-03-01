import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SigninInitial()) {
    inilaData();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  String? errorMessage;
  String? errorLogMessage;

  late TextEditingController emailController;
  late TextEditingController passwordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  inilaData() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> signInWithEmail() async {
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      log("تم تسجيل الدخول بنجاح: ${userCredential!.user?.email}");
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException: ${e.code}");
      switch (e.code) {
        case 'network-request-failed':
          errorMessage =
              "لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة والمحاولة مرة أخرى";
          break;
        case 'invalid-credential':
          errorMessage = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
          break;
        case 'invalid-email':
          errorMessage = "صيغة البريد الإلكتروني غير صحيحة";
          break;
        case 'user-not-found':
          errorMessage = "لم يتم العثور على مستخدم بهذا البريد الإلكتروني";
          break;
        case 'wrong-password':
          errorMessage = "كلمة المرور غير صحيحة";
          break;
        default:
          errorMessage = e.message ?? "حدث خطأ غير متوقع. حاول مرة أخرى";
          break;
      }
    } catch (e) {
      log("Unknown exception: $e");
      errorMessage = "حدث خطأ غير متوقع. حاول مرة أخرى";
    }
  }

  Future<void> emitSignInStates() async {
    if (formKey.currentState!.validate()) {
      emit(SigninLoadingState());
      await signInWithEmail();
      if (userCredential != null) {
        emit(SigninSuccessState());
      } else {
        emit(SigninFailedState(
          errorMessage:
              errorMessage ?? "An unknown error occurred. Please try again.",
        ));
      }
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
