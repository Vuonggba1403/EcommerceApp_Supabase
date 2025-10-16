import 'dart:developer';
import 'package:e_commerce_app_supabase/core/components/cache_images_view.dart';
import 'package:e_commerce_app_supabase/core/components/custom_derlight_bar.dart';
import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:e_commerce_app_supabase/core/functions/format_currency.dart';
import 'package:e_commerce_app_supabase/core/functions/navigate_to.dart';
import 'package:e_commerce_app_supabase/core/models/product_model/product_model.dart';
import 'package:e_commerce_app_supabase/views/home/logic/cubit/home_cubit.dart';
import 'package:e_commerce_app_supabase/views/product_details/ui/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = context.read<HomeCubit>();

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is addToFavoriteFailure ||
            state is removeFromFavoriteFailure) {
          showCustomDelightToastBar(
            context,
            "Error",
            const Icon(Icons.error, color: Colors.white),
          );
        }
        if (state is addToFavoriteSuccess) {
          showCustomDelightToastBar(
            context,
            "Add Successful!",
            const Icon(Icons.check, color: Colors.white),
          );
        }
        if (state is removeFromFavoriteSuccess) {
          showCustomDelightToastBar(
            context,
            "Remove Successful!",
            const Icon(Icons.check, color: Colors.white),
          );
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: size.height * 0.45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final isFav = cubit.checkIsFavorite(product.productId ?? "");

              return GestureDetector(
                onTap: () =>
                    navigateTo(context, ProductDetailsView(product: product)),
                child: Container(
                  width: size.width * 0.6,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Image + Sale + Favorite ---
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: CacheImage(url: product.imageUrl ?? ''),
                          ),
                          if (product.sale != null && product.sale!.isNotEmpty)
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "-${product.sale}%",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () async {
                                final id = product.productId ?? "";
                                if (cubit.checkIsFavorite(id)) {
                                  await cubit.removeFromFavorite(id);
                                } else {
                                  await cubit.addToFavorite(id);
                                }
                              },
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav
                                    ? Colors.red
                                    : AppColors.secondColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          product.productName ?? "Unnamed Product",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Text("${formatCurrency(product.price)} VND"),
                            const SizedBox(width: 8),
                            if (product.oldSale != null &&
                                product.oldSale!.isNotEmpty)
                              Text(
                                "${formatCurrency(product.oldSale)} VND",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
