import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_market/core/constant.dart';
import 'package:fruits_market/core/utils/sized_config.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_bloc.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_event.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_bloc.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_event.dart';
import 'package:fruits_market/features/home/domain/entities/item_entity.dart';
import 'package:icons_flutter/icons_flutter.dart'; 

class FavouriteBody extends StatefulWidget {
  final List<ItemEntity> favorites;
  const FavouriteBody({super.key, required this.favorites});

  @override
  State<FavouriteBody> createState() => _FavouriteBodyState();
}

class _FavouriteBodyState extends State<FavouriteBody> {
  late Map<String, int> _quantities; // Track quantity per item ID

  @override
  void initState() {
    super.initState();
    // Initialize quantities to 1 for each favorite item
    _quantities = {for (var item in widget.favorites) item.id: 1};
  }

  @override
  void didUpdateWidget(FavouriteBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-initialize if favorites list changes (e.g., after toggle)
    if (widget.favorites.length != oldWidget.favorites.length) {
      _quantities = {for (var item in widget.favorites) item.id: 1};
    }
  }

  // Handler for increasing quantity
  void _increaseQuantity(String itemId) {
    setState(() {
      _quantities[itemId] = (_quantities[itemId] ?? 1) + 1;
    });
  }

  // Handler for decreasing quantity (min 1)
  void _decreaseQuantity(String itemId) {
    setState(() {
      final currentQuantity = _quantities[itemId] ?? 1;
      if (currentQuantity > 1) {
        _quantities[itemId] = currentQuantity - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.favorites.length,
      itemBuilder: (context, index) {
        final item = widget.favorites[index];
        final numStarsInt = int.tryParse(item.numStars ?? '0') ?? 0;
        final currentQuantity =
            _quantities[item.id] ?? 1; // Get current quantity

        return Card(
          color: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Container(
                  width: SizeConfig.screenWidth! * 0.25,
                  height: SizeConfig.screenWidth! * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item.image ?? ''),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(
                      8,
                    ), // Optional: Rounded image
                  ),
                ),
                const SizedBox(width: 12),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.name ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Remove from favorites
                          GestureDetector(
                            onTap: () {
                              context.read<FavoritesBloc>().add(
                                ToggleFavoriteEvent(item.id),
                              );
                              // Optional: Remove quantity entry after toggle
                              setState(() {
                                _quantities.remove(item.id);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: Colors.red.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                MaterialIcons.favorite,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.category.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: List.generate(5, (starIndex) {
                          return Icon(
                            MaterialIcons.star,
                            color: starIndex < numStarsInt
                                ? Colors.amber
                                : Colors.grey,
                            size: 16,
                          );
                        }),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kMainColor,
                        ),
                      ),
                      // Description
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          item.description!.isEmpty
                              ? 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'
                              : item.description!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          // Minus Button
                          InkWell(
                            onTap: () => _decreaseQuantity(item.id),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Icon(
                                  MaterialIcons.remove,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Quantity Display
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '$currentQuantity',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Plus Button
                          InkWell(
                            onTap: () => _increaseQuantity(item.id),
                            child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: Icon(
                                  MaterialIcons.add,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: SizeConfig.screenWidth! * 0.1),
                          GestureDetector(
                            onTap: () {
                              final quantity = _quantities[item.id] ?? 1;
                              context.read<CartBloc>().add(
                                AddToCartEvent(item.id, quantity),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${item.name} added to cart')),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: kMainColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Add to Cart',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
