import 'package:flutter/material.dart';

class CommonFunction {
  static void clearLoginForm(TextEditingController emailController, TextEditingController passwordController) {
    emailController.clear();
    passwordController.clear();
  }
}