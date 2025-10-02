import 'package:fruits_market/features/cart/domain/repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  Future<void> call(String itemId) async {
    await repository.removeFromCart(itemId);
  }
}
