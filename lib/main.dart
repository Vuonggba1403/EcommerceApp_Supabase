import 'package:e_commerce_app_superbase/views/auth/login/ui/login_view.dart';
import 'package:e_commerce_app_superbase/views/auth/login/ui/register_view.dart';
import 'package:e_commerce_app_superbase/views/auth/nav_bar/ui/main_home_view.dart';
import 'package:e_commerce_app_superbase/views/home/ui/home_view.dart';
import 'package:e_commerce_app_superbase/views/splash/ui/splash_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(OurMarket());
}

class OurMarket extends StatelessWidget {
  const OurMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Our Market",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: HomeView(),
    );
  }
}
