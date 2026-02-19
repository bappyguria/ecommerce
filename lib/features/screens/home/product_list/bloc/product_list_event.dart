abstract class ProductListEvent {}
class FetchProductsListByCategoryId extends ProductListEvent {
  final String categoryId;

  FetchProductsListByCategoryId(this.categoryId);
}