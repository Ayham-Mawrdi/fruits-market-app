import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_market/features/cart/domain/entities/cart_item_entity.dart';
import 'package:fruits_market/features/cart/domain/use_cases/add_to_cart_usecase.dart';
import 'package:fruits_market/features/cart/domain/use_cases/get_cart_items_usecase.dart';
import 'package:fruits_market/features/cart/domain/use_cases/remove_from_cart_usecase.dart';
import 'package:fruits_market/features/cart/domain/use_cases/update_cart_quantity_usecase.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_event.dart';
import 'package:fruits_market/features/cart/presentation/manager/cart_state.dart';
import 'package:fruits_market/features/home/domain/entities/item_entity.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartItemsUseCase getCartItemsUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateCartQuantityUseCase updateCartQuantityUseCase;

  CartBloc({
    required this.addToCartUseCase,
    required this.getCartItemsUseCase,
    required this.removeFromCartUseCase,
    required this.updateCartQuantityUseCase,
  }) : super(CartLoading()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartQuantityEvent>(_onUpdateQuantity);
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final items = await getCartItemsUseCase();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    try {
      final item = ItemEntity.items.firstWhere((i) => i.id == event.itemId);
      await addToCartUseCase(
        CartItemEntity(item: item, quantity: event.quantity),
      );
      final updatedItems = await getCartItemsUseCase();
      emit(CartLoaded(updatedItems));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    try {
      await removeFromCartUseCase(event.itemId);
      final updatedItems = await getCartItemsUseCase();
      emit(CartLoaded(updatedItems));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onUpdateQuantity(UpdateCartQuantityEvent event, Emitter<CartState> emit) async {
    try {
      await updateCartQuantityUseCase(event.itemId, event.quantity);
      final updatedItems = await getCartItemsUseCase();
      emit(CartLoaded(updatedItems));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
