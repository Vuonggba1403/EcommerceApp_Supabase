import 'package:e_commerce_app_supabase/core/components/custom_circle_proIndicator.dart';
import 'package:e_commerce_app_supabase/core/components/grid_product_view.dart';
import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:e_commerce_app_supabase/views/home/logic/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {
    super.initState();
    // Gọi Cubit để load danh sách yêu thích khi vào màn hình
    Future.delayed(Duration.zero, () {
      context.read<HomeCubit>().getFavoriteProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final favorites = context.read<HomeCubit>().favoriteProductList;
            return Text(
              "Favorites (${favorites.length})",
              style: TextStyle(color: AppColors.secondColor),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),

      // ✅ Phần body được xử lý hoàn toàn bằng state
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          // Khi đang tải dữ liệu
          if (state is GetDataLoading) {
            return const Center(child: CustomCircleProgIndicator());
          }

          final favorites = context.read<HomeCubit>().favoriteProductList;

          // Nếu danh sách trống
          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 50,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "No Favorites yet!",
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      foregroundColor: AppColors.secondColor,
                      backgroundColor: AppColors.primaryColor,
                    ),
                    onPressed: () {},
                    child: const Text("Explore Categories"),
                  ),
                ],
              ),
            );
          }

          // Nếu có sản phẩm yêu thích → hiển thị grid
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: gridProducts(favorites),
            ),
          );
        },
      ),
    );
  }
}
