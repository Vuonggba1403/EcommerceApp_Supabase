import 'package:e_commerce_app_superbase/core/app_colors.dart';
import 'package:e_commerce_app_superbase/common/custom_button.dart';
import 'package:e_commerce_app_superbase/common/custom_textfield.dart';
import 'package:e_commerce_app_superbase/core/loading_screen.dart';
import 'package:e_commerce_app_superbase/views/auth/login/ui/login_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgotView extends StatelessWidget {
  const ForgotView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(50, 50),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                // Navigator.pop(context);
                loadingScreen(context, () => const LoginView());
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            SizedBox(height: 15),
            Lottie.asset(
              "assets/login_images/forgotpassword.json",
              height: size.height * 0.25,
            ),
            SizedBox(height: 15),
            Text(
              "Forgot Password?",
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
                fontFamily: "CircularStd",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.04),

            CustomTextField(
              hintText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: size.height * 0.02),
            CustomButton(
              text: "Continue",
              onPressed: () {},
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
