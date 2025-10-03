import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:e_commerce_app_supabase/views/auth/login/ui/login_view.dart'
    show LoginView;
import 'package:e_commerce_app_supabase/views/auth/nav_bar/ui/main_home_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SupabaseClient client = Supabase.instance.client;
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => client.auth.currentUser != null
            ? const MainHomeView()
            : const LoginView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.thirdColor,
            ], // gradient nền
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.3,
              child: Lottie.asset("assets/splash_images/amongus.json"),
            ),
            const SizedBox(height: 20),
            // Logo app
            SizedBox(
              height: size.height * 0.15,
              child: Image.asset(
                "assets/splash_images/logo.png",
                // fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            // Text slogan / welcome message
            const Text(
              "Welcome to E-Commerce App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2.0, // độ dày của vòng tròn
            ),
          ],
        ),
      ),
    );
  }
}
