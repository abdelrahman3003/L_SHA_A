import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_sha_a/controller/department/department_cubit.dart';
import 'package:l_sha_a/controller/home/home_cubit.dart';
import 'package:l_sha_a/data/repo/department_data.dart';
import 'package:l_sha_a/view/home/widget/home_widget.dart';

class DepartmentView extends StatelessWidget {
  const DepartmentView({super.key, required this.departmentIndex});
  final int departmentIndex;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DepartmentCubit>();

    return HomeWidget(
        title: DepartmentData.departmenstList[departmentIndex].name,
        email: context.read<HomeCubit>().email ?? "abdo",
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: DepartmentData
                  .departmenstList[departmentIndex].subjects.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      DepartmentData.departmenstList[departmentIndex]
                          .subjects[index].name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(Icons.book, color: Colors.blue),
                    onTap: () {
                      if (index == 0 || index == 1) {
                        cubit.launchPdf(DepartmentData
                            .departmenstList[index].subjects[index].pdfUrl);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ));
  }
}
