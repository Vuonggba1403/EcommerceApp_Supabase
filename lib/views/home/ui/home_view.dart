import 'package:e_commerce_app_superbase/core/app_colors.dart';
import 'package:e_commerce_app_superbase/core/components/custom_search_textfield.dart';
import 'package:e_commerce_app_superbase/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedCategory = "Men";
  final categories = ["Men", "Women", "Kids"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Avatar
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage('assets/user_images.png'),
                    ),
                  ),
                  //Drop menu
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          // isExpanded: true,
                          value: selectedCategory,
                          items: categories.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value!;
                            });
                          },
                          icon: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ),
                    ),
                  ),
                  //Category icon
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                    child: Icon(
                      Icons.propane_tank_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomSearchField(),
            ],
          ),
        ),
      ),
    );
  }
}
