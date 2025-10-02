import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final String itemId;

  @HiveField(1)
  final int quantity;

  CartItemModel({required this.itemId, required this.quantity});
}
