import 'package:ecommerceapp/features/data/models/cart_item_mode.dart';

abstract class CartListState {}
class CartListInitial extends CartListState {}
class CartListLoading extends CartListState {}
class CartListLoaded extends CartListState {
  final List<CartItemModel> cartItems;

  CartListLoaded(this.cartItems);
}
class CartListError extends CartListState {
  final String message;

  CartListError(this.message);  
}