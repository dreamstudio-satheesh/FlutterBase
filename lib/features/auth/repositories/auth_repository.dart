import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/models/user.dart';
import '../../../shared/models/user_progress.dart';

/// Repository for handling authentication operations
class AuthRepository {
  static const String _userIdKey = 'user_id';
  static const String _usernameKey = 'username';
  static const String _emailKey = 'email';
  static const String _loginTimeKey = 'last_login';

  /// Login with username and password
  Future<User?> login(String username, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock authentication - replace with real authentication
    if (username.toLowerCase() == 'admin' && password == '1234') {
      final user = User(
        id: 'user_1',
        username: username,
        email: 'admin@flutterlearning.com',
        displayName: 'Flutter Learner',
        createdAt: DateTime.now(),
        lastLoginAt: DateTime.now(),
        preferences: const UserPreferences(
          isDarkMode: false,
          fontSize: 16.0,
          enableNotifications: true,
        ),
      );

      // Save user data to local storage
      await _saveUserToStorage(user);
      
      return user;
    }

    // Invalid credentials
    return null;
  }

  /// Logout current user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// Get current user from storage
  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    
    final userId = prefs.getString(_userIdKey);
    final username = prefs.getString(_usernameKey);
    final email = prefs.getString(_emailKey);
    final loginTimeString = prefs.getString(_loginTimeKey);

    if (userId == null || username == null || email == null) {
      return null;
    }

    final lastLoginAt = loginTimeString != null 
        ? DateTime.tryParse(loginTimeString)
        : null;

    return User(
      id: userId,
      username: username,
      email: email,
      displayName: 'Flutter Learner',
      lastLoginAt: lastLoginAt,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      preferences: const UserPreferences(
        isDarkMode: false,
        fontSize: 16.0,
        enableNotifications: true,
      ),
    );
  }

  /// Save user data to local storage
  Future<void> _saveUserToStorage(User user) async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString(_userIdKey, user.id);
    await prefs.setString(_usernameKey, user.username);
    await prefs.setString(_emailKey, user.email);
    
    if (user.lastLoginAt != null) {
      await prefs.setString(_loginTimeKey, user.lastLoginAt!.toIso8601String());
    }
  }

  /// Update user preferences
  Future<void> updateUserPreferences(UserPreferences preferences) async {
    // In a real app, this would sync with a backend
    // For now, we'll just store locally
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setBool('dark_mode', preferences.isDarkMode);
    await prefs.setDouble('font_size', preferences.fontSize);
    await prefs.setString('code_theme', preferences.codeTheme);
    await prefs.setBool('notifications', preferences.enableNotifications);
    await prefs.setBool('haptic_feedback', preferences.enableHapticFeedback);
    await prefs.setBool('auto_save', preferences.autoSaveProgress);
    await prefs.setString('language', preferences.preferredLanguage);
  }

  /// Load user preferences
  Future<UserPreferences> loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    
    return UserPreferences(
      isDarkMode: prefs.getBool('dark_mode') ?? false,
      fontSize: prefs.getDouble('font_size') ?? 16.0,
      codeTheme: prefs.getString('code_theme') ?? 'default',
      enableNotifications: prefs.getBool('notifications') ?? true,
      enableHapticFeedback: prefs.getBool('haptic_feedback') ?? true,
      autoSaveProgress: prefs.getBool('auto_save') ?? true,
      preferredLanguage: prefs.getString('language') ?? 'en',
    );
  }

  /// Check if user exists (for registration)
  Future<bool> userExists(String username) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock check - in real app, this would query the backend
    return username.toLowerCase() == 'admin';
  }

  /// Register new user (placeholder for future implementation)
  Future<User?> register({
    required String username,
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));
    
    // Mock registration - in real app, this would create user in backend
    throw UnimplementedError('Registration not implemented yet');
  }

  /// Reset password (placeholder for future implementation)
  Future<bool> resetPassword(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Mock reset - in real app, this would send reset email
    throw UnimplementedError('Password reset not implemented yet');
  }
}