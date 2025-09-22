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
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "CircularStd",
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 15),
          displayMedium: TextStyle(fontSize: 15),
          displaySmall: TextStyle(fontSize: 15),
          headlineLarge: TextStyle(fontSize: 15),
          headlineMedium: TextStyle(fontSize: 15),
          headlineSmall: TextStyle(fontSize: 15),
          titleLarge: TextStyle(fontSize: 15),
          titleMedium: TextStyle(fontSize: 15),
          titleSmall: TextStyle(fontSize: 15),
          bodyLarge: TextStyle(fontSize: 15),
          bodyMedium: TextStyle(fontSize: 15),
          bodySmall: TextStyle(fontSize: 15),
          labelLarge: TextStyle(fontSize: 15),
          labelMedium: TextStyle(fontSize: 15),
          labelSmall: TextStyle(fontSize: 15),
        ),
      ),
      home: HomeView(),
    );
  }
}
