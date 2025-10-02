import 'package:dartz/dartz.dart';
import 'package:fruits_market/core/errors/failure.dart';
import 'package:fruits_market/features/home/domain/repositories/favorites_repository.dart';

class ToggleFavoriteUseCase {
  final FavoritesRepository repository;

  const ToggleFavoriteUseCase(this.repository);

  Future<Either<Failure, bool>> call(String itemId) async {
    try {
      final isCurrentlyFavoriteResult = await repository.isFavorite(itemId);
      return isCurrentlyFavoriteResult.fold((failure) => Left(failure), (
        isCurrentlyFavorite,
      ) async {
        if (isCurrentlyFavorite) {
          await repository.removeFromFavorites(itemId);
        } else {
          await repository.addToFavorites(itemId);
        }
        return Right(!isCurrentlyFavorite); // New state
      });
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
  //this use is to toggle the favorite status of an item by its ID. It checks if the item is currently a favorite and adds or removes it accordingly, returning the new favorite status.