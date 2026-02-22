abstract class ProfileEvent {}
class GetProfile extends ProfileEvent {}
class UpdateProfile extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String city;
  final String phone;

  UpdateProfile({required this.firstName, required this.lastName, required this.city, required this.phone});
}