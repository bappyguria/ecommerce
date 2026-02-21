abstract class ProductDetalsEvent {}
class GetProductDetails extends ProductDetalsEvent {
  final String productId;

  GetProductDetails(this.productId);
}