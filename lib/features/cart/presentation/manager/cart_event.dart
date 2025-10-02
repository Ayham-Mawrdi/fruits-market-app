import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCartEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final String itemId;
  final int quantity;

  const AddToCartEvent(this.itemId, this.quantity);

  @override
  List<Object?> get props => [itemId, quantity];
}

class RemoveFromCartEvent extends CartEvent {
  final String itemId;

  const RemoveFromCartEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class UpdateCartQuantityEvent extends CartEvent {
  final String itemId;
  final int quantity;

  const UpdateCartQuantityEvent(this.itemId, this.quantity);

  @override
  List<Object?> get props => [itemId, quantity];
}
