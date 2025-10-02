import 'package:dartz/dartz.dart';
import '../entities/user_profile_entity.dart';
import '../repositories/auth_repo.dart';

class SaveUserProfileUseCase {
  final AuthRepo _repo;

  SaveUserProfileUseCase(this._repo);

  Future<Either<Exception, void>> call(UserProfileEntity profile) {
    return _repo.saveUserProfile(profile);
  }
}