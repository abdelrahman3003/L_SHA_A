import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_sha_a/controller/home/home_cubit.dart';
import 'package:l_sha_a/data/repo/department_data.dart';
import 'package:l_sha_a/view/home/home/widget/department_widget.dart';
import 'package:l_sha_a/view/home/home/widget/home_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HomeWidget(
        title: "الرئيسية",
        email: context.read<HomeCubit>().email!,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
              itemCount: DepartmentData.departmenstList.length,
              itemBuilder: (context, index) =>
                  DepartmentWidget(departmentIndex: index),
            )));
  }
}
