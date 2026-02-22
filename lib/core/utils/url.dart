class Url {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';

  static const String signUp = '$_baseUrl/auth/signup';
  static const String login = '$_baseUrl/auth/login';
  static const String pinVerification = '$_baseUrl/auth/verify-otp';
   static const String profileShow = '$_baseUrl/auth/profile';
  static const String updatedProfile = '$_baseUrl/auth/profile';
  static const String homeSlider = '$_baseUrl/slides';
  static String categories(int count, int page) =>
      '$_baseUrl/categories?count=$count&page=$page';
  static String productsListByCategoryId(String categoryId) =>
      '$_baseUrl/products?category=$categoryId';
  static String productsDetailsByProductId(String productId) =>
      '$_baseUrl/products/id/$productId';
  static String addToCartUrl = '$_baseUrl/cart';
  static String cartListUrl = '$_baseUrl/cart';
  static String cartItemRemoveUrl(String cartID) =>
      '$_baseUrl/cart/$cartID';

  static String popularItemsUrl = '$_baseUrl/products?category=67c35af85e8a445235de197b';
  static String addWishItemUrl = '$_baseUrl/wishlist';
  static String wishListUrl = '$_baseUrl/wishlist';
  static String removeWishItemUrl(String itemId) =>
      '$_baseUrl/wishlist/$itemId';
}
