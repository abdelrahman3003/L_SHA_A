import 'package:flutter/material.dart';
import 'package:l_sha_a/view/home/widget/department_widget.dart';

class AllDepartment extends StatelessWidget {
  const AllDepartment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
          itemCount: 6,
          itemBuilder: (context, index) =>
              DepartmentWidget(departmentIndex: index),
        ));
  }
}
