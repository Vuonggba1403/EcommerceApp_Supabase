import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Image? image;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.image,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: const Size(double.infinity, 60),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (image != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: image!,
              ),
            ),

          Text(
            text,
            style: const TextStyle(fontSize: 16, fontFamily: "CircularStd"),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
