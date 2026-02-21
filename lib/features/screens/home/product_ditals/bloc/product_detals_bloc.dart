import 'package:ecommerceapp/core/network/api_client.dart';
import 'package:ecommerceapp/features/screens/home/product_ditals/bloc/product_detals_event.dart';
import 'package:ecommerceapp/features/screens/home/product_ditals/bloc/product_detals_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetalsBloc extends Bloc<ProductDetalsEvent, ProductDetalsState> {
  ProductDetalsBloc() : super(ProductDetalsInitial()) {
    on<GetProductDetails>(_onGetProductDetails);
  }

  Future<void> _onGetProductDetails(GetProductDetails event, Emitter<ProductDetalsState> emit) async {
    emit(ProductDetalsLoading());
    try {

      final product = await ApiService.getProductDetails(
      productId: event.productId,
    );
      emit(ProductDetalsLoaded(product));
      
    } catch (e) {
      emit(ProductDetalsError(e.toString()));
    }
  }
}