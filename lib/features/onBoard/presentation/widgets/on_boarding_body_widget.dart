import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_preferences.dart';
import '../../../../core/utils/sized_config.dart';
import '../../../../core/widgets/custom_bottons.dart';
import '../../../auth/presentation/pages/login/login_view.dart';
import 'custom_indicator_wideget.dart';
import 'custom_page_view.dart';

class OnBoardingBodyWidget extends StatefulWidget {
  const OnBoardingBodyWidget({super.key});

  @override
  State<OnBoardingBodyWidget> createState() => _OnBoardingBodyWidgetState();
}

class _OnBoardingBodyWidgetState extends State<OnBoardingBodyWidget> {
  PageController? pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPageView(pageController: pageController),
        Positioned(
          left: SizeConfig.defaultSize! * 18,
          right: SizeConfig.defaultSize! * 25,
          bottom: SizeConfig.defaultSize! * 25,
          child: CustomIndicatorWideget(controller: pageController!),
        ),

        Positioned(
          top: SizeConfig.defaultSize! * 10,
          right: 32,
          child: Text(
            'Skip',
            style: TextStyle(fontSize: 14, color: Color(0xff898989)),
          ),
        ),
        Positioned(
          bottom: SizeConfig.defaultSize! * 10,
          left: SizeConfig.defaultSize! * 10,
          right: SizeConfig.defaultSize! * 10,
          child: CustomGeneralButton(
            text: 'Next',
            onTap: () async {
              if (pageController!.page! < 2) {
                pageController!.nextPage(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeIn,
                );
              } else {
                await AppPreferences.setOnboardingCompleted(); 
                Get.to(
                  
                  () => LoginView(),
                  transition: Transition.rightToLeft,
                  duration: Duration(milliseconds: 500),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
