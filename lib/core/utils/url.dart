class Url {
  static const String _baseUrl = 'https://ecom-rs8e.onrender.com/api';

  static const String signUp = '$_baseUrl/auth/signup';
  static const String login = '$_baseUrl/auth/login';
  static const String pinVerification = '$_baseUrl/auth/verify-otp';
  static const String homeSlider = '$_baseUrl/slides';
  static String categories(int count, int page) =>
      '$_baseUrl/categories?count=$count&page=$page';
  static String productsListByCategoryId(String categoryId) =>
      '$_baseUrl/products?category=$categoryId';
        static String productsDetailsByProductId(String productId) =>
      '$_baseUrl/products/id/$productId';
static String addToCartUrl =  '$_baseUrl/cart';
static String cartListUrl =  '$_baseUrl/cart';
}
