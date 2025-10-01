import 'package:e_commerce_app_supabase/common/custom_backbutton.dart'
    show CustomBackbutton;
import 'package:e_commerce_app_supabase/common/custom_card.dart';
import 'package:e_commerce_app_supabase/views/home/ui/widgets/categories/categori_details_screen.dart';
import 'package:flutter/material.dart';

class AllCategories extends StatelessWidget {
  const AllCategories({super.key, required this.categories});

  final List<Map<String, String>> categories;

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
              CustomBackbutton(),
              SizedBox(height: size.height * 0.02),
              Text(
                "Shop by Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoriesDetailView(category: cat),
                        ),
                      ),
                      child: CustomCard(
                        img: Image.asset(cat["image"]!),
                        text: cat["title"]!,
                      ),
                    );
                  },
                  itemCount: categories.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
