
import 'package:ecommerceapp/features/screens/home/product_list/bloc/product_list_event.dart';
import 'package:ecommerceapp/features/screens/home/product_list/bloc/product_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/api_client.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial()) {
    on<FetchProductsListByCategoryId>((event, emit) async {
      emit(ProductListLodding());
      try {
        final productsList = await ApiService.getProductListByCategoryId(
          categoryId: event.categoryId,
        );
        emit(LodedProductList(productsList['products']));
      } catch (e) {
        emit(ProductListError(e.toString()));
      }
    });
  }
}
