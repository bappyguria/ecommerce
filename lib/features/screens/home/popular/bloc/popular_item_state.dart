import 'package:ecommerceapp/features/data/models/product_model.dart';

abstract class PopularItemState {}

class PopularItemInitial extends PopularItemState {}

class PopularItemLoading extends PopularItemState {}

class PopularItemLoaded extends PopularItemState {
  final List<Product> popularItems;

  PopularItemLoaded(this.popularItems);
}

class PopularItemError extends PopularItemState {
  final String message;

  PopularItemError(this.message);
}