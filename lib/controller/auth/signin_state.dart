part of 'signin_cubit.dart'; // لازم يكون أول سطر

@immutable
sealed class SigninState {}

final class SigninInitial extends SigninState {}

final class SigninLoadingState extends SigninState {}

final class SigninSuccessState extends SigninState {}

final class SigninFailedState extends SigninState {
  final String errorMessage;
  SigninFailedState({required this.errorMessage});
}
