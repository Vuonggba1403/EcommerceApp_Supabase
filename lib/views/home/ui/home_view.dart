import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_supabase/core/app_colors.dart';
import 'package:e_commerce_app_supabase/views/home/ui/widgets/cache_images_view.dart'
    show CacheImagesView, CacheImage;
import 'package:e_commerce_app_supabase/views/home/ui/widgets/categories/categori_session.dart';
import 'package:e_commerce_app_supabase/views/home/ui/widgets/search_textfield.dart';
import 'package:e_commerce_app_supabase/views/home/ui/widgets/sell_card.dart';
import 'package:e_commerce_app_supabase/views/home/ui/widgets/top_selling_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedCategory = "Men";
  final categories = ["Men", "Women", "Kids"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar + Dropdown + Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage('assets/user_images.png'),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCategory,
                            items: categories.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value!;
                              });
                            },
                            icon: const Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),
                      child: const Icon(
                        Icons.propane_tank_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                //Search
                const SearchField(),
                SizedBox(height: size.height * 0.03),
                // Category session
                const CategorySession(),
                SizedBox(height: size.height * 0.03),
                // Top selling
                const TopSellingView(),
                SizedBox(height: size.height * 0.03),
                // Cached Images
                SellProductCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
