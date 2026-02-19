

import '../../../../data/models/product_model.dart';

abstract class ProductListState {}
class ProductListInitial extends ProductListState {}
class ProductListLodding extends ProductListState {}
class LodedProductList extends ProductListState {
  final List<Product> productList;

  LodedProductList(this.productList);
}

class ProductListError extends ProductListState {
  final String message;

  ProductListError(this.message);
}
