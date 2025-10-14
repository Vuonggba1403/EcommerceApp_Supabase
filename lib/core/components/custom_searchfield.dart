import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:e_commerce_app_supabase/core/functions/navigate_to.dart';
import 'package:e_commerce_app_supabase/views/home/logic/cubit/home_cubit.dart';
import 'package:e_commerce_app_supabase/views/home/ui/widgets/search_view.dart';
import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.controller,
    this.onPressed,
    required this.homeCubit, // Thêm tham số này
  });

  final TextEditingController? controller;
  final void Function()? onPressed;
  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'search_field',
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => navigateTo(
            context,
            SearchView(
              query: controller?.text ?? '',
              homeCubit: homeCubit, // Truyền homeCubit
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.borderColor, width: 2),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    controller?.text.isNotEmpty == true
                        ? controller!.text
                        : "Search ...",
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.thirdColor,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
