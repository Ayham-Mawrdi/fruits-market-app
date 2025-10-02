
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_bloc.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_bloc.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_event.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_state.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/sized_config.dart';
import '../../../../domain/entities/item_entity.dart';
import '../../detail_page/detail_page.dart';

class FruitsItemsScrollHorizontal extends StatefulWidget {
  final List<ItemEntity> items;
  final CartBloc cartBloc;
  const FruitsItemsScrollHorizontal({super.key, required this.items, required this.cartBloc});

  @override
  State<FruitsItemsScrollHorizontal> createState() => _FruitsItemsScrollHorizontalState();
}

class _FruitsItemsScrollHorizontalState extends State<FruitsItemsScrollHorizontal> {
  Set<String> _favoriteIds = <String>{};

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesLoaded) {
          setState(() {
            _favoriteIds = state.favorites.map((e) => e.id).toSet();
          });
        } else if (state is FavoritesToggled) {
          setState(() {
            if (state.isFavorite) {
              _favoriteIds.add(state.itemId);
            } else {
              _favoriteIds.remove(state.itemId);
            }
          });
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: widget.items.map((item) {
                final bool isFavorite = _favoriteIds.contains(item.id);
                final int numStarsInt = int.tryParse(item.numStars ?? '0') ?? 0;
                return GestureDetector(
                  onTap: () {
                    Get.to(() => DetailPage(item: item, cartBloc: widget.cartBloc));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight! * 0.20,
                          width: SizeConfig.screenHeight! * 0.18,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(item.image ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Dispatch event – UI will update immediately via listener
                                      context.read<FavoritesBloc>().add(ToggleFavoriteEvent(item.id));
                                    },
                                    child: Icon(
                                      FeatherIcons.heart,
                                      color: isFavorite ? Colors.red : Colors.amber,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              FeatherIcons.star,
                              color: index < numStarsInt ? Colors.amber : Colors.grey,
                              size: 20,
                            );
                          }),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.name ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.price,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
