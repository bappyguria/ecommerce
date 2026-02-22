abstract class WishListEvent {}
class GetWishList extends WishListEvent {
  
}
class AddToWishList extends WishListEvent {
  final String productId;
  

  AddToWishList(this.productId);
}
class RemoveWishItem extends WishListEvent {
  final String itemId;

  RemoveWishItem(this.itemId);
}
