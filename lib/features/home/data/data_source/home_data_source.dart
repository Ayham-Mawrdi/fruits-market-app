import '../../domain/entities/item_entity.dart';
import '../../domain/entities/category.dart';

abstract class HomeDataSource {
  Future<List<ItemEntity>> getItemsByCategory(Category category);
}

class HomeDataSourceImpl implements HomeDataSource {
  @override
  Future<List<ItemEntity>> getItemsByCategory(Category category) async {
    // Simulate async (e.g., API delay)
    await Future.delayed(const Duration(milliseconds: 500));

    // Filter static items by category
    return ItemEntity.items
        .where((item) => item.category.toLowerCase() == category.name.toLowerCase())
        .toList();
  }
}