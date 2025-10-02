import 'package:dartz/dartz.dart';
import '../entities/user_profile_entity.dart';
import '../repositories/auth_repo.dart';

class GetUserProfileUseCase {
  final AuthRepo _repo;

  GetUserProfileUseCase(this._repo);

  Future<Either<Exception, UserProfileEntity?>> call(String uid) {
    return _repo.getUserProfile(uid);
  }
}