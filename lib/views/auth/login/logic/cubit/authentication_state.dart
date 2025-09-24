part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class LoginSuccess extends AuthenticationState {}

final class LoginLoading extends AuthenticationState {}

final class LoginFailure extends AuthenticationState {
  final String message;
  LoginFailure(this.message);
}

final class SignUpSuccess extends AuthenticationState {}

final class SignUpLoading extends AuthenticationState {}

final class SignUpFailure extends AuthenticationState {
  final String message;
  SignUpFailure({required this.message});
}
