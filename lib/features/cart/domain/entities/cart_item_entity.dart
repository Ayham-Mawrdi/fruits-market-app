import 'package:equatable/equatable.dart';
import 'package:fruits_market/features/home/domain/entities/item_entity.dart';

class CartItemEntity extends Equatable {
  final ItemEntity item;
  final int quantity;

  const CartItemEntity({
    required this.item,
    required this.quantity,
  });

  CartItemEntity copyWith({
    ItemEntity? item,
    int? quantity,
  }) {
    return CartItemEntity(
      item: item ?? this.item,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice {
    // Assuming price is like '$2.00 per/kg', parse it
    final priceString = item.price.replaceAll('\$', '').split(' ')[0];
    final price = double.tryParse(priceString) ?? 0.0;
    return price * quantity;
  }

  @override
  List<Object?> get props => [item, quantity];
}
