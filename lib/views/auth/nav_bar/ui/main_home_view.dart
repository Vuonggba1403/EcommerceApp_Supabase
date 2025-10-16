// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:e_commerce_app_supabase/views/auth/nav_bar/logic/cubit/nav_bar_cubit.dart';
import 'package:e_commerce_app_supabase/views/cart/ui/cart_view.dart';
import 'package:e_commerce_app_supabase/views/favorite/ui/favorite_view.dart';
import 'package:e_commerce_app_supabase/views/home/ui/home_view.dart';
import 'package:e_commerce_app_supabase/views/profiles/ui/profile_view.dart';
import 'package:e_commerce_app_supabase/views/home/logic/cubit/home_cubit.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({Key? key}) : super(key: key);

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  final List<Widget> _views = const [
    HomeView(),
    FavoriteView(),
    CartView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavBarCubit()),
        BlocProvider(
          create: (_) => HomeCubit()..getProducts(),
        ), // Load sản phẩm ngay
      ],
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          final navCubit = context.read<NavBarCubit>();

          return Scaffold(
            body: _views[navCubit.currentIndex],
            bottomNavigationBar: _buildBottomNav(navCubit),
          );
        },
      ),
    );
  }

  Widget _buildBottomNav(NavBarCubit cubit) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 9),
        child: GNav(
          onTabChange: (index) => cubit.changeCurrentIndex(index),
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 200),
          gap: 8,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          tabBorderRadius: 20,
          tabMargin: const EdgeInsets.symmetric(horizontal: 4),
          color: Colors.grey[600],
          activeColor: Colors.white,
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
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
    );
  }
}
