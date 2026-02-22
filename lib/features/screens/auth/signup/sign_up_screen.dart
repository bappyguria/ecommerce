import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http show post;

import '../../../../core/theme/app_colors.dart';
import 'bloc/signup_bloc.dart';
import 'bloc/signup_event.dart';
import 'bloc/signup_state.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

final formKey = GlobalKey<FormState>();
final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController mobileNumberController = TextEditingController();
final TextEditingController cityController = TextEditingController();

final TextEditingController passwordController = TextEditingController();
final TextEditingController emailTextController = TextEditingController();

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  // 🔹 Logo
                  Image.asset('assets/images/logo.png', height: 90),
                  const SizedBox(height: 20),
                  // 🔹 Welcome Text
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF424242),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Get Started with your new account',
                    style: TextStyle(fontSize: 16, color: Color(0xFF9E9E9E)),
                  ),

                  const SizedBox(height: 40),

                  // 🔹 Email Field
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: firstNameController,
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your first name'
                        : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: lastNameController,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your last name'
                        : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailTextController,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (value) {
                      final email = value?.trim();

                      if (email == null || email.isEmpty) {
                        return 'Please enter your email';
                      }

                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex.hasMatch(email)) {
                        return 'Enter a valid email address';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: mobileNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Mobile Number',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }

                      final phone = value.trim();

                      // 🔥 Bangladesh Mobile Regex
                      final bdPhoneRegex = RegExp(r'^01[3-9]\d{8}$');

                      if (!bdPhoneRegex.hasMatch(phone)) {
                        return 'Enter a valid 11-digit mobile number';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: cityController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    decoration: InputDecoration(hintText: 'City'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,

                    decoration: InputDecoration(hintText: 'Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  // 🔹 Next Button
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              context.go('/login');
                            },

                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: BlocConsumer<SignUpBloc, SignUpState>(
                            listener: (context, state) {
                              if (state is SignUpSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                                context.go(
                                  '/pin-verification',
                                  extra: emailTextController.text.trim(),
                                );
                              } else if (state is SignUpError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              }
                            },
                            builder: (context, state) {
                              // 🔄 LOADING STATE
                              if (state is SignUpLoading) {
                                return Center(
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                );
                              }

                              // 🔘 NORMAL BUTTON
                              return ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<SignUpBloc>().add(
                                      SubmitSignUp(
                                        firstName: firstNameController.text
                                            .trim(),
                                        lastName: lastNameController.text
                                            .trim(),
                                        email: emailTextController.text.trim(),
                                        phone: mobileNumberController.text
                                            .trim(),
                                        city: cityController.text.trim(),
                                        password: passwordController.text,
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  'SignUp',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearForm() {
    firstNameController.clear();
    lastNameController.clear();
    mobileNumberController.clear();
    cityController.clear();

    passwordController.clear();
  }

  @override
  dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNumberController.dispose();
    cityController.dispose();

    passwordController.dispose();
    emailTextController.dispose();
    super.dispose();
  }
}
