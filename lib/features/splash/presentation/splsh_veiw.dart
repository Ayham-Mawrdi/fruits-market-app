import 'package:flutter/material.dart';

import '../widgets/splash_body_widget.dart' ;

class SplshVeiw extends StatelessWidget {
  const SplshVeiw({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xff69A03A),
      body: SplashBodyWidget(),
    );
  }
}