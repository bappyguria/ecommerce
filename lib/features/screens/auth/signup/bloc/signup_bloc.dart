import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/api_client.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SubmitSignUp>((event, emit) async {
      emit(SignUpLoading());

      try {
        // 👉 API CALL HERE
        final response = await ApiService.signUp(
          firstName: event.firstName.trim(),
          lastName: event.lastName.trim(),
          email: event.email.trim(),
          phone: event.phone.trim(),
          city: event.city.trim(),
          password: event.password,
        );

        emit(
          SignUpSuccess(
            response['msg']?.toString() ?? 'Signup successful',
          ),
        );
      } catch (e) {
        emit(
          SignUpError(
            e.toString().replaceAll('Exception:', '').trim(),
          ),
        );
      }
    });
  }
}
