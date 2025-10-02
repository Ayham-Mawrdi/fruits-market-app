import 'package:dartz/dartz.dart';
import 'package:fruits_market/features/home/domain/entities/category.dart';

import '../../../../core/errors/failure.dart';
import '../entities/item_entity.dart';
import '../repositories/favorites_repository.dart';
import '../repositories/home_repository.dart';

class GetFavoritesUseCase {
  final FavoritesRepository repository;
  final HomeRepository homeRepository;

  const GetFavoritesUseCase(this.repository, this.homeRepository);

  Future<Either<Failure, List<ItemEntity>>> call() async {
    // Step 1: Get favorite IDs from local storage
    final idsResult = await repository.getFavoriteIds();
    return idsResult.fold(
      (failure) => Future.value(Left(failure)), // Sync wrap for fold
      (ids) => _getFavoritesFromIds(ids),
    );
  }






  // Helper: Async method to fetch full items from IDs



  
  Future<Either<Failure, List<ItemEntity>>> _getFavoritesFromIds(
    List<String> ids,
  ) async {
    if (ids.isEmpty) {
      return const Right([]); // Early return for no favorites
    }

    // Step 2: Fetch ALL items across categories (since we don't have getAllItems yet)
    // Call getItemsByCategory for each category and combine
    List<ItemEntity> allItems = [];
    final allCategories = [
      Category.fruits,
      Category.vegetables,
      Category.organic,
    ];

    for (final category in allCategories) {
      final categoryResult = await homeRepository.getItemsByCategory(category);
      categoryResult.fold(
        (failure) {
          // Handle per-category failure (e.g., log it; continue with other categories)
          // You could aggregate errors: e.g., return Left if any critical failure
        },
        (items) {
          allItems.addAll(items); 
        },
      );
    }

    if (allItems.isEmpty) {
      return const Right([]); 
    }

    
    final favorites = allItems.where((item) => ids.contains(item.id)).toList();

    return Right(favorites);
  }
}
