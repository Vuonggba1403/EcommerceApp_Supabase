import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final Color selectedColor;
  final List<Color> colors;
  final ValueChanged<Color> onSelect;

  const ColorSelector({
    super.key,
    required this.selectedColor,
    required this.colors,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Row(
          children: colors.map((color) {
            final isSelected = selectedColor == color;
            return GestureDetector(
              onTap: () => onSelect(color),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Colors.black
                        : Colors.grey.withOpacity(0.3),
                    width: isSelected ? 3 : 1,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
