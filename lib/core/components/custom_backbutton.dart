import 'package:flutter/material.dart';

class CustomBackbutton extends StatelessWidget {
  const CustomBackbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        minimumSize: const Size(50, 50),
        shape: const CircleBorder(),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back_ios, color: Colors.black),
    );
  }
}
