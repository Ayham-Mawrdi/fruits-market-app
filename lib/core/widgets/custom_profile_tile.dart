import 'package:flutter/material.dart';

import '../constant.dart';
import '../utils/sized_config.dart';

class CustomProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback? onTap;
  const CustomProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.iconColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0), // Space between tiles
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1.2),
        ),

        color: Colors.white,
      ),
      child: ListTile(
        style: ListTileStyle.list,
        dense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth! * 0.07,
          vertical: 5.0,
        ),
        leading: Icon(icon, color: iconColor ?? kMainColor, size: 24),
        hoverColor: kMainColor,
        minLeadingWidth: SizeConfig.screenWidth! * 0.07,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: textColor ?? Colors.black87,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
