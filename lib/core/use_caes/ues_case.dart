import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

abstract class UseCase<type, Param> {
  Future<Either<Failure, type>> call([Param param]);
}

class NoParam {}
