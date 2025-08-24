import 'package:equatable/equatable.dart';
import 'user_progress.dart';

/// Represents a user in the learning app
class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.email,
    this.displayName,
    this.avatarUrl,
    this.createdAt,
    this.lastLoginAt,
    this.totalTimeSpent = 0,
    this.sectionsProgress = const {},
    this.achievements = const [],
    this.preferences = const UserPreferences(),
  });

  final String id;
  final String username;
  final String email;
  final String? displayName;
  final String? avatarUrl;
  final DateTime? createdAt;
  final DateTime? lastLoginAt;
  final int totalTimeSpent; // in seconds
  final Map<String, SectionProgress> sectionsProgress;
  final List<String> achievements;
  final UserPreferences preferences;

  /// Get the overall learning progress across all sections
  double get overallProgress {
    if (sectionsProgress.isEmpty) return 0.0;
    
    double totalProgress = sectionsProgress.values
        .map((section) => section.progressPercentage)
        .reduce((a, b) => a + b);
    
    return totalProgress / sectionsProgress.length;
  }

  /// Get the total number of completed chapters
  int get totalCompletedChapters {
    return sectionsProgress.values
        .map((section) => section.completedChaptersCount)
        .fold(0, (sum, count) => sum + count);
  }

  /// Get the total number of chapters across all sections
  int get totalChapters {
    return sectionsProgress.values
        .map((section) => section.totalChaptersCount)
        .fold(0, (sum, count) => sum + count);
  }

  /// Check if the user has completed a specific section
  bool isSectionCompleted(String sectionId) {
    return sectionsProgress[sectionId]?.isCompleted ?? false;
  }

  /// Get progress for a specific section
  SectionProgress? getSectionProgress(String sectionId) {
    return sectionsProgress[sectionId];
  }

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? displayName,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    int? totalTimeSpent,
    Map<String, SectionProgress>? sectionsProgress,
    List<String>? achievements,
    UserPreferences? preferences,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      totalTimeSpent: totalTimeSpent ?? this.totalTimeSpent,
      sectionsProgress: sectionsProgress ?? this.sectionsProgress,
      achievements: achievements ?? this.achievements,
      preferences: preferences ?? this.preferences,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        displayName,
        avatarUrl,
        createdAt,
        lastLoginAt,
        totalTimeSpent,
        sectionsProgress,
        achievements,
        preferences,
      ];
}

/// User preferences and settings
class UserPreferences extends Equatable {
  const UserPreferences({
    this.isDarkMode = false,
    this.fontSize = 16.0,
    this.codeTheme = 'default',
    this.enableNotifications = true,
    this.enableHapticFeedback = true,
    this.autoSaveProgress = true,
    this.preferredLanguage = 'en',
  });

  final bool isDarkMode;
  final double fontSize;
  final String codeTheme;
  final bool enableNotifications;
  final bool enableHapticFeedback;
  final bool autoSaveProgress;
  final String preferredLanguage;

  UserPreferences copyWith({
    bool? isDarkMode,
    double? fontSize,
    String? codeTheme,
    bool? enableNotifications,
    bool? enableHapticFeedback,
    bool? autoSaveProgress,
    String? preferredLanguage,
  }) {
    return UserPreferences(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      fontSize: fontSize ?? this.fontSize,
      codeTheme: codeTheme ?? this.codeTheme,
      enableNotifications: enableNotifications ?? this.enableNotifications,
      enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
      autoSaveProgress: autoSaveProgress ?? this.autoSaveProgress,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
    );
  }

  @override
  List<Object?> get props => [
        isDarkMode,
        fontSize,
        codeTheme,
        enableNotifications,
        enableHapticFeedback,
        autoSaveProgress,
        preferredLanguage,
      ];
}