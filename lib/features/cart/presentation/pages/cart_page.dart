import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_market/core/utils/sized_config.dart';
import 'package:fruits_market/core/widgets/custom_bottons.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_bloc.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_event.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_state.dart';
import 'package:fruits_market/core/constant.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:get/get.dart';
import 'credit_card_page.dart';
import 'package:fruits_market/features/cart/domain/entities/cart_item_entity.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCartEvent());
  }

  double _calculateTotal(List<CartItemEntity> cartItems) {
    double total = 0;
    for (var item in cartItems) {
      total += item.totalPrice;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: kMainColor,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            final cartItems = state.cartItems;
            if (cartItems.isEmpty) {
              return const Center(child: Text('Your cart is empty.'));
            }
            final totalPrice = _calculateTotal(cartItems);
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return Card(
                        color: Colors.white,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.only(bottom: 25),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.width * 0.25,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      cartItem.item.image ?? '',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: SizeConfig.screenWidth! * 0.01),
                              // Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          cartItem.item.name ?? '',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context.read<CartBloc>().add(
                                              RemoveFromCartEvent(
                                                cartItem.item.id,
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            FeatherIcons.trash2,
                                            color: Colors.black,
                                            size: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      cartItem.item.category.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      cartItem.item.price,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: kMainColor,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Minus Button
                                        InkWell(
                                          onTap: () {
                                            if (cartItem.quantity > 1) {
                                              context.read<CartBloc>().add(
                                                UpdateCartQuantityEvent(
                                                  cartItem.item.id,
                                                  cartItem.quantity - 1,
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                MaterialIcons.remove,
                                                color: Colors.black,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeConfig.screenWidth! * 0.04,
                                        ),
                                        // Quantity Display
                                        Text(
                                          '${cartItem.quantity}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeConfig.screenWidth! * 0.04,
                                        ),
                                        // Plus Button
                                        InkWell(
                                          onTap: () {
                                            context.read<CartBloc>().add(
                                              UpdateCartQuantityEvent(
                                                cartItem.item.id,
                                                cartItem.quantity + 1,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
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
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: \$${totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      CustomGeneralButton(
                        text: 'Place Order',
                        width: SizeConfig.screenWidth! * 0.35,
                        onTap: () {
                          Get.to(() => CreditCardPage(total: totalPrice));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is CartError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}
