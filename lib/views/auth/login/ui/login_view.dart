import 'package:e_commerce_app_superbase/core/app_colors.dart';
import 'package:e_commerce_app_superbase/views/auth/login/ui/forgot_view.dart';
import 'package:e_commerce_app_superbase/views/auth/login/ui/widgets/custom_button.dart';
import 'package:e_commerce_app_superbase/views/auth/login/ui/widgets/custom_textfield.dart';
import 'package:e_commerce_app_superbase/core/loading_screen.dart';
import 'package:e_commerce_app_superbase/views/auth/login/ui/register_view.dart';
import 'package:e_commerce_app_superbase/views/auth/nav_bar/ui/main_home_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // lấy kích thước màn hình
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.20),
            Text(
              "Sign in",
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
                fontFamily: "CircularStd",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            CustomTextField(
              hintText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15),
            CustomTextField(
              hintText: 'Password',
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                loadingScreen(context, () => const ForgotView());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontFamily: "CircularStd",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            CustomButton(
              text: "Continue",
              onPressed: () {
                loadingScreen(context, () => const MainHomeView());
              },
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text("Don't have an Account? "),
                GestureDetector(
                  onTap: () {
                    // Text("Create One");
                    loadingScreen(context, () => const RegisterView());
                  },
                  child: Text(
                    "Create One",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            CustomButton(
              text: "Continue with Apple",
              onPressed: () {},
              backgroundColor: AppColors.thirdColor,
              foregroundColor: Colors.black,
              image: Image.asset(
                "assets/login_images/Apple.png",
                height: 24,
                width: 24,
              ),
            ),
            SizedBox(height: 15),
            CustomButton(
              text: "Continue with Google",
              onPressed: () {},
              backgroundColor: AppColors.thirdColor,
              foregroundColor: Colors.black,
              image: Image.asset(
                "assets/login_images/Google.png",
                height: 24,
                width: 24,
              ),
            ),
            SizedBox(height: 15),
            CustomButton(
              text: "Continue with Facebook",
              onPressed: () {},
              backgroundColor: AppColors.thirdColor,
              foregroundColor: Colors.black,
              image: Image.asset(
                "assets/login_images/Facebook.png",
                height: 24,
                width: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
