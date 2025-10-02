import 'package:fruits_market/features/cart/domain/entities/cart_item_entity.dart';
import 'package:fruits_market/features/cart/domain/repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<void> call(CartItemEntity item) async {
    await repository.addToCart(item);
  }
}
