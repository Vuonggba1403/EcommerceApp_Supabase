import 'package:e_commerce_app_superbase/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      prefixIcon: const Icon(Icons.search),
      hintText: "Search",
      keyboardType: TextInputType.text,
    );
  }
}
