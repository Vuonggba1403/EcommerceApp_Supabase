import 'package:flutter/material.dart';
import 'package:e_commerce_app_supabase/core/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final Icon prefixIcon;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    this.isPassword = false,
    this.prefixIcon = const Icon(Icons.person),
    this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscure = false;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, // gắn controller vào đây
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please do not leave blank';
        }
        return null;
      },
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.thirdColor,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
          fontFamily: "CircularStd",
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              )
            : null,
      ),
    );
  }
}
