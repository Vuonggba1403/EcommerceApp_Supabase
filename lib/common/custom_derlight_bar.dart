import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:e_commerce_app_superbase/core/app_colors.dart';
import 'package:flutter/material.dart';

void showCustomDelightToastBar(
  BuildContext context,
  String message,
  Icon icon,
) {
  DelightToastBar(
    builder: (context) {
      return ToastCard(
        color: AppColors.primaryColor,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              message,
              style: const TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
                color: AppColors.secondColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    },
    position: DelightSnackbarPosition.bottom,
    autoDismiss: true,
    snackbarDuration: const Duration(seconds: 2),
  ).show(context);
}
