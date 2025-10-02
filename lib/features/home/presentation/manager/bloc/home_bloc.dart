import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/entities/item_entity.dart';
import '../../../domain/entities/section_entity.dart';
import '../../../domain/use_cases/get_items_by_category_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetItemsByCategoryUseCase getItemsByCategoryUseCase;

  HomeBloc(this.getItemsByCategoryUseCase) : super(HomeInitial()) {
    on<CategorySelected>(_onCategorySelected);
  }

  Future<void> _onCategorySelected(
    CategorySelected event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final sectionModel = SectionEntity.getByCategory(event.category);
    final failureOrItems = await getItemsByCategoryUseCase(event.category);

    failureOrItems.fold(
      (failure) => emit(HomeError(failure.message)),
      (items) => emit(
        HomeLoaded(
          selectedCategory: event.category,
          sectionModel: sectionModel,
          items: items,
        ),
      ),
    );
  }
}
