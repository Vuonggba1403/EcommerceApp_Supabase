import 'package:flutter/material.dart';

class CardProfiles extends StatelessWidget {
  const CardProfiles({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(text), Icon(Icons.arrow_forward_ios)],
        ),
      ),
    );
  }
}
