import 'package:ecommerceapp/features/data/models/profile_model.dart';

abstract class ProfileState {}
class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final ProfileModel profileData;

  ProfileLoaded(this.profileData);
}
class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class ProfileUpdatingLoading extends ProfileState {}
class ProfileUpdated extends ProfileState {
  final ProfileModel updatedProfile;

  ProfileUpdated(this.updatedProfile);
}
class ProfileUpdatingError extends ProfileState {
  final String message;

  ProfileUpdatingError(this.message);
}