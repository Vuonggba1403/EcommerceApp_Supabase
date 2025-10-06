import 'package:e_commerce_app_supabase/core/components/cache_images_view.dart';
import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:e_commerce_app_supabase/core/models/product_model/product_model.dart';
import 'package:flutter/material.dart';

class TopSellingView extends StatelessWidget {
  const TopSellingView({Key? key, required this.products}) : super(key: key);

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Header ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Top Selling",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text("See All", style: TextStyle(color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 10),

        // --- Horizontal list of products ---
        SizedBox(
          height: size.height * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Container(
                width: size.width * 0.45,
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
                    // --- Product Image + Sale Tag + Favorite ---
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: CacheImage(
                            url: product.imageUrl ?? '',
                            height: 180,
                          ),
                        ),

                        // Sale tag (only show if sale exists)
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
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),

                        // Favorite icon
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(
                            Icons.favorite_border,
                            color: AppColors.secondColor,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // --- Product Name ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        product.productName ?? "Unnamed Product",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // --- Product Price ---
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Text(
                            "\$${product.price ?? "0"}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (product.oldSale != null &&
                              product.oldSale!.isNotEmpty)
                            Text(
                              "\$${product.oldSale}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
