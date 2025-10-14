import 'package:e_commerce_app_supabase/core/components/custom_circle_proIndicator.dart';
import 'package:e_commerce_app_supabase/core/components/custom_searchfield.dart';
import 'package:e_commerce_app_supabase/core/functions/navigate_to.dart';
import 'package:e_commerce_app_supabase/views/home/logic/cubit/home_cubit.dart';
import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:e_commerce_app_supabase/core/models/product_model/product_model.dart';
import 'package:e_commerce_app_supabase/views/home/ui/widgets/categories/categori_session.dart';
import 'package:e_commerce_app_supabase/views/home/ui/widgets/search_view.dart';
import 'package:e_commerce_app_supabase/views/home/ui/widgets/sell_card.dart';
import 'package:e_commerce_app_supabase/views/home/ui/widgets/top_selling_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.query});
  final String? query; // Giữ lại nếu cần filter từ deep link

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedCategory = "Men";
  final categories = ["Men", "Women", "Kids"];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => HomeCubit()..getProducts(), // Loại bỏ query parameter
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 20.0,
            ),
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
                  Builder(
                    builder: (context) {
                      final homeCubit = context.read<HomeCubit>();
                      return CustomSearchField(
                        controller: _searchController,
                        homeCubit: homeCubit,
                        onPressed: () {
                          if (_searchController.text.isNotEmpty) {
                            navigateTo(
                              context,
                              SearchView(
                                query: _searchController.text,
                                homeCubit: homeCubit,
                              ),
                            );
                            _searchController.clear();
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  // Category session
                  const CategorySession(),
                  SizedBox(height: size.height * 0.03),
                  // Top selling
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      final products = context.read<HomeCubit>().products;

                      if (state is GetDataLoading) {
                        return CustomCircleProgIndicator();
                      }

                      return TopSellingView(products: products);
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  // Cached Images
                  SellProductCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
