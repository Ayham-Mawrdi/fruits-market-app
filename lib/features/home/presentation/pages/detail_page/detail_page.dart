import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import '../../../../../core/widgets/custom_bottons.dart';
import '../../../../../core/utils/sized_config.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../domain/entities/item_entity.dart';
import '../../../../cart/presentation/manager/cart_bloc.dart';
import '../../../../cart/presentation/manager/cart_event.dart';
import '../../../../../../di/injection_container.dart';
import 'widgets/item_details_widget.dart';
import 'widgets/nutrition_widget.dart';

class DetailPage extends StatefulWidget {
  final ItemEntity item;
  final CartBloc? cartBloc;
  const DetailPage({super.key, required this.item, this.cartBloc});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final CartBloc _cartBloc;

  @override
  void initState() {
    super.initState();
    _cartBloc = widget.cartBloc ?? sl<CartBloc>();
  }

  List<String> get nutritionTitles => widget.item.nutritionTitles.isNotEmpty
      ? widget.item.nutritionTitles.cast<String>()
      : ['Calories', 'Vitamins', 'Minerals', 'Fiber', 'Protein'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(
        leadingIcon: Icon(FeatherIcons.arrowLeft, color: Colors.white),
        title: 'Details',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemDetailsWidget(item: widget.item),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nutrition',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...nutritionTitles.map(
                    // Dynamic list for easier maintenance
                    (title) => NutritionWidget(title: title),
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.05),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: Text(
                          'Price:  ${widget.item.price}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      CustomGeneralButton(
                        width: SizeConfig.screenWidth! * 0.4,
                        text: 'Buy Now',
                        onTap: () {
                          _cartBloc.add(
                            AddToCartEvent(widget.item.id, 1),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${widget.item.name} added to cart')),
                          );
                        },
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
  }
}
