import 'package:e_commerce_app_supabase/core/functions/navigate_to.dart';
import 'package:e_commerce_app_supabase/views/home/logic/cubit/home_cubit.dart';
import 'package:e_commerce_app_supabase/views/home/ui/widgets/categories/categories_products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySession extends StatelessWidget {
  const CategorySession({super.key});

  static const List<Map<String, String>> categories = [
    {"title": "Hoodies", "image": "assets/hoodies.png"},
    {"title": "Shorts", "image": "assets/short.png"},
    {"title": "Shoes", "image": "assets/shoes.png"},
    {"title": "Bag", "image": "assets/bags.png"},
    {"title": "Accessories", "image": "assets/Accessories.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text("See All"),
          ],
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((cat) {
              return GestureDetector(
                onTap: () {
                  final cubit = context.read<HomeCubit>();

                  // 🔥 Gọi filter trước khi chuyển trang
                  cubit.searchByCategory(cat["title"]!);

                  // Điều hướng sang trang hiển thị kết quả
                  navigateTo(
                    context,
                    BlocProvider.value(
                      value: cubit, // giữ nguyên cubit hiện tại
                      child: CategoriesProductView(categoryName: cat["title"]!),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(cat["image"]!, fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cat["title"]!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
