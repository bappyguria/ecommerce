import 'package:ecommerceapp/core/network/api_client.dart';
import 'package:ecommerceapp/features/screens/add_cart/add_cart_event.dart';
import 'package:ecommerceapp/features/screens/add_cart/add_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCartBloc extends Bloc<AddCartEvent, AddCartState> {
  AddCartBloc() : super(AddCartInitial()) {
    on<AddToCartEvent>((event, emit) async {
      emit(AddCartLoading());

      try {
        final response = await ApiService.addToCart(productId: event.productId);
        emit(AddCartSuccess(response));
      } catch (e) {
        emit(AddCartFailure(e.toString()));
      }
    });
  }
}