import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../entities/user_profile_entity.dart';

abstract class AuthRepo {

  // New: Profile management
  Future<Either<Exception, void>> saveUserProfile(UserProfileEntity profile);
  Future<Either<Exception, UserProfileEntity?>> getUserProfile(String uid);
  Future<Either<Exception, void>> updateUserProfile(UserProfileEntity profile);
  Future<Either<Exception, UserCredential>> signInWithGoogle();
  Future sginInWihFacebook();
  Future completeInformation({
    @required String name,
    @required String phoneNumber,
    @required String address,
  });

  Future<void> signOut();
}
