import 'dart:math';

import 'package:e_commerce_app_supabase/core/app_colors.dart';
import 'package:e_commerce_app_supabase/views/auth/nav_bar/logic/cubit/nav_bar_cubit.dart';
import 'package:e_commerce_app_supabase/views/favorite/ui/favorite_view.dart';
import 'package:e_commerce_app_supabase/views/home/ui/home_view.dart';
import 'package:e_commerce_app_supabase/views/profiles/ui/profile_view.dart';
import 'package:e_commerce_app_supabase/views/cart/ui/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});
  final List<Widget> views = const [
    HomeView(),
    FavoriteView(),
    CartView(),
    ProfileView(),
  ];

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          NavBarCubit cubit = BlocProvider.of<NavBarCubit>(context);
          return Scaffold(
            body: widget.views[cubit.currentIndex],
            bottomNavigationBar: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 9,
                ),
                child: GNav(
                  onTabChange: (index) {
                    cubit.changeCurrentIndex(index);
                  },
                  // animation
                  curve: Curves.easeOutExpo,
                  duration: const Duration(milliseconds: 200),
                  // layout
                  gap: 8,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  tabBorderRadius: 20,
                  tabMargin: const EdgeInsets.symmetric(horizontal: 4),

                  color: Colors.grey[600],
                  activeColor: Colors.white,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),

                  // nền tab active → pill gradient
                  tabBackgroundGradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF9CECFB), AppColors.primaryColor],
                  ),

                  tabs: const [
                    GButton(icon: Icons.home, text: 'Home'),
                    GButton(icon: Icons.favorite_border, text: 'Likes'),
                    GButton(icon: Icons.shopping_bag_outlined, text: 'Cart'),
                    GButton(icon: Icons.person, text: 'Profile'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
