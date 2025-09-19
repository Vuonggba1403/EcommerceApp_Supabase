import 'dart:math';

import 'package:e_commerce_app_superbase/core/app_colors.dart';
import 'package:e_commerce_app_superbase/views/favorite/ui/favorite_view.dart';
import 'package:e_commerce_app_superbase/views/home/ui/home_view.dart';
import 'package:e_commerce_app_superbase/views/profiles/ui/profile_view.dart';
import 'package:e_commerce_app_superbase/views/search/ui/search_view.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});
  final List<Widget> views = const [
    const HomeView(),
    const FavoriteView(),
    const SearchView(),
    const ProfileView(),
  ];

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.views[_selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            // animation
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 200),
            // layout
            gap: 8,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            tabBorderRadius: 20,
            tabMargin: const EdgeInsets.symmetric(horizontal: 6),

            // màu sắc
            color: Colors.grey[600], // icon chưa active
            activeColor: Colors.white, // icon + text khi active
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),

            // nền tab active → pill gradient
            tabBackgroundGradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF9CECFB), // xanh nhạt
                AppColors.primaryColor, // xanh đậm hơn
              ],
            ),

            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.favorite_border, text: 'Likes'),
              GButton(icon: Icons.search, text: 'Search'),
              GButton(icon: Icons.person, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
