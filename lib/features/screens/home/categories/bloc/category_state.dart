

import '../../../../data/models/category_model.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  final bool hasMore;
  final bool isLoadingMore;

  CategoryLoaded(this.categories, this.hasMore, {this.isLoadingMore = false});
}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}
