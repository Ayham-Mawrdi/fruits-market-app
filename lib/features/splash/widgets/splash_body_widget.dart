import 'package:flutter/material.dart';
import 'package:fruits_market/core/utils/app_preferences.dart';
import 'package:fruits_market/features/auth/presentation/pages/login/login_view.dart';
import 'package:get/get.dart';

import '../../../core/utils/sized_config.dart';
import '../../onBoard/presentation/on_boarding_view.dart';

class SplashBodyWidget extends StatefulWidget {
  const SplashBodyWidget({super.key});

  @override
  State<SplashBodyWidget> createState() => _SplashBodyWidgetState();
}

class _SplashBodyWidgetState extends State<SplashBodyWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;
  @override
  void initState() {
    _navigateAfterDelay();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    fadingAnimation = Tween<double>(
      begin: 0.2,
      end: 1,
    ).animate(animationController!);
    animationController?.repeat(reverse: true);

    super.initState();
  }

  Future<void> _navigateAfterDelay() async {
    // Show splash for 2-3 seconds
    await Future.delayed(const Duration(seconds: 2));

    // Check first launch flag
    final isFirst = await AppPreferences.isFirstLaunch();
    if (isFirst) {
      // First time: Go to Onboarding
      Get.off(
        () => const OnBoardingView(),
        duration: const Duration(milliseconds: 500),
        transition: Transition.fadeIn,
      );
    } else {
      // Returning: Go to Login
      Get.off(
        () => const LoginView(),
        duration: const Duration(milliseconds: 500),
        transition: Transition.fadeIn,
      );
    }
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          FadeTransition(
            opacity: fadingAnimation!,
            child: Text(
              'Fruit Market',
              style: TextStyle(
                fontSize: 51,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff),
              ),
            ),
          ),

          Image.asset("assets/images/splash_view_image.png", fit: BoxFit.cover),
        ],
      ),
    );
  }
}
