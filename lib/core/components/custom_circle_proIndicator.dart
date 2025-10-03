import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCircleProgIndicator extends StatelessWidget {
  const CustomCircleProgIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.primaryColor),
    );
  }
}
