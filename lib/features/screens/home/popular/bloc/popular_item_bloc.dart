import 'package:ecommerceapp/core/network/api_client.dart';
import 'package:ecommerceapp/features/screens/home/popular/bloc/popular_item_event.dart';
import 'package:ecommerceapp/features/screens/home/popular/bloc/popular_item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularItemBloc extends Bloc<ProductItemEvent, PopularItemState> {
  PopularItemBloc() : super(PopularItemInitial()) {
    on<GetPopularItem>((event, emit) async {
      emit(PopularItemLoading());
      try {
        final item = await ApiService.getPopularItems();
        emit(PopularItemLoaded(item));
      } catch (e) {
        emit(PopularItemError(e.toString()));
      }
    });
  }
}