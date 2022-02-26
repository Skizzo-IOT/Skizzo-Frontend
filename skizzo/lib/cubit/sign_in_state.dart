part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInLoaded extends SignInState {}

class SignInInvalidUserError extends SignInState {
  final String message;
  SignInInvalidUserError(this.message);
}

class SignInError extends SignInState {
  final String message;
  SignInError(this.message);
}