
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/theme/app_colors.dart';
import 'bloc/pin_bloc.dart';
import 'bloc/pin_event.dart';
import 'bloc/pin_state.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;
  const PinVerificationScreen({super.key, required this.email});

  @override
  State<PinVerificationScreen> createState() =>
      _PinVerificationScreenState();
}

class _PinVerificationScreenState
    extends State<PinVerificationScreen> {
  final TextEditingController _pinController =
      TextEditingController();

@override
  void initState() {
    super.initState();
    print('Email ${widget.email}');
  }
  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 60),

                Image.asset('assets/images/logo.png', height: 90),

                const SizedBox(height: 40),

                const Text(
                  'Enter OTP Code',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF424242),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'A 4 digit OTP code has been sent to your email',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9E9E9E),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                /// 🔢 PIN FIELD
                PinCodeTextField(
                  length: 4,
                  controller: _pinController,
                  appContext: context, // ✅ REQUIRED
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  animationDuration:
                      const Duration(milliseconds: 300),
                  enableActiveFill: true,

                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 50,
                    fieldWidth: 45,
                    activeColor: Colors.blue,
                    selectedColor: Colors.blue,
                    inactiveColor: AppColors.primary,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    errorBorderColor: Colors.red,
                  ),
onCompleted: (value) {
    _pinController.text = value;
  },
                  // onChanged: (value) {
                  //   setState(() {
                  //     _currentPin = value;
                  //   });
                  // },

                  // onCompleted: (value) {
                  //   _currentPin = value;
                  // },
                ),

                const SizedBox(height: 24),

                /// 🔘 VERIFY BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: BlocConsumer<PinVerificationBloc,PinVerificationState>(builder: (context,state){
                    if (state is PinVerificationLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                  return ElevatedButton(
                    onPressed: () {
                      context.read<PinVerificationBloc>().add(SubmitPinVerification(
                        email: widget.email,
                        pinCode: _pinController.text,
                      ));
                    },
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  );
                  }, listener: (context, state) {
                    if (state is PinVerificationSuccess) {
                      context.push('/login');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    } else if (state is PinVerificationError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  }),
                ),

                const SizedBox(height: 20),

                RichText(
                  text: const TextSpan(
                    text: 'This code will expire in ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                        text: '120s',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('OTP Resent'),
                      ),
                    );
                  },
                  child: const Text('Resend Code'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
