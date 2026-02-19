
import 'package:ecommerceapp/features/screens/auth/pin/bloc/pin_event.dart';
import 'package:ecommerceapp/features/screens/auth/pin/bloc/pin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/api_client.dart';


class PinVerificationBloc extends Bloc<PinVerificationEvent, PinVerificationState> {
  PinVerificationBloc() : super(PinVerificationInitial()) {
    on<SubmitPinVerification>((event, emit) async {
      emit(PinVerificationLoading());

      try {
        // 👉 API CALL HERE
        final response = await ApiService.verifyPin(
          email: event.email,
          pinCode: event.pinCode,
        );
        emit(PinVerificationSuccess(response['msg']?.toString() ?? 'Pin verification successful'));
        emit(PinVerificationError(response['msg']?.toString() ?? 'Pin verification failed'));
      } catch (e) {
        emit(
          PinVerificationError(
            e.toString().replaceAll('Exception:', '').trim(),
          ),
        );
      }
    });
  }
}
