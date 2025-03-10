import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:l_sha_a/controller/home/home_cubit.dart';
import 'package:l_sha_a/core/app_colors.dart';
import 'package:l_sha_a/core/app_route.dart';
import 'package:l_sha_a/core/app_styles.dart';
import 'package:l_sha_a/core/constatnt.dart';

class DepartmentWidget extends StatelessWidget {
  const DepartmentWidget({super.key, required this.departmentIndex});
  final int departmentIndex;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return GestureDetector(
      onTap: () {
        Constatnt.cuurentDepartment = cubit.departmentNames[departmentIndex];

        Navigator.pushNamed(context, AppRoutes.departmentView);
      },
      child: Container(
        height: 190,
        width: 190,
        padding: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
            color: AppColors.greyLight,
            borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                "assset/images/logo.png",
              ),
            ),
            Flexible(
              child: FittedBox(
                child: Text(cubit.departmentNames[departmentIndex],
                    style: AppStyles.font18blackRegular),
              ),
            )
          ],
        ),
      ),
    );
  }
}
