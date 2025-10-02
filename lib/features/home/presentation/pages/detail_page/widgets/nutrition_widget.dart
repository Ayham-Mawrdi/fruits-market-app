import 'package:flutter/material.dart';

import '../../../../../../core/constant.dart';
import '../../../../../../core/utils/sized_config.dart';

class NutritionWidget extends StatelessWidget {
  final String title;
  const NutritionWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.03),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: kMainColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(width: SizeConfig.screenWidth! * 0.05),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
