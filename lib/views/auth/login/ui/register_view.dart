import 'package:e_commerce_app_superbase/core/app_colors.dart';
import 'package:e_commerce_app_superbase/views/auth/login/ui/widgets/custom_button.dart';
import 'package:e_commerce_app_superbase/views/auth/login/ui/widgets/custom_textfield.dart';
import 'package:e_commerce_app_superbase/core/loading_screen.dart';
import 'package:e_commerce_app_superbase/views/auth/login/ui/login_view.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

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
            SizedBox(height: size.height * 0.20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.thirdColor,
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
            Text(
              "Create Account",
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
                fontFamily: "CircularStd",
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.04),
            CustomTextField(
              hintText: 'FirstName',
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: size.height * 0.02),
            CustomTextField(
              hintText: 'LastName',
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: size.height * 0.02),
            CustomTextField(
              hintText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: size.height * 0.02),
            CustomTextField(
              hintText: 'Password',
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            SizedBox(height: size.height * 0.02),

            CustomButton(
              text: "Continue",
              onPressed: () {},
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              children: [
                Text("Forgot Password?"),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Reset",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
