import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/item_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ItemEntity>>> getItemsByCategory(
    Category category,
  );
}
