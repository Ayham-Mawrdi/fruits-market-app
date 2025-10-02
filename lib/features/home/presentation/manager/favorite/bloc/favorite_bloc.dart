import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_market/features/home/domain/use_cases/get_favorites_usecase.dart';
import 'package:fruits_market/features/home/domain/use_cases/toggle_favorite_usecase.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_event.dart';
import 'package:fruits_market/features/home/presentation/manager/favorite/bloc/favorite_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final ToggleFavoriteUseCase toggleFavoriteUseCase;
  final GetFavoritesUseCase getFavoritesUseCase;

  FavoritesBloc( {
    required this.toggleFavoriteUseCase,
    required this.getFavoritesUseCase,
  }) : super(FavoritesInitial()) {
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<LoadFavoritesEvent>(_onLoadFavorites);
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    final result = await toggleFavoriteUseCase(event.itemId);
    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (newIsFavorite) {
        emit(
          FavoritesToggled(itemId: event.itemId, isFavorite: newIsFavorite),
        );
        // Reload favorites after toggle
        add(LoadFavoritesEvent());
      },
    );
  }

  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    final result = await getFavoritesUseCase();
    result.fold(
      (failure) => emit(FavoritesError(failure.message)),
      (favorites) => emit(FavoritesLoaded(favorites: favorites)),
    );
  }
}
