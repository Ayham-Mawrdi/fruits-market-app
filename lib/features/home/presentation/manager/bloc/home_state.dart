
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Category selectedCategory;
  final SectionEntity sectionModel;
  final List<ItemEntity> items;

  const HomeLoaded({
    required this.selectedCategory,
    required this.sectionModel,
    required this.items,
  });

  @override
  List<Object> get props => [selectedCategory, sectionModel, items];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}