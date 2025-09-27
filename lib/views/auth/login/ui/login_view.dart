import 'package:e_commerce_app_supabase/common/custom_circle_proIndicator.dart';
import 'package:e_commerce_app_supabase/common/custom_derlight_bar.dart';
import 'package:e_commerce_app_supabase/core/app_colors.dart';
import 'package:e_commerce_app_supabase/views/auth/login/logic/cubit/authentication_cubit.dart';
import 'package:e_commerce_app_supabase/views/auth/login/ui/forgot_view.dart';
import 'package:e_commerce_app_supabase/common/custom_button.dart';
import 'package:e_commerce_app_supabase/common/custom_textfield.dart';
import 'package:e_commerce_app_supabase/core/loading_screen.dart';
import 'package:e_commerce_app_supabase/views/auth/login/ui/register_view.dart';
import 'package:e_commerce_app_supabase/views/auth/nav_bar/ui/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginSuccess || state is GoogleSignInSuccess) {
          showCustomDelightToastBar(
            context,
            "Login successful",
            Icon(Icons.check, color: Colors.green),
          );
          loadingScreen(context, () => const MainHomeView());
        }
        if (state is LoginFailure) {
          showCustomDelightToastBar(
            context,
            state.message,
            const Icon(Icons.error, color: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AuthenticationCubit>();

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: state is LoginLoading
              ? const CustomCircleProgIndicator()
              : SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Text(
                            "Sign in",
                            style: const TextStyle(
                              fontSize: 32,
                              fontFamily: "CircularStd",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),

                          /// Email
                          CustomTextField(
                            hintText: 'Email Address',
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                          ),
                          const SizedBox(height: 15),

                          /// Password
                          CustomTextField(
                            hintText: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                            controller: passwordController,
                          ),
                          const SizedBox(height: 10),

                          /// Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => loadingScreen(
                                context,
                                () => const ForgotView(),
                              ),
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "CircularStd",
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          /// Continue button
                          CustomButton(
                            text: "Continue",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          const SizedBox(height: 20),

                          /// Register link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Don't have an Account? "),
                              GestureDetector(
                                onTap: () => loadingScreen(
                                  context,
                                  () => const RegisterView(),
                                ),
                                child: const Text(
                                  "Create One",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.05),

                          /// Social login
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
                          const SizedBox(height: 15),
                          CustomButton(
                            text: "Continue with Google",
                            onPressed: () {
                              cubit.googleSignIn();
                            },
                            backgroundColor: AppColors.thirdColor,
                            foregroundColor: Colors.black,
                            image: Image.asset(
                              "assets/login_images/Google.png",
                              height: 24,
                              width: 24,
                            ),
                          ),
                          const SizedBox(height: 15),
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
                  ),
                ),
        );
      },
    );
  }

  // Dispose controllers when widget is destroyed
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
