import 'package:flutter/material.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_bloc.dart';

import '../../../../../../core/utils/sized_config.dart';
import '../../../../domain/entities/item_entity.dart';
import 'fruits_items_scroll_horizontal.dart';
import 'title_items.dart';

class BuildSectionContent extends StatelessWidget {
  final String title1;
  final String subtitle1;
  final String title2;
  final String subtitle2;
  final List<ItemEntity> items;
  final CartBloc cartBloc;
  const BuildSectionContent({
    super.key,
    required this.title1,
    required this.subtitle1,
    required this.title2,
    required this.subtitle2,
    required this.items,
    required this.cartBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleItems(title: title1, subtitle: subtitle1),
        const SizedBox(height: 20),
        FruitsItemsScrollHorizontal(items: items, cartBloc: cartBloc),
        SizedBox(height: SizeConfig.screenHeight! * 0.03),
        TitleItems(title: title2, subtitle: subtitle2),
        const SizedBox(height: 20),
        FruitsItemsScrollHorizontal(items: items, cartBloc: cartBloc),
      ],
    );
  }
}
