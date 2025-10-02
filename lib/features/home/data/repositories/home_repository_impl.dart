import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/item_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_source/home_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource dataSource;

  HomeRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<ItemEntity>>> getItemsByCategory(
    Category category,
  ) async {
    try {
      final items = await dataSource.getItemsByCategory(category);
      return Right(items);
    } catch (e) {
      return Left(ServerFailure(e.toString())); // Or custom failure
    }
  }
 
}
