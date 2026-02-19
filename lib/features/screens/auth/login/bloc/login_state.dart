class LoginState {}
 class LoginInitial extends LoginState {}
 class LoginLoading extends LoginState {}
 class LoginSuccess extends LoginState {
  final dynamic userData;

  LoginSuccess({required this.userData});
}
 class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}