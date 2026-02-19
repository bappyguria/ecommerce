class CategoryModel {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String icon;
  final String? parent;
  final String createdAt;
  final String updatedAt;
  final int version;

  CategoryModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.icon,
    this.parent,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  /// 🔹 JSON → Model
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
      parent: json['parent'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      version: json['__v'] ?? 0,
    );
  }

  /// 🔹 Model → JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'icon': icon,
      'parent': parent,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': version,
    };
  }
}
