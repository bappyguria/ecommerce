abstract class AddCartEvent {}
class AddToCartEvent extends AddCartEvent {
  final String productId;
  
  AddToCartEvent({
    required this.productId,
  });
}