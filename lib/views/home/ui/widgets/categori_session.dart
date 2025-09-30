import 'package:e_commerce_app_supabase/core/loading_screen.dart';
import 'package:e_commerce_app_supabase/views/home/ui/widgets/all_categories.dart';
import 'package:flutter/material.dart';

class CategorySession extends StatelessWidget {
  const CategorySession({super.key});

  final List<Map<String, String>> categories = const [
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
          children: [
            Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllCategories(categories: categories),
                ),
              ),
              child: const Text("See All"),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((cat) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(cat["image"]!, fit: BoxFit.contain),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(cat["title"]!),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
