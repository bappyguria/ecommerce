import 'package:ecommerceapp/core/network/api_client.dart';
import 'package:ecommerceapp/features/screens/profile/bloc/profile_event.dart';
import 'package:ecommerceapp/features/screens/profile/bloc/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<GetProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final profileData = await ApiService.getProfile();
        emit(ProfileLoaded(profileData));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileUpdatingLoading());
      try {
        final response = await ApiService.updateProfile(
          firstName: event.firstName,
          lastName: event.lastName,
          
          phone: event.phone, city: event.city,
        );

        emit(ProfileUpdated(response));
        
      } catch (e) {
        emit(ProfileUpdatingError(e.toString()));
      }
    });
  }
}