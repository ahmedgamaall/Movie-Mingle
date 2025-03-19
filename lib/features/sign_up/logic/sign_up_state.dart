import 'package:movie_mingle/features/login/data/models/login_response.dart';

abstract class SignupState {}

class InitState extends SignupState {}

class LoadingSignupState extends SignupState {}

class SuccessSignupState extends SignupState {
  final LoginResponse response;

  SuccessSignupState({required this.response});
}

class ErrorSignupState extends SignupState {
  final String message;

  ErrorSignupState({required this.message});
}
