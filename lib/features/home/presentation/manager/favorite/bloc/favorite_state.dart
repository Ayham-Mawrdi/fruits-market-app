


import 'package:equatable/equatable.dart';
import 'package:fruits_market/features/home/domain/entities/item_entity.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();
  @override List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesToggled extends FavoritesState {
  final String itemId;
  final bool isFavorite;
  const FavoritesToggled({required this.itemId, required this.isFavorite});
  @override List<Object> get props => [itemId, isFavorite];
}

class FavoritesLoaded extends FavoritesState {
  final List<ItemEntity> favorites;
  const FavoritesLoaded({required this.favorites});
  @override List<Object> get props => [favorites];
}

class FavoritesError extends FavoritesState {
  final String message;
  const FavoritesError(this.message);
  @override List<Object> get props => [message];
}