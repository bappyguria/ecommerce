import 'package:hive/hive.dart';

class HiveService {
  static final Box _authBox = Hive.box('authBox');

  // 🔐 Save token
  static Future<void> saveToken(String token) async {
    await _authBox.put('token', token);
  }

  static String? getToken() {
    return _authBox.get('token');
  }

  // 👤 Save user
  static Future<void> saveUser(Map<String, dynamic> user) async {
    await _authBox.put('user', user);
  }

  static Map<String, dynamic>? getUser() {
    final data = _authBox.get('user');
    return data != null ? Map<String, dynamic>.from(data) : null;
  }

  // 🚪 Logout
  static Future<void> clear() async {
    await _authBox.clear();
  }
}
