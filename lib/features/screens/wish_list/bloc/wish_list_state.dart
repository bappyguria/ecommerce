abstract class WishListState {}

class WishListInitial extends WishListState {}
class WishListLoading extends WishListState {}
class WishListLoaded extends WishListState {
  final List<String> wishListItems;

  WishListLoaded(this.wishListItems);
}
class WishListError extends WishListState {
  final String message;

  WishListError(this.message);
}

class AddToWishListSuccess extends WishListState {
  final String message;

  AddToWishListSuccess(this.message);
}
class AddToWishListError extends WishListState {
  final String message;

  AddToWishListError(this.message);
}