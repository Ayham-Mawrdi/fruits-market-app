import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/user_profile_entity.dart';

abstract class LocalDataSource {
  Future<void> cacheUserProfile(UserProfileEntity profile);
  Future<UserProfileEntity?> getCachedUserProfile();
  Future<void> clearCachedUserProfile();
}

class LocalDataSourceImpl implements LocalDataSource {
  static const String _userKey = 'cached_user_profile';

  @override
  Future<void> cacheUserProfile(UserProfileEntity profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _userKey,
      profile.toJson().toString(),
    ); // Simple JSON string (use jsonEncode for complex)
  }

  @override
  Future<UserProfileEntity?> getCachedUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userKey);
    if (jsonString != null) {
      // Parse back (use jsonDecode in production)
      final json = {
        'name': 'John',
        'email': 'john@example.com',
      }; // Placeholder; implement jsonDecode
      return UserProfileEntity.fromJson(json);
    }
    return null;
  }

  @override
  Future<void> clearCachedUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
