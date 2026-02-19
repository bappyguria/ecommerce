class Product {
  String? id;
  String? title;
  Brand? brand;
  List<Category>? categories;
  String? slug;
  String? metaDescription;
  String? description;
  List<String>? photos;
  List<String>? colors;
  List<String>? sizes;
  List<String>? tags;
  int? regularPrice;
  int? currentPrice;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      title: json['title'],
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      categories: json['categories'] != null
          ? List<Category>.from(
              json['categories'].map((x) => Category.fromJson(x)))
          : [],
      slug: json['slug'],
      metaDescription: json['meta_description'],
      description: json['description'],
      photos: json['photos'] != null
          ? List<String>.from(json['photos'])
          : [],
      colors: json['colors'] != null
          ? List<String>.from(json['colors'])
          : [],
      sizes: json['sizes'] != null
          ? List<String>.from(json['sizes'])
          : [],
      tags: json['tags'] != null
          ? List<String>.from(json['tags'])
          : [],
      regularPrice: json['regular_price'],
      currentPrice: json['current_price'],
      quantity: json['quantity'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
class Brand {
  String? id;
  String? title;
  String? slug;
  String? icon;

  Brand({
    this.id,
    this.title,
    this.slug,
    this.icon,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['_id'],
      title: json['title'],
      slug: json['slug'],
      icon: json['icon'],
    );
  }
}

class Category {
  String? id;
  String? title;
  String? slug;
  String? icon;

  Category({
    this.id,
    this.title,
    this.slug,
    this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      title: json['title'],
      slug: json['slug'],
      icon: json['icon'],
    );
  }
}
