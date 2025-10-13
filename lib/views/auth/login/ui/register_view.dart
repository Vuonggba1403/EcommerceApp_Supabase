import 'package:e_commerce_app_supabase/core/components/custom_circle_proIndicator.dart';
import 'package:e_commerce_app_supabase/core/components/custom_derlight_bar.dart';
import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:e_commerce_app_supabase/core/components/custom_button.dart';
import 'package:e_commerce_app_supabase/core/components/custom_textfield.dart';
import 'package:e_commerce_app_supabase/core/functions/navigate_to.dart';
import 'package:e_commerce_app_supabase/views/auth/login/logic/cubit/authentication_cubit.dart';
import 'package:e_commerce_app_supabase/views/auth/login/ui/forgot_view.dart';
import 'package:e_commerce_app_supabase/views/auth/login/ui/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          showCustomDelightToastBar(
            context,
            "Sign up successful",
            Icon(Icons.check, color: Colors.green),
          );
          navigateTo(context, LoginView());
        }
        if (state is SignUpFailure) {
          showCustomDelightToastBar(
            context,
            state.message,
            Icon(Icons.error, color: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: state is SignUpLoading
              ? CustomCircleProgIndicator()
              : SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.1),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.thirdColor,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(50, 50),
                              shape: const CircleBorder(),
                            ),
                            onPressed: () {
                              // Navigator.pop(context);
                              navigateTo(context, LoginView());
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
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
                            controller: _firstNameController,
                            hintText: 'FirstName',
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: size.height * 0.02),
                          CustomTextField(
                            controller: _lastNameController,
                            hintText: 'LastName',
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: size.height * 0.02),
                          CustomTextField(
                            controller: _emailController,
                            hintText: 'Email Address',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: size.height * 0.02),
                          CustomTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                          ),
                          SizedBox(height: size.height * 0.02),

                          CustomButton(
                            text: "Continue",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthenticationCubit>().register(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                );
                              }
                            },
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          SizedBox(height: size.height * 0.02),
                          Row(
                            children: [
                              Text("Forgot Password?"),
                              SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  navigateTo(context, ForgotView());
                                },
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
                  ),
                ),
        );
      },
    );
  }

  // Dispose controllers when widget is destroyed
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
