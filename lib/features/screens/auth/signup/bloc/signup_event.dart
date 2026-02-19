abstract class SignUpEvent {}

class SubmitSignUp extends SignUpEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String city;
  final String password;

  SubmitSignUp({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.city,
    required this.password,
  });
}
