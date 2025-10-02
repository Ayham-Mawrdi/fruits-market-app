//data souce for user profile in firebase
//to get user profile from firebase
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/user_profile_entity.dart';

abstract class FirebaseUserDataSource {
  Future<void> saveUserProfile(UserProfileEntity profile);
  Future<UserProfileEntity?> getUserProfile(String uid);
  Future<void> updateUserProfile(UserProfileEntity profile);
}

class FirebaseUserDataSourceImpl implements FirebaseUserDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveUserProfile(UserProfileEntity profile) async {
    await _firestore
        .collection('users')
        .doc(profile.uid)
        .set(
          profile.toJson(),
          SetOptions(merge: true),
        ); // Merge to avoid overwriting
  }

  @override
  Future<UserProfileEntity?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserProfileEntity.fromJson(doc.data()!);
    }
    return null;
  }

  @override
  Future<void> updateUserProfile(UserProfileEntity profile) async {
    await _firestore
        .collection('users')
        .doc(profile.uid)
        .update(profile.toJson());
  }
}
