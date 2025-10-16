import 'package:e_commerce_app_supabase/core/components/cache_images_view.dart';
import 'package:e_commerce_app_supabase/core/functions/navigate_to.dart';
import 'package:e_commerce_app_supabase/core/models/product_model/product_model.dart';
import 'package:e_commerce_app_supabase/views/product_details/ui/product_details_view.dart';
import 'package:e_commerce_app_supabase/views/home/logic/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GridView gridProducts(List<ProductModel> products) {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.75,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemCount: products.length,
    itemBuilder: (context, index) {
      final p = products[index];
      final cubit = context.read<HomeCubit>();

      return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final isFav = cubit.checkIsFavorite(p.productId ?? "");

          return GestureDetector(
            onTap: () {
              navigateTo(context, ProductDetailsView(product: p));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: CacheImage(url: p.imageUrl ?? ''),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () async {
                              final id = p.productId ?? "";
                              if (cubit.checkIsFavorite(id)) {
                                await cubit.removeFromFavorite(id);
                              } else {
                                await cubit.addToFavorite(id);
                              }
                            },
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            p.productName ?? 'No name',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "\$${p.price ?? 0}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
