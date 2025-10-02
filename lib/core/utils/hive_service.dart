import 'package:hive_flutter/hive_flutter.dart';
import 'package:fruits_market/features/cart/data/models/cart_item_model.dart';

class HiveService {
  String? _userId;

  void setUserId(String userId) {
    _userId = userId;
  }

  Future<Box<String>> getFavoritesBox() async {
    if (_userId == null) throw Exception('User not set');
    return await Hive.openBox<String>('favorites_$_userId');
  }

  Future<Box<CartItemModel>> getCartBox() async {
    if (_userId == null) throw Exception('User not set');
    return await Hive.openBox<CartItemModel>('cart_$_userId');
  }

  Future<void> closeBoxes() async {
    if (_userId != null) {
      final favBox = Hive.box<String>('favorites_$_userId');
      if (favBox.isOpen) await favBox.close();
      final cartBox = Hive.box<CartItemModel>('cart_$_userId');
      if (cartBox.isOpen) await cartBox.close();
    }
  }

  void clearUserId() {
    _userId = null;
  }
}
