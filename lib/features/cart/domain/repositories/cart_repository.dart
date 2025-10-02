import 'package:fruits_market/features/cart/domain/entities/cart_item_entity.dart';

abstract class CartRepository {
  Future<List<CartItemEntity>> getCartItems();
  Future<void> addToCart(CartItemEntity item);
  Future<void> removeFromCart(String itemId);
  Future<void> updateQuantity(String itemId, int quantity);
  Future<void> clearCart();
}
