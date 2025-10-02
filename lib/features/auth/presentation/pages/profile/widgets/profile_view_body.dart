import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:fruits_market/di/injection_container.dart' as di;
import 'package:fruits_market/features/auth/domain/repositories/auth_repo.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_bloc.dart';
import 'package:fruits_market/features/cart/presentation/pages/cart_page.dart';
import 'package:fruits_market/features/favourite/presentation/pages/favourite_view.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../../core/utils/sized_config.dart';
import '../../../../../../core/widgets/custom_profile_tile.dart';
import '../../../../../../core/widgets/help_page.dart';
import '../setting_page.dart';
import 'decoration_details_widget_with_bloc.dart';
import 'rate_us_dialog.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecorationDetailsWidgetWithBloc(),
        SizedBox(height: SizeConfig.screenHeight! * 0.03),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomProfileTile(
              icon: FeatherIcons.shoppingBag,
              title: 'My Orders',
              onTap: () {},
            ),
            CustomProfileTile(
              icon: FeatherIcons.heart,
              title: 'Favourites',
              onTap: () {
                Get.to(
                  BlocProvider.value(
                    value: context.read<CartBloc>(),
                    child: FavouriteView(),
                  ),
                  duration: Duration(milliseconds: 300),
                  transition: Transition.leftToRightWithFade,
                );
              },
            ),
            CustomProfileTile(
              icon: FeatherIcons.settings,
              title: 'Settings',
              onTap: () {
                Get.to(
                  SettingPage(),
                  duration: Duration(milliseconds: 300),
                  transition: Transition.leftToRightWithFade,
                );
              },
            ),
            CustomProfileTile(
              icon: FeatherIcons.shoppingCart,
              title: 'My Cart',
              onTap: () {
                Get.to(
                  BlocProvider.value(
                    value: context.read<CartBloc>(),
                    child: CartPage(),
                  ),
                  duration: Duration(milliseconds: 300),
                  transition: Transition.leftToRightWithFade,
                );
              },
            ),
            CustomProfileTile(
              icon: FeatherIcons.star,
              title: 'Rate Us',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const RateUsDialog(),
                );
              },
            ),
            CustomProfileTile(
              onTap: () {
                const String message =
                    'Check out this amazing Fruits Market app! Download it now: [Your App Link]';
                SharePlus.instance.share(ShareParams(text: message));
              },
              icon: FeatherIcons.share2,
              title: 'Share to Friend',
            ),

            CustomProfileTile(
              icon: FeatherIcons.helpCircle,
              title: 'Help',
              onTap: () {
                Get.to(
                  Help(),
                  duration: Duration(milliseconds: 300),
                  transition: Transition.leftToRightWithFade,
                );
              },
            ),
            CustomProfileTile(
              onTap: () async {
                await di.sl<AuthRepo>().signOut();
                Get.offAllNamed('/login');
              },
              icon: FeatherIcons.logOut,
              title: 'Log Out',
              iconColor: Colors.red,
              textColor: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}
