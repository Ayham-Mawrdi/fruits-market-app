// lib/domain/repositories/favorites_repository.dart
import 'package:dartz/dartz.dart';
import 'package:fruits_market/core/errors/failure.dart';

import '../entities/item_entity.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, void>> addToFavorites(String itemId);
  Future<Either<Failure, void>> removeFromFavorites(String itemId);
  Future<Either<Failure, bool>> isFavorite(String itemId);
  Future<Either<Failure, List<String>>> getFavoriteIds();
  Future<Either<Failure, List<ItemEntity>>> getFavorites();
}
