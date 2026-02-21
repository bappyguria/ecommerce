import 'package:ecommerceapp/features/data/models/product_model.dart';

abstract class ProductDetalsState {}
class ProductDetalsInitial extends ProductDetalsState {}
class ProductDetalsLoading extends ProductDetalsState {}
class ProductDetalsLoaded extends ProductDetalsState {
  final Product product;

  ProductDetalsLoaded(this.product);
}
class ProductDetalsError extends ProductDetalsState {
  final String message;

  ProductDetalsError(this.message);
}