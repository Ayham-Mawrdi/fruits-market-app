import 'package:flutter/material.dart';

class TextCategoriesStrip extends StatelessWidget {
  final String fTitle;
  final String sTitle;
  final String tTitle;
  final int selectedIndex;
  final Function(int) onTap;

  const TextCategoriesStrip({
    super.key,
    required this.fTitle,
    required this.sTitle,
    required this.tTitle,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTab(0, fTitle),
        _buildTab(1, sTitle),
        _buildTab(2, tTitle),
      ],
    );
  }

  Widget _buildTab(int index, String title) {
    final isSelected = index == selectedIndex;
    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber.shade300 : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}
