import 'package:dartz/dartz.dart'; // For Either<Failure, List<ItemEntity>> (add dartz package)

import '../../../../core/errors/failure.dart';
import '../entities/category.dart';
import '../entities/item_entity.dart';
import '../repositories/home_repository.dart';

class GetItemsByCategoryUseCase {
  final HomeRepository repository;

  GetItemsByCategoryUseCase(this.repository);

  Future<Either<Failure, List<ItemEntity>>> call(Category category) async {
    return await repository.getItemsByCategory(category);
  }
}