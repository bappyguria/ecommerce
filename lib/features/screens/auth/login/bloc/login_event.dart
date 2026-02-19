class LoginEvent {}
 class OnPressLoginButton extends LoginEvent {
  final String email;
  final String password;

  OnPressLoginButton({required this.email, required this.password});
}