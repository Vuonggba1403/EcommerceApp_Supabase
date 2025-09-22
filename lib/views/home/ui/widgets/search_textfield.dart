import 'package:e_commerce_app_superbase/common/custom_textfield.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      prefixIcon: const Icon(Icons.search),
      hintText: "Search",
      keyboardType: TextInputType.text,
    );
  }
}
