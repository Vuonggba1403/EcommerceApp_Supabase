import 'package:e_commerce_app_supabase/core/components/cache_images_view.dart';
import 'package:e_commerce_app_supabase/core/components/custom_backbutton.dart';
import 'package:e_commerce_app_supabase/core/components/custom_circle_proIndicator.dart';
import 'package:e_commerce_app_supabase/core/components/grid_product_view.dart';
import 'package:e_commerce_app_supabase/core/functions/navigate_to.dart';
import 'package:e_commerce_app_supabase/core/models/product_model/product_model.dart';
import 'package:e_commerce_app_supabase/views/home/logic/cubit/home_cubit.dart';
import 'package:e_commerce_app_supabase/views/product_details/ui/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesProductView extends StatefulWidget {
  const CategoriesProductView({super.key, required this.categoryName});
  final String categoryName;

  @override
  State<CategoriesProductView> createState() => _CategoriesProductViewState();
}

class _CategoriesProductViewState extends State<CategoriesProductView> {
  @override
  void initState() {
    super.initState();
    // Gọi lọc danh mục khi mở trang
    context.read<HomeCubit>().searchByCategory(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackbutton(),
              SizedBox(height: size.height * 0.02),

              // 🟢 Dùng BlocBuilder để hiển thị tiêu đề có số lượng
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  int count = 0;

                  if (state is CategoryFilterSuccess) {
                    count = state.filtered.length;
                  }

                  return Text(
                    "${widget.categoryName} ($count)",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  );
                },
              ),

              SizedBox(height: size.height * 0.02),

              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is CategoryFilterLoading) {
                      return const CustomCircleProgIndicator();
                    } else if (state is CategoryFilterSuccess) {
                      final products = state.filtered;
                      if (products.isEmpty) {
                        return const Center(child: Text("No products found"));
                      }
                      return gridProducts(products);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
