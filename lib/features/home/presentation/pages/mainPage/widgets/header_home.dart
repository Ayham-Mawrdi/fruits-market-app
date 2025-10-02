import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/constant.dart';
import '../../../../../../core/utils/sized_config.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight! * 0.140,
      decoration: const BoxDecoration(color: kMainColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fruit Market',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                Icon(FeatherIcons.bell, color: Colors.white, size: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
