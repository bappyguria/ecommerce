import 'package:ecommerceapp/features/data/models/wish_item.dart';

abstract class WishListState {}

class WishListInitial extends WishListState {}
class WishListLoading extends WishListState {}
class WishListLoaded extends WishListState {
  final List<WishItemModel> wishListItems;
  

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
class RemoveWishItemSuccess extends WishListState {
  final String message;

  RemoveWishItemSuccess(this.message);
}
class RemoveWishItemError extends WishListState {
  final String message;

  RemoveWishItemError(this.message);
}