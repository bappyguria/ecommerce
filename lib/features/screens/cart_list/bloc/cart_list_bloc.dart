import 'package:ecommerceapp/core/network/api_client.dart';
import 'package:ecommerceapp/features/screens/cart_list/bloc/cart_list_event.dart';
import 'package:ecommerceapp/features/screens/cart_list/bloc/cart_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListBloc extends Bloc<CartListEvent, CartListState> {
  CartListBloc() : super(CartListInitial()) {
    on<LoadCartList>((event, emit) async {
      emit(CartListLoading());
      try {
        final cartItems = await ApiService.getCartList();
        emit(CartListLoaded(cartItems));
      } catch (e) {
        emit(CartListError(e.toString()));
      }
    });
  }
}