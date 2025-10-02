import 'package:flutter/cupertino.dart';

import '../utils/sized_config.dart';

class HorizintalSpace extends StatelessWidget {
  const HorizintalSpace(this.value, {super.key}) ;
 final double? value;
  @override 
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.defaultSize! * value!,
    );
  }
}

class VerticalSpace extends StatelessWidget {
  const VerticalSpace(this.value, {super.key}) ;
 final double? value;
  @override 
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.defaultSize! * value!,
    );
  }
}