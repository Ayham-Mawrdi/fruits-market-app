import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../utils/sized_config.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: SizeConfig.screenHeight! * 0.05,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          prefixIcon: Icon(FeatherIcons.search, color: kMainColor),
        ),
      ),
    );
  }
}