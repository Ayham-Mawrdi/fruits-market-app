

import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  @override List<Object> get props => [];
}

class ToggleFavoriteEvent extends FavoritesEvent {
  final String itemId;
  const ToggleFavoriteEvent(this.itemId);
  @override List<Object> get props => [itemId];
}

class LoadFavoritesEvent extends FavoritesEvent {}