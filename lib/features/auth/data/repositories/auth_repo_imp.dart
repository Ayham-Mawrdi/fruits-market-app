import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data_sources/local_data_source/local_data_source.dart';
import '../data_sources/remote_data_source/firebase_auth_data_source.dart';
import '../data_sources/remote_data_source/firebase_user_data_source.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/entities/user_profile_entity.dart';
import '../../domain/repositories/auth_repo.dart';

import '../../../../core/utils/hive_service.dart';

class AuthRepoImp implements AuthRepo {
  final FirebaseAuthDataSource _authDataSource;
  final FirebaseUserDataSource _userDataSource;
  final LocalDataSource _localDataSource;
  final HiveService _hiveService;

  AuthRepoImp(
    this._authDataSource,
    this._userDataSource,
    this._localDataSource,
    this._hiveService,
  );

  @override
  Future<Either<Exception, UserCredential>> signInWithGoogle() async {
    try {
      final credential = await _authDataSource.signInWithGoogle();

      // Auto-save profile after successful sign-in
      final user = credential.user;
      if (user != null) {
        final profile = UserProfileEntity.fromFirebaseUser(user);
        await _saveProfile(profile); // Saves to Firestore + local cache

        // Set user ID in HiveService and open user-specific boxes
        _hiveService.setUserId(user.uid);
        await _hiveService.getFavoritesBox();
        await _hiveService.getCartBox();
      }

      return Right(credential);
    } catch (e) {
      return Left(Exception('Sign-in failed: ${e.toString()}'));
    }
  }

  // Helper: Save to both remote and local
  Future<void> _saveProfile(UserProfileEntity profile) async {
    await _userDataSource.saveUserProfile(profile);
    await _localDataSource.cacheUserProfile(profile);
  }

  @override
  Future<Either<Exception, void>> saveUserProfile(
    UserProfileEntity profile,
  ) async {
    try {
      await _saveProfile(profile);
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to save profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, UserProfileEntity?>> getUserProfile(
    String uid,
  ) async {
    try {
      // Try local cache first (fast/offline)
      var profile = await _localDataSource.getCachedUserProfile();
      if (profile == null || profile.uid != uid) {
        // Fallback to Firestore
        profile = await _userDataSource.getUserProfile(uid);
        if (profile != null) {
          await _localDataSource.cacheUserProfile(profile); // Update cache
        }
      }
      return Right(profile);
    } catch (e) {
      return Left(Exception('Failed to get profile: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Exception, void>> updateUserProfile(
    UserProfileEntity profile,
  ) async {
    try {
      await _userDataSource.updateUserProfile(profile);
      await _localDataSource.cacheUserProfile(profile); // Update cache
      return const Right(null);
    } catch (e) {
      return Left(Exception('Failed to update profile: ${e.toString()}'));
    }
  }

  @override
  Future<void> completeInformation({
    String? name,
    String? phoneNumber,
    String? address,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("No authenticated user found.");
    }

    // Await the result first
    final result = await getUserProfile(user.uid);

    // Now safely fold the Either
    final currentProfile = result.fold(
      (failure) => null, // left = failure
      (profile) => profile, // right = success
    );

    final updatedProfile = UserProfileEntity(
      uid: user.uid,
      name: name ?? currentProfile?.name ?? user.displayName ?? 'Unknown',
      email: user.email ?? '',
      phoneNumber: phoneNumber ?? currentProfile?.phoneNumber,
      address: address ?? currentProfile?.address,
    );

    await updateUserProfile(updatedProfile);
  }

  // Add logout if needed
  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn.instance.signOut();
    await _localDataSource.clearCachedUserProfile();
    await _hiveService.closeBoxes();
    _hiveService.clearUserId();
  }

  @override
  Future sginInWihFacebook() {
    throw UnimplementedError();
  }
}
