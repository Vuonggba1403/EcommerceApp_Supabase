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
  SignUpFailure(this.message);
}

final class GoogleSignInSuccess extends AuthenticationState {}

final class GoogleSignInLoading extends AuthenticationState {}

final class GoogleSignInFailure extends AuthenticationState {
  final String message;
  GoogleSignInFailure(this.message);
}

final class LogoutLoading extends AuthenticationState {}

final class LogoutSuccess extends AuthenticationState {}

final class LogoutFailure extends AuthenticationState {
  final String message;
  LogoutFailure(this.message);
}

final class PasswordResetLoading extends AuthenticationState {}

final class PasswordResetSuccess extends AuthenticationState {}

final class PasswordResetFailure extends AuthenticationState {
  final String message;
  PasswordResetFailure(this.message);
}

final class UserDataLoading extends AuthenticationState {}

final class UserDataSuccess extends AuthenticationState {}

final class UserDataFailure extends AuthenticationState {}

final class GetUserDataLoading extends AuthenticationState {}

final class GetUserDataSuccess extends AuthenticationState {}

final class GetUserDataFailure extends AuthenticationState {}
