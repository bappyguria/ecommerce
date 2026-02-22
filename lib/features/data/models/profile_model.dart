class ProfileModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? emailVerified;
  final String? phone;
  final bool? phoneVerified;
  final String? avatarUrl;
  final String? city;
  final int? role;
  final String? createdAt;
  final String? updatedAt;

  ProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerified,
    this.phone,
    this.phoneVerified,
    this.avatarUrl,
    this.city,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      emailVerified: json['email_verified'],
      phone: json['phone'],
      phoneVerified: json['phone_verified'],
      avatarUrl: json['avatar_url'],
      city: json['city'],
      role: json['role'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "email_verified": emailVerified,
      "phone": phone,
      "phone_verified": phoneVerified,
      "avatar_url": avatarUrl,
      "city": city,
      "role": role,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}