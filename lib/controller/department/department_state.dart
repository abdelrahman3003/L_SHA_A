part of 'department_cubit.dart';

@immutable
sealed class DepartmentState {}

final class DepartmentInitial extends DepartmentState {}

final class DepartmentGetMaterialLoading extends DepartmentState {}

final class DepartmentGetMaterialSuccess extends DepartmentState {
  final List<String> materials;

  DepartmentGetMaterialSuccess({required this.materials});
}

final class DepartmentGetMaterialError extends DepartmentState {
  final String errorMessage;

  DepartmentGetMaterialError({required this.errorMessage});
}
