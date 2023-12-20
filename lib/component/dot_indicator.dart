import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const DotIndicator({
    super.key,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
