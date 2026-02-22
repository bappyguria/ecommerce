import 'package:ecommerceapp/core/network/api_client.dart';
import 'package:ecommerceapp/features/screens/wish_list/bloc/wish_list_event.dart';
import 'package:ecommerceapp/features/screens/wish_list/bloc/wish_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListInitial()) {
    on<GetWishList>((event, emit) async {
      emit(WishListLoading());
      try {
        final wishListItems = await ApiService.getWishList();
        emit(WishListLoaded(wishListItems));
      } catch (e) {
        emit(WishListError(e.toString()));
      }
    });

    on<AddToWishList>((event, emit) async {
      emit(WishListLoading());
      try {
        final productId = event.productId;

        final response = await ApiService.addToWishlist(productId: productId);
        emit(AddToWishListSuccess(response,));
      } catch (e) {
        emit(WishListError(e.toString()));
      }
    });

      on<RemoveWishItem>((event, emit) async {
        emit(WishListLoading());
        try {
          final itemId = event.itemId;
  
          final response = await ApiService.removeFromWishlist(itemId: itemId);
          
          emit(RemoveWishItemSuccess(response));
          if (response.toLowerCase().contains("success")) {
            // Refresh the wishlist after successful removal
            add(GetWishList());
          }
        } catch (e) {
          emit(WishListError(e.toString()));
        }
      });
  }
}
