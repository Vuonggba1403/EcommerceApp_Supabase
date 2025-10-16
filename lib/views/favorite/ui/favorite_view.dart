import 'package:e_commerce_app_supabase/core/components/product_list.dart';
import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:e_commerce_app_supabase/views/home/logic/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final favorites = cubit.favoriteProductList;
            return Text(
              "Favorites (${favorites.length})",
              style: TextStyle(color: AppColors.secondColor),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final favorites = cubit.favoriteProductList;

            if (favorites.isEmpty) {
              // Nếu chưa có sản phẩm favorite
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 50,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(height: 20),
                    Text("No Favorites yet!", style: TextStyle(fontSize: 22)),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15),
                        foregroundColor: AppColors.secondColor,
                        backgroundColor: AppColors.primaryColor,
                      ),
                      onPressed: () {},
                      child: Text("Explore Categories"),
                    ),
                  ],
                ),
              );
            }

            // Nếu có favorite, hiển thị danh sách
            return ProductList(products: favorites, isFavoriteView: true);
          },
        ),
      ),
    );
  }
}
