import 'package:hive_flutter/hive_flutter.dart';

import 'package:fruits_market/core/utils/hive_service.dart';
import 'package:fruits_market/features/cart/domain/entities/cart_item_entity.dart';
import 'package:fruits_market/features/cart/domain/repositories/cart_repository.dart';
import 'package:fruits_market/features/home/domain/entities/item_entity.dart';
import 'package:fruits_market/features/cart/data/models/cart_item_model.dart';

class CartRepositoryImpl implements CartRepository {
  final HiveService hiveService;

  CartRepositoryImpl(this.hiveService);

  Future<Box<CartItemModel>> get cartBox async => await hiveService.getCartBox();

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    try {
      final box = await cartBox;
      final models = box.values.toList();
      return models.map((model) {
        final item = ItemEntity.items.firstWhere((i) => i.id == model.itemId);
        return CartItemEntity(item: item, quantity: model.quantity);
      }).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> addToCart(CartItemEntity item) async {
    try {
      final box = await cartBox;
      final existing = box.get(item.item.id);
      if (existing != null) {
        final updatedQuantity = existing.quantity + item.quantity;
        final updatedModel = CartItemModel(itemId: item.item.id, quantity: updatedQuantity);
        await box.put(item.item.id, updatedModel);
      } else {
        final model = CartItemModel(itemId: item.item.id, quantity: item.quantity);
        await box.put(item.item.id, model);
      }
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  @override
  Future<void> removeFromCart(String itemId) async {
    try {
      final box = await cartBox;
      await box.delete(itemId);
    } catch (e) {
      throw Exception('Failed to remove from cart: $e');
    }
  }

  @override
  Future<void> updateQuantity(String itemId, int quantity) async {
    try {
      final box = await cartBox;
      final existing = box.get(itemId);
      if (existing != null) {
        final updatedModel = CartItemModel(itemId: itemId, quantity: quantity);
        await box.put(itemId, updatedModel);
      }
    } catch (e) {
      throw Exception('Failed to update quantity: $e');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      final box = await cartBox;
      await box.clear();
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }
}
