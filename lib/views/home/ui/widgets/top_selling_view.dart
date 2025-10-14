import 'package:e_commerce_app_supabase/core/components/product_list.dart';
import 'package:e_commerce_app_supabase/core/models/product_model/product_model.dart';
import 'package:flutter/material.dart';

class TopSellingView extends StatelessWidget {
  const TopSellingView({Key? key, required this.products}) : super(key: key);

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        ProductList(products: products),
      ],
    );
  }
}
