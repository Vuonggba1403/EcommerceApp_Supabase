import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_supabase/core/app_colors.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  const CacheImage({super.key, required this.url});

  final String url;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
