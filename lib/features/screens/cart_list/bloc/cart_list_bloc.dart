import 'package:ecommerceapp/core/network/api_client.dart';
import 'package:ecommerceapp/features/screens/cart_list/bloc/cart_list_event.dart';
import 'package:ecommerceapp/features/screens/cart_list/bloc/cart_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListBloc extends Bloc<CartListEvent, CartListState> {

  CartListBloc() : super(CartListInitial()) {

    on<LoadCartList>(_onLoadCartList);
    on<RemoveCartItem>(_onRemoveCartItem);
  }

  /// LOAD CART
  Future<void> _onLoadCartList(
    LoadCartList event,
    Emitter<CartListState> emit,
  ) async {

    emit(CartListLoading());

    try {
      final cartItems = await ApiService.getCartList();
      emit(CartListLoaded(cartItems));
    } catch (e) {
      emit(CartListError(e.toString()));
    }
  }

  /// REMOVE ITEM
  Future<void> _onRemoveCartItem(
    RemoveCartItem event,
    Emitter<CartListState> emit,
  ) async {

    if (state is CartListLoaded) {

      final currentState = state as CartListLoaded;

      try {

        await ApiService.removeCartItem(event.cartItemId);

        final updatedList = currentState.cartItems
            .where((item) => item.id != event.cartItemId)
            .toList();

        emit(CartListLoaded(updatedList));
       

      } catch (e) {
        emit(CartListError(e.toString()));
      }

    }
  }
}