import 'package:flutter/material.dart';
import '../../../../core/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomIndicatorWideget extends StatelessWidget {
  const CustomIndicatorWideget({super.key, required this.controller});
 final PageController controller;
  @override
  Widget build(BuildContext context) {
    return  SmoothPageIndicator(
            controller: controller, // your PageController
            count: 3,
            effect: CustomizableEffect(

              // INACTIVE dots: transparent fill + border
              dotDecoration: DotDecoration(
                width: 10,
                height: 10,
                color: Colors.transparent, // no fill
                borderRadius: BorderRadius.circular(50), // circle
                dotBorder: DotBorder(
                  color: kMainColor, // border color
                  width: 1, // border thickness
                ),
              ),

              // ACTIVE dot: filled with kMainColor
              activeDotDecoration: DotDecoration(
                width: 10,
                height: 10,
                color: kMainColor, // filled active dot
                borderRadius: BorderRadius.circular(50),
                // no dotBorder here (filled)
              ),
            ),
          );
  }
}