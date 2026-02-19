import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/storage/hive_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // ⏳ 3 second delay
    Timer(const Duration(seconds: 3), () {
      _checkLoginStatus();
    });
  }

  void _checkLoginStatus() {
    final token = HiveService.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      // ✅ user already logged in
      context.go('/bottom_nav_bar');
    } else {
      // ❌ not logged in
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                Image.asset('assets/images/logo.png'),
              ],
            ),
            const Spacer(),
            // Loading Indicator
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Column(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(0xFF00BCD4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Version 1.0',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFBDBDBD),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
