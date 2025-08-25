import 'package:flutter/material.dart';
import '../../../shared/models/learning_chapter.dart';
import '../../../shared/models/learning_section.dart';
import '../../../core/constants/app_constants.dart';
import 'content/flutter_basics_content.dart';
import 'content/state_management_content.dart';
import 'content/performance_content.dart';

/// Repository for learning content management
class LearningContentRepository {
  static final LearningContentRepository _instance = LearningContentRepository._internal();
  factory LearningContentRepository() => _instance;
  LearningContentRepository._internal();

  /// Get all learning sections
  List<LearningSection> getAllSections() {
    return [
      _getFlutterBasicsSection(),
      _getStateManagementSection(), 
      _getPerformanceSection(),
    ];
  }

  /// Get section by ID
  LearningSection? getSectionById(String id) {
    try {
      return getAllSections().firstWhere((section) => section.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get chapters for a specific section using modular content files
  List<LearningChapter> getChaptersForSection(String sectionId) {
    switch (sectionId) {
      case 'flutter-basics':
        return FlutterBasicsContent.getChapters();
      case 'state-management':
        return StateManagementContent.getChapters();
      case 'performance':
        return PerformanceContent.getChapters();
      default:
        return [];
    }
  }

  /// Get chapter by ID
  LearningChapter? getChapterById(String sectionId, String chapterId) {
    final chapters = getChaptersForSection(sectionId);
    try {
      return chapters.firstWhere((chapter) => chapter.id == chapterId);
    } catch (e) {
      return null;
    }
  }

  // Private methods for creating sections

  LearningSection _getFlutterBasicsSection() {
    return const LearningSection(
      id: 'flutter-basics',
      title: 'Flutter Basics',
      description: 'Learn the fundamentals of Flutter development from scratch',
      icon: Icons.flutter_dash,
      color: AppConstants.flutterBasicsColor,
      chapters: [
        'introduction',
        'widgets-fundamentals', 
        'layouts',
        'interactive-exercises',
      ],
      difficulty: SectionDifficulty.beginner,
      estimatedTime: 120, // 2 hours total
    );
  }

  LearningSection _getStateManagementSection() {
    return const LearningSection(
      id: 'state-management',
      title: 'State Management',
      description: 'Master advanced state management patterns in Flutter',
      icon: Icons.settings_input_composite,
      color: AppConstants.stateManagementColor,
      chapters: [
        'provider-basics',
        'riverpod-fundamentals', 
        'bloc-pattern',
        'advanced-patterns',
      ],
      difficulty: SectionDifficulty.intermediate,
      estimatedTime: 180, // 3 hours total
    );
  }

  LearningSection _getPerformanceSection() {
    return const LearningSection(
      id: 'performance',
      title: 'Performance Optimization',
      description: 'Optimize your Flutter apps for maximum performance',
      icon: Icons.speed,
      color: AppConstants.performanceColor,
      chapters: [
        'lazy-loading',
        'image-optimization',
      ],
      difficulty: SectionDifficulty.advanced,
      estimatedTime: 90, // 1.5 hours total
    );
  }

  /// Search chapters by query
  List<LearningChapter> searchChapters(String query) {
    final allChapters = <LearningChapter>[];
    
    // Get all chapters from all sections
    for (final section in getAllSections()) {
      allChapters.addAll(getChaptersForSection(section.id));
    }
    
    // Filter by query
    return allChapters.where((chapter) {
      return chapter.title.toLowerCase().contains(query.toLowerCase()) ||
             chapter.content.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  /// Get chapters by difficulty
  List<LearningChapter> getChaptersByDifficulty(SectionDifficulty difficulty) {
    final sections = getAllSections().where((section) => section.difficulty == difficulty);
    final chapters = <LearningChapter>[];
    
    for (final section in sections) {
      chapters.addAll(getChaptersForSection(section.id));
    }
    
    return chapters;
  }

  /// Get total estimated time for all content
  int getTotalEstimatedTime() {
    return getAllSections()
        .map((section) => section.estimatedTime)
        .fold(0, (sum, time) => sum + time);
  }

  /// Get section progress summary
  Map<String, dynamic> getSectionSummary(String sectionId) {
    final section = getSectionById(sectionId);
    final chapters = getChaptersForSection(sectionId);
    
    if (section == null) return {};
    
    return {
      'section': section,
      'chapters': chapters,
      'totalChapters': chapters.length,
      'estimatedTime': section.estimatedTime,
      'difficulty': section.difficulty.displayName,
    };
  }
}