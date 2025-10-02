import 'package:dartz/dartz.dart';
import 'package:fruits_market/core/errors/failure.dart';
import 'package:fruits_market/features/home/domain/entities/item_entity.dart';
import 'package:fruits_market/features/home/domain/repositories/favorites_repository.dart';
import 'package:fruits_market/features/home/domain/repositories/home_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:fruits_market/core/utils/hive_service.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final HiveService hiveService;
  final HomeRepository homeRepository; // To fetch full ItemEntity

  FavoritesRepositoryImpl({
    required this.hiveService,
    required this.homeRepository,
  });

  Future<Box<String>> get favoritesBox async => await hiveService.getFavoritesBox();

  @override
  Future<Either<Failure, void>> addToFavorites(String itemId) async {
    try {
      final box = await favoritesBox;
      if (!box.containsKey(itemId)) {
        await box.put(itemId, itemId);
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(String itemId) async {
    try {
      final box = await favoritesBox;
      await box.delete(itemId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Remove from favorites failed: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String itemId) async {
    try {
      final box = await favoritesBox;
      return Right(box.containsKey(itemId));
    } catch (e) {
      return Left(ServerFailure('Check favorite failed: $e'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getFavoriteIds() async {
    try {
      final box = await favoritesBox;
      return Right(box.keys.cast<String>().toList());
    } catch (e) {
      return Left(ServerFailure('Get favorites failed: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ItemEntity>>> getFavorites() async {
    final idsResult = await getFavoriteIds();
    return idsResult.fold((failure) => Left(failure), (ids) async {
      if (ids.isEmpty) return const Right([]);
      final allItemsResult = ItemEntity.items;
      return Right(
        allItemsResult.where((item) => ids.contains(item.id)).toList(),
      );
    });
  }
}
