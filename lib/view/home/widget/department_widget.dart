import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:l_sha_a/core/app_colors.dart';
import 'package:l_sha_a/core/app_route.dart';
import 'package:l_sha_a/core/app_styles.dart';
import 'package:l_sha_a/data/repo/department_data.dart';

class DepartmentWidget extends StatelessWidget {
  const DepartmentWidget({super.key, required this.departmentIndex});
  final int departmentIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (departmentIndex == 0) {
          Navigator.pushNamed(context, AppRoutes.departmentView,
              arguments: departmentIndex);
        }
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
                child: Text(
                    DepartmentData.departmenstList[departmentIndex].name,
                    style: AppStyles.font18blackRegular),
              ),
            )
          ],
        ),
      ),
    );
  }
}
