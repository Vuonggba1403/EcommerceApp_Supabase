import 'package:e_commerce_app_supabase/core/components/custom_backbutton.dart';
import 'package:e_commerce_app_supabase/core/components/custom_circle_proIndicator.dart';
import 'package:e_commerce_app_supabase/core/components/custom_derlight_bar.dart';
import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:e_commerce_app_supabase/core/components/custom_button.dart';
import 'package:e_commerce_app_supabase/core/components/custom_textfield.dart';
import 'package:e_commerce_app_supabase/core/functions/navigate_to.dart';
import 'package:e_commerce_app_supabase/views/auth/login/logic/cubit/authentication_cubit.dart';
import 'package:e_commerce_app_supabase/views/auth/login/ui/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is PasswordResetSuccess) {
          showCustomDelightToastBar(
            context,
            "Password reset email sent",
            Icon(Icons.check, color: Colors.green),
          );
          navigateTo(context, LoginView());
        }
        if (state is PasswordResetFailure) {
          showCustomDelightToastBar(
            context,
            state.message,
            const Icon(Icons.error, color: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return state is PasswordResetLoading
            ? CustomCircleProgIndicator()
            : Scaffold(
                resizeToAvoidBottomInset: true,
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.15),
                          CustomBackbutton(),
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
                            controller: _emailController,
                          ),
                          SizedBox(height: size.height * 0.02),
                          CustomButton(
                            text: "Continue",
                            onPressed: () {
                              // final email = context
                              //     .read<AuthenticationCubit>()
                              //     .emailController
                              //     .text;
                              // context.read<AuthenticationCubit>().resetPassword(
                              //   email: _emailController.text,
                              // );
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<AuthenticationCubit>()
                                    .resetPassword(
                                      email: _emailController.text,
                                    );
                              }
                            },
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
