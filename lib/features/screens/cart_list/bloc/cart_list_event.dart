abstract class CartListEvent {}
class LoadCartList extends CartListEvent {
  
}
class RemoveCartItem extends CartListEvent {
  final String cartItemId;

  RemoveCartItem(this.cartItemId);
}