import 'package:flutter/material.dart';

import '../constant.dart'; // Import your constants (e.g., kMainColor)

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget
  leadingIcon; // Pass the icon widget (e.g., Icon(FeatherIcons.arrowLeft))
  final List<Widget>?
  actions; // Optional: For adding trailing actions (e.g., search, cart icons)
  final Function()? onPressed;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.leadingIcon,
    this.onPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed:
            onPressed ??
            () => Navigator.pop(context), // Default back navigation
        icon: leadingIcon,
      ),
      backgroundColor: kMainColor,
      title: Text(
        title!,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions, // Optional trailing widgets
      elevation: 0, // Optional: Remove shadow for a cleaner look
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Required for PreferredSizeWidget
}
