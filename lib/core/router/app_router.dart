
import 'package:go_router/go_router.dart';

import '../../features/screens/auth/login/login_screen.dart';
import '../../features/screens/auth/pin/pin_verification_screen.dart';
import '../../features/screens/auth/signup/sign_up_screen.dart';
import '../../features/screens/home/categories/categories_list_screen.dart';
import '../../features/screens/home/nav_bar/bottom_nav_bar_screen.dart';
import '../../features/screens/profile/profile_screen.dart';
import '../../features/screens/splash/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/pin-verification',
        builder: (context, state) {
          final email = state.extra as String;
          return PinVerificationScreen(email: email);
        },
      ),
      GoRoute(
        path: '/bottom_nav_bar',
        builder: (context, state) {
          
          return BottomNavigationBarScreen();
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) {
          
          return ProfileScreen();
        },
      ),
      GoRoute(
        path: '/categories',
        builder: (context, state) {
          
          return CategoriesListScreen();
        },
      ),
    ],
  );
}
