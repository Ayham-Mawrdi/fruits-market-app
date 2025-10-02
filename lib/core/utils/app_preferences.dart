import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const String _firstLaunchKey = 'is_first_launch';
  static const String _onboardingCompletedKey = 'onboarding_completed';

  // Check if it's the first launch (onboarding needed)
  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstLaunchKey) ?? true; // Default: true (show onboarding)
  }

  // Mark onboarding as completed (set flag to false)
  static Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstLaunchKey, false);
    await prefs.setBool(_onboardingCompletedKey, true); // Optional: Track explicitly
  }

  // Check if onboarding was completed (for edge cases)
  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompletedKey) ?? false;
  }

  // Clear flags (e.g., for testing or logout)
  static Future<void> clearOnboardingFlags() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_firstLaunchKey);
    await prefs.remove(_onboardingCompletedKey);
  }
}