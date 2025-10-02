import 'package:flutter/material.dart';
import 'package:fruits_market/core/constant.dart';

class ListtileWithBorderUnder extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ListtileWithBorderUnder({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 8,
          ),
          leading: Icon(icon, color: kMainColor, size: 28),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.black87,
            ),
          ),

          onTap: onTap,
          shape: const RoundedRectangleBorder(), // No border here
          horizontalTitleGap: 25,
          minVerticalPadding: 16,
        ),
        const Divider(height: 1, thickness: 1, color: Colors.black12),
      ],
    );
  }
}
