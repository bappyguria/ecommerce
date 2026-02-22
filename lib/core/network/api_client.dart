import 'dart:convert';
import 'package:ecommerceapp/features/data/models/cart_item_mode.dart';
import 'package:ecommerceapp/features/data/models/profile_model.dart';
import 'package:ecommerceapp/features/data/models/wish_item.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../features/data/models/category_model.dart';
import '../../features/data/models/product_model.dart';
import '../storage/hive_service.dart';
import '../utils/url.dart';

class ApiService {
  /// 🔐 SIGN UP
  static Future<Map<String, dynamic>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String city,
    required String password,
  }) async {
    print(
      'Signing up user: $email , Name: $firstName $lastName, Phone: $phone, City: $city, Password: $password,',
    );
    final response = await http.post(
      Uri.parse(Url.signUp),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'city': city,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    } else {
      throw Exception(data['msg'] ?? 'Signup failed');
    }
  }

  //// PROFILE (future)
  static Future<ProfileModel> getProfile() async {
  final box = Hive.box('authBox');
  final token = box.get('token') as String?;

  final response = await http.get(
    Uri.parse(Url.profileShow),
    headers: {
      "token": "$token",
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  );

  final data = jsonDecode(response.body);

  if (response.statusCode == 200) {

    final profile = ProfileModel.fromJson(data['data']);

    // যদি Hive এ save করতে চাও
    await HiveService.saveUser(data['data']);

    return profile;

  } else {
    throw Exception(data['msg'] ?? 'Failed to load profile');
  }
}

//// Update Profile (future)
   static Future<ProfileModel>updateProfile({
     required String firstName,
     required String lastName,
     required String phone,
     required String city,
   })async{
    final box = Hive.box('authBox');
    final token = box.get('token') as String?;
    final response = await http.patch(
      Uri.parse(Url.updatedProfile),
      headers: {
        "token": "$token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        'first_name': firstName,
        'last_name': lastName,
        'phone': phone,
        'city': city,
      }),
    );

    print("Update Profile STATUS: ${response.statusCode}");
    print("Update Profile BODY: ${response.body}");

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // আপডেট হওয়া প্রোফাইল ডেটা থেকে নতুন প্রোফাইল মডেল তৈরি করুন
      final updatedProfile = ProfileModel.fromJson(data['data']);

      // Hive এ আপডেট হওয়া প্রোফাইল ডেটা সেভ করুন
      await HiveService.saveUser(data['data']);

      return updatedProfile;
    } else {
      throw Exception(data['msg'] ?? 'Failed to update profile');
    }
   }

  /// 🔐 Pin Verification (future)

  static Future<Map<String, dynamic>> verifyPin({
    required String email,
    required String pinCode,
  }) async {
    print('Verifying pin for email: $email with pinCode: $pinCode');
    final response = await http.post(
      Uri.parse(Url.pinVerification),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': pinCode}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    } else {
      print('Pin verification failed with response: $data');
      throw Exception(data['msg'] ?? 'Pin verification failed');
    }
  }

  /// Login
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(Url.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = jsonDecode(response.body);
    print('Login response data: $data');
    if (response.statusCode == 200 || response.statusCode == 201) {
      final token = data['data']['token'];
      final user = data['data']['user'];
      print('Login successful, token: $token,');
      await HiveService.saveToken(token);
      await HiveService.saveUser(user);

      return data;
    } else {
      throw Exception(data['msg'] ?? 'Login failed');
    }
  }

  //// Home Slider
  static Future<List<String>> fetchHomeSliderImages() async {
    final response = await http.get(Uri.parse(Url.homeSlider));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(
        data['data']['results'].map((item) => item['photo_url'] as String),
      );
    } else {
      throw Exception('Error loading slider images');
    }
  }

  /// 🔹 Get Categories
  static Future<Map<String, dynamic>> getCategories({
    required int limit,
    required int page,
  }) async {
    final response = await http.get(Uri.parse(Url.categories(limit, page)));

    final data = jsonDecode(response.body);

    print("Product List By Category Id : ${response.body}");

    final List<CategoryModel> items = (data['data']['results'] as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();

    return {'items': items, 'total': data['data']['total']};
  }

  ////
  ///🔹 Get Products List By Category Id
  static Future<Map<String, dynamic>> getProductListByCategoryId({
    required String categoryId,
  }) async {
    final response = await http.get(
      Uri.parse(Url.productsListByCategoryId(categoryId)),
      headers: {"Accept": "application/json"},
    );

    final data = jsonDecode(response.body);

    print("Product List By Category Id : ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> productsData = data['data']['results'];
      print("Products Data: $productsData");
      final List<Product> products = productsData
          .map((e) => Product.fromJson(e))
          .toList();
      return {'products': products};
    } else {
      throw Exception(data['msg'] ?? 'Failed to load products');
    }
  }

  static Future<String> addToCart({required String productId}) async {
    final box = Hive.box('authBox');
    final token = box.get('token') as String?;

    final response = await http.post(
      Uri.parse(Url.addToCartUrl),
      headers: {
        "token": "$token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"product": productId}),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data['msg'];
    } else {
      throw Exception(data['msg']);
    }
  }

  static Future<Product> getProductDetails({required String productId}) async {
    final response = await http.get(
      Uri.parse(Url.productsDetailsByProductId(productId)),
      headers: {"Accept": "application/json"},
    );

    final data = jsonDecode(response.body);
    print("Product Details Response: ${response.body}");
    if (response.statusCode == 200) {
      return Product.fromJson(data['data']);
    } else {
      throw Exception(data['msg'] ?? 'Failed to load product details');
    }
  }

  //// Get Cart List
  static Future<List<CartItemModel>> getCartList() async {
    final box = Hive.box('authBox');
    final token = box.get('token') as String?;

    final response = await http.get(
      Uri.parse(Url.cartListUrl),
      headers: {
        "token": "$token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    print("Cart List STATUS: ${response.statusCode}");
    print("Cart List BODY: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> cartItemsData = data['data']['results'];
      return cartItemsData.map((e) => CartItemModel.fromJson(e)).toList();
    } else {
      throw Exception(data['msg'] ?? 'Failed to load cart list');
    }
  }

  //// Remove Cart Item
  static Future<String> removeCartItem(String cartItemId) async {
    final box = Hive.box('authBox');
    final token = box.get('token') as String?;

    final response = await http.delete(
      Uri.parse(Url.cartItemRemoveUrl(cartItemId)),
      headers: {
        "token": "$token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    print("Remove Cart Item STATUS: ${response.statusCode}");
    print("Remove Cart Item BODY: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data['msg'];
    } else {
      throw Exception(data['msg'] ?? 'Failed to remove cart item');
    }
  }

  static Future<List<Product>> getPopularItems() async {
    final response = await http.get(Uri.parse(Url.popularItemsUrl));

    final data = jsonDecode(response.body);
    print("Popular Items Response: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> popularItemsData = data['data']['results'];
      return popularItemsData.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception(data['msg'] ?? 'Failed to load popular items');
    }
  }

  /// Add To Wishlist (future)
  static Future<String> addToWishlist({required String productId}) async {
    final box = Hive.box('authBox');
    final token = box.get('token') as String?;

    print("Token for Add To Wishlist: $token,");

    final response = await http.post(
      Uri.parse(Url.addWishItemUrl),
      headers: {
        "token": "$token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"product": productId}),
    );

    print("Add To Wishlist STATUS: ${response.statusCode}");
    print("Add To Wishlist BODY: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data['msg'];
    } else {
      throw Exception(data['msg']);
    }
  }


/// Wish List 
   
   static Future<List<WishItemModel>> getWishList() async {
    final box = Hive.box('authBox');
    final token = box.get('token') as String?;

    final respose = await http.get(
      Uri.parse(Url.wishListUrl),
      headers: {
        "token": "$token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    print("Wish List STATUS: ${respose.statusCode}");
    print("Wish List BODY: ${respose.body}");

    final data = jsonDecode(respose.body);

    if (respose.statusCode == 200){
      final List<dynamic> wishItemsData = data['data']['results'];
      return wishItemsData.map((e)=> WishItemModel.fromJson(e)).toList();
    
    }else {
      throw Exception(data['msg'] ?? 'Failed to load wish list');
    }
   }

/// Remove From Wishlist
   static Future<String> removeFromWishlist({required String itemId}) async {
    final box = Hive.box('authBox');
    final token = box.get('token') as String?;

    final response = await http.delete(
      Uri.parse(Url.removeWishItemUrl(itemId)),
      headers: {
        "token": "$token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    print("Remove From Wishlist STATUS: ${response.statusCode}");
    print("Remove From Wishlist BODY: ${response.body}");

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data['msg'];
    } else {
      throw Exception(data['msg'] ?? 'Failed to remove item from wishlist');
    }
   }




}
