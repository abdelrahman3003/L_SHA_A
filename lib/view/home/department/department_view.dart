import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l_sha_a/controller/department/department_cubit.dart';
import 'package:l_sha_a/controller/home/home_cubit.dart';
import 'package:l_sha_a/core/app_route.dart';
import 'package:l_sha_a/core/constatnt.dart';
import 'package:l_sha_a/view/home/home/widget/home_widget.dart';

class DepartmentView extends StatelessWidget {
  const DepartmentView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<DepartmentCubit>();

    return HomeWidget(
        title: Constatnt.cuurentDepartment!,
        email: context.read<HomeCubit>().email!,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<DepartmentCubit, DepartmentState>(
              builder: (context, state) {
                if (state is DepartmentGetMaterialError) {
                  return Center(child: Text(state.errorMessage));
                }
                if (state is DepartmentGetMaterialLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is DepartmentGetMaterialSuccess) {
                  return materialListView(state.materials);
                }
                return SizedBox();
              },
            ),
          ),
        ));
  }

  materialListView(List<String> materials) {
    return materials.isEmpty
        ? Center(child: Text("لا يوجد مواد حاليا في هذا القسم"))
        : ListView.builder(
            itemCount: materials.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(
                    materials[index],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  leading: const Icon(Icons.book, color: Colors.blue),
                  onTap: () {
                    Constatnt.cuurentMaterial = materials[index];
                    Navigator.pushNamed(context, AppRoutes.materialView);
                  },
                ),
              );
            },
          );
  }
}
