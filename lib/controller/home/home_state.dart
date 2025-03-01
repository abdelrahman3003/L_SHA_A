part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeChangeTitle extends HomeState {}

final class LogoutLoadingState extends HomeState {}

final class LogoutSuccessState extends HomeState {}

final class LogoutFailedState extends HomeState {
  final String errorMessage;
  LogoutFailedState({required this.errorMessage});
}
