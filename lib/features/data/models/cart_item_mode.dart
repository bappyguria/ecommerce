class CartItemModel {
  String? id;
  int? quantity;
  String? color;
  String? size;
  CartProduct? product;

  CartItemModel({
    this.id,
    this.quantity,
    this.color,
    this.size,
    this.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['_id'],
      quantity: json['quantity'] ?? 1,
      color: json['color'],
      size: json['size'],
      product: json['product'] != null
          ? CartProduct.fromJson(json['product'])
          : null,
    );
  }
}

class CartProduct {
  String? id;
  String? title;
  String? description;
  List<String>? photos;
  int? currentPrice;
  int? regularPrice;

  CartProduct({
    this.id,
    this.title,
    this.description,
    this.photos,
    this.currentPrice,
    this.regularPrice,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      photos: json['photos'] != null
          ? List<String>.from(json['photos'])
          : [],
      currentPrice: json['current_price'],
      regularPrice: json['regular_price'],
    );
  }
}