import 'package:fruits_market/features/cart/domain/repositories/cart_repository.dart';

class UpdateCartQuantityUseCase {
  final CartRepository repository;

  UpdateCartQuantityUseCase(this.repository);

  Future<void> call(String itemId, int quantity) async {
    await repository.updateQuantity(itemId, quantity);
  }
}
