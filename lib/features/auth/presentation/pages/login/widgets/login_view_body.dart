import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fruits_market/di/injection_container.dart'; // For sl<>
import 'package:fruits_market/features/auth/domain/repositories/auth_repo.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/sized_config.dart';
import '../../../../../../core/widgets/custom_bottons.dart';
import '../../../../../../core/widgets/space_widget.dart';
import '../../../../../home/presentation/pages/mainPage/main_page_view.dart';
import '../../../manager/login_cubit/login_cubit.dart';
import '../../../manager/login_cubit/login_state.dart';
import '../../complete_information/complete_information.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Fixed: Use sl<AuthRepo>() (abstract type) and remove invalid ..authRepo
      create: (context) => LoginCubit(authRepo: sl<AuthRepo>()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // Navigate to main page on successful login
            Get.offAll(
              () => const MainpageView(),
              duration: const Duration(milliseconds: 500),
              transition: Transition.rightToLeft,
            );
          } else if (state is LoginFailure) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const VerticalSpace(10),
                Center(
                  child: Image(
                    image: const AssetImage('assets/images/logo.png'),
                    height: SizeConfig.defaultSize! * 17,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 51,
                      color: Color(0xff69a03a),
                    ),
                    children: [
                      const TextSpan(
                        text: 'F',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const TextSpan(
                        text: 'ruit Market',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textHeightBehavior: const TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                  ),
                  textAlign: TextAlign.left,
                ),
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CustomButtonWithIcon(
                          onTap: () {
                            // Improved: Use cubit's loading state or flag to prevent multiple taps
                            final cubit = context.read<LoginCubit>();
                            if (cubit.state is! LoginLoading) {
                              // Or: if (!cubit.isLoading)
                              cubit.signInWithGoogle();
                            }
                          },
                          color: const Color(0xFFdb3236),
                          iconData: FontAwesomeIcons.googlePlusG,
                          text: state is LoginLoading
                              ? 'Loading...'
                              : 'Log in with Google', // Fixed: More specific text
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CustomButtonWithIcon(
                          onTap: () {
                            // For now, navigates to complete info (as in your code)
                            Get.to(
                              () => CompleteInformation(),
                              duration: const Duration(milliseconds: 500),
                              transition: Transition.rightToLeft,
                            );
                          },
                          color: const Color(0xFF4267B2),
                          iconData: FontAwesomeIcons.facebookF,
                          text:
                              'Log in with Facebook', // Fixed: More specific text
                        ),
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          );
        },
      ),
    );
  }
}
