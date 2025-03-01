import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:l_sha_a/controller/home/home_cubit.dart';
import 'package:l_sha_a/core/app_colors.dart';
import 'package:l_sha_a/core/app_route.dart';
import 'package:l_sha_a/core/app_styles.dart';
import 'package:l_sha_a/core/dialog.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget(
      {super.key,
      required this.title,
      required this.body,
      required this.email});
  final String title;
  final Widget body;
  final String email;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: AppStyles.font20WhiteMEdiam,
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          iconTheme: IconThemeData(
            size: 24.sp,
            color: Colors.white,
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: AppColors.primary),
                accountName: Text(
                  email,
                  style: AppStyles.font18WhiteRegular,
                ),
                accountEmail: null,
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: AppColors.primary),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("الصفحة الرئيسية"),
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.homeView);
                },
              ),
              BlocListener<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is LogoutLoadingState) {
                    loadingDialog(context);
                  } else if (state is LogoutFailedState) {
                    Navigator.pop(context);

                    errorDialog(context, state.errorMessage);
                  } else if (state is LogoutSuccessState) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutes.singinView, (Route<dynamic> route) => false);
                  }
                },
                child: ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    "تسجيل الخروج",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    showLogoutDialog(context, () {
                      cubit.emitlogoutStates();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        body: body);
  }
}

void showLogoutDialog(BuildContext context, Function onConfirm) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("تأكيد تسجيل الخروج"),
      content: const Text("هل أنت متأكد أنك تريد تسجيل الخروج؟"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // إغلاق الـ Dialog
          child: const Text("لا"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // إغلاق الـ Dialog
            onConfirm(); // تنفيذ عملية تسجيل الخروج
          },
          child: const Text("نعم"),
        ),
      ],
    ),
  );
}
