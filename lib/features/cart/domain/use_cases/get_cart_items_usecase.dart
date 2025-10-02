import 'package:fruits_market/features/cart/domain/entities/cart_item_entity.dart';
import 'package:fruits_market/features/cart/domain/repositories/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository repository;

  GetCartItemsUseCase(this.repository);

  Future<List<CartItemEntity>> call() async {
    return await repository.getCartItems();
  }
}
