class WishItemModel {
  final String? id;
  final WishProduct? product;
  final String? user;
  final String? createdAt;
  final String? updatedAt;

  WishItemModel({
    this.id,
    this.product,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  factory WishItemModel.fromJson(Map<String, dynamic> json) {
    return WishItemModel(
      id: json['_id'] ,
      product: json['product'] != null
          ? WishProduct.fromJson(json['product'])
          : null,
      user: json['user'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class WishProduct {
  final String? id;
  final String? title;
  final String? brand;
  final List<String>? categories;
  final String? slug;
  final String? metaDescription;
  final String? description;
  final List<String>? photos;
  final List<String>? colors;
  final List<String>? sizes;
  final List<String>? tags;
  final int? regularPrice;
  final int? currentPrice;
  final int? quantity;
  final String? createdAt;
  final String? updatedAt;

  WishProduct({
    this.id,
    this.title,
    this.brand,
    this.categories,
    this.slug,
    this.metaDescription,
    this.description,
    this.photos,
    this.colors,
    this.sizes,
    this.tags,
    this.regularPrice,
    this.currentPrice,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  factory WishProduct.fromJson(Map<String, dynamic> json) {
    return WishProduct(
      id: json['_id'],
      title: json['title'],
      brand: json['brand'],
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : [],
      slug: json['slug'],
      metaDescription: json['meta_description'],
      description: json['description'],
      photos: json['photos'] != null ? List<String>.from(json['photos']) : [],
      colors: json['colors'] != null ? List<String>.from(json['colors']) : [],
      sizes: json['sizes'] != null ? List<String>.from(json['sizes']) : [],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      regularPrice: json['regular_price'],
      currentPrice: json['current_price'],
      quantity: json['quantity'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
