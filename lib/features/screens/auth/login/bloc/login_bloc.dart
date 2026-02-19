
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/api_client.dart';
import 'login_event.dart';
import 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnPressLoginButton>((event, emit) async {
      emit(LoginLoading());
      try{
        final userData = await ApiService.login(email: event.email, password: event.password);
        emit(LoginSuccess(userData: userData));
      }catch(e){
        emit(LoginError(message: e.toString()));
      }
      
    });
  }
}
