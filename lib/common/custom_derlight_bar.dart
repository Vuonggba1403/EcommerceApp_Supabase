import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:e_commerce_app_supabase/core/app_colors.dart';
import 'package:flutter/material.dart';

// Flag toàn cục để tránh toast chồng
bool _isShowingToast = false;

void showCustomDelightToastBar(
  BuildContext context,
  String message,
  Icon icon,
) {
  if (_isShowingToast) return; // đang có toast -> không show thêm

  _isShowingToast = true;

  DelightToastBar(
    builder: (context) {
      return ToastCard(
        color: AppColors.primaryColor,
        leading: icon,
        title: Text(
          message,
          style: const TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
            color: AppColors.secondColor,
            fontSize: 16,
          ),
        ),
      );
    },
    position: DelightSnackbarPosition.bottom,
    autoDismiss: true,
    snackbarDuration: const Duration(seconds: 2),
  ).show(context);

  Future.delayed(const Duration(seconds: 2), () {
    _isShowingToast = false;
  });
}
