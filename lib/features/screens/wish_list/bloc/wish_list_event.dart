abstract class WishListEvent {}
class GetWishList extends WishListEvent {
  final String productId;

  GetWishList(this.productId);
}
class AddToWishList extends WishListEvent {
  final String productId;

  AddToWishList(this.productId);
}
