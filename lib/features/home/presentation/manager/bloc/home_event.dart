
part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class CategorySelected extends HomeEvent {
  final Category category;

  const CategorySelected(this.category);

  @override
  List<Object> get props => [category];
}