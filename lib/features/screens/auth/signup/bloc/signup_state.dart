abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  String message;
  SignUpSuccess(this.message);
}

class SignUpError extends SignUpState {
  final String message;
  SignUpError(this.message);
}
