import 'package:flutter/material.dart';
import '../../../shared/models/learning_section.dart';
import '../../../shared/models/learning_chapter.dart';
import '../../../core/constants/app_constants.dart';

/// Repository for managing learning content data
class LearningContentRepository {
  static final LearningContentRepository _instance = LearningContentRepository._();
  static LearningContentRepository get instance => _instance;
  
  LearningContentRepository._();

  /// Get all learning sections
  List<LearningSection> getAllSections() {
    return [
      _getFlutterBasicsSection(),
      _getStateManagementSection(),
      _getPerformanceSection(),
    ];
  }

  /// Get specific section by ID
  LearningSection? getSectionById(String sectionId) {
    final sections = getAllSections();
    try {
      return sections.firstWhere((section) => section.id == sectionId);
    } catch (e) {
      return null;
    }
  }

  /// Get chapters for a specific section
  List<LearningChapter> getChaptersForSection(String sectionId) {
    switch (sectionId) {
      case 'flutter-basics':
        return _getFlutterBasicsChapters();
      case 'state-management':
        return _getStateManagementChapters();
      case 'performance':
        return _getPerformanceChapters();
      default:
        return [];
    }
  }

  /// Get specific chapter by section and chapter ID
  LearningChapter? getChapter(String sectionId, String chapterId) {
    final chapters = getChaptersForSection(sectionId);
    try {
      return chapters.firstWhere((chapter) => chapter.id == chapterId);
    } catch (e) {
      return null;
    }
  }

  // Private methods for creating sections and chapters

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
      estimatedTime: 120, // 2 hours
      difficulty: SectionDifficulty.beginner,
    );
  }

  LearningSection _getStateManagementSection() {
    return const LearningSection(
      id: 'state-management',
      title: 'State Management',
      description: 'Master different state management patterns in Flutter',
      icon: Icons.settings_suggest_outlined,
      color: AppConstants.stateManagementColor,
      chapters: [
        'provider-basics',
        'riverpod-advanced',
        'bloc-pattern',
        'hands-on-examples',
      ],
      estimatedTime: 180, // 3 hours
      difficulty: SectionDifficulty.intermediate,
    );
  }

  LearningSection _getPerformanceSection() {
    return const LearningSection(
      id: 'performance',
      title: 'Performance Optimization',
      description: 'Optimize your Flutter apps for production',
      icon: Icons.speed_outlined,
      color: AppConstants.performanceColor,
      chapters: [
        'lazy-loading',
        'image-optimization',
        'devtools-profiling',
      ],
      estimatedTime: 150, // 2.5 hours
      difficulty: SectionDifficulty.advanced,
    );
  }

  List<LearningChapter> _getFlutterBasicsChapters() {
    return [
      // Chapter 1: Introduction
      const LearningChapter(
        id: 'introduction',
        sectionId: 'flutter-basics',
        title: 'Introduction to Flutter',
        content: '''
# Welcome to Flutter! 🚀

Flutter is Google's revolutionary UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.

## What Makes Flutter Special?

### 🎯 **Single Codebase, Multiple Platforms**
Write once, run everywhere! Flutter allows you to create apps for:
- iOS and Android (Mobile)
- Web browsers
- Windows, macOS, and Linux (Desktop)

### ⚡ **Fast Development**
- **Hot Reload**: See changes instantly without losing app state
- **Rich Widget Library**: Pre-built components for Material and Cupertino design
- **Flexible UI**: Create custom designs with ease

### 🚀 **High Performance**
- Compiles to native ARM code
- 60fps animations out of the box
- Small app bundle sizes

## Flutter Architecture

Flutter uses a **reactive framework** where UI is built with widgets. Everything in Flutter is a widget!

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello Flutter!'),
        ),
        body: Center(
          child: Text(
            'Welcome to Flutter!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
```

## Key Concepts to Remember

1. **Everything is a Widget**: UI elements, layouts, animations
2. **Declarative UI**: Describe what the UI should look like
3. **Composition over Inheritance**: Build complex widgets from simple ones
4. **Immutable Widgets**: Widgets are immutable; state changes trigger rebuilds

## What You'll Learn in This Section

By the end of this section, you'll be able to:
- ✅ Understand Flutter's widget-based architecture
- ✅ Create your first Flutter app
- ✅ Use basic widgets like Text, Container, and Button
- ✅ Understand the difference between StatelessWidget and StatefulWidget
- ✅ Create responsive layouts with Flutter's layout widgets

## Let's Get Started!

Ready to dive into the world of Flutter development? In the next chapter, we'll explore widgets in detail and start building our first interactive app!

> 💡 **Pro Tip**: The best way to learn Flutter is by building. Follow along with the code examples and experiment with them!
        ''',
        order: 1,
        estimatedReadTime: 8,
        codeExamples: [
          CodeExample(
            id: 'hello-world',
            title: 'Hello World App',
            code: '''
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Center(
          child: Text(
            'Hello, Flutter World!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}''',
            language: 'dart',
            explanation: 'This is a basic Flutter app that displays "Hello, Flutter World!" in the center of the screen.',
            isRunnable: true,
          ),
        ],
        learningObjectives: [
          'Understand what Flutter is and its advantages',
          'Learn about Flutter\'s architecture and widget system',
          'Recognize the declarative UI paradigm',
          'Identify key Flutter concepts for further learning',
        ],
      ),

      // More chapters will be added in subsequent tasks...
    ];
  }

  List<LearningChapter> _getStateManagementChapters() {
    return [
      // Placeholder chapters - will be implemented in tasks 15-18
      const LearningChapter(
        id: 'provider-basics',
        sectionId: 'state-management',
        title: 'Provider Basics',
        content: 'Coming soon...',
        order: 1,
        estimatedReadTime: 15,
      ),
    ];
  }

  List<LearningChapter> _getPerformanceChapters() {
    return [
      // Placeholder chapters - will be implemented in tasks 19-21
      const LearningChapter(
        id: 'lazy-loading',
        sectionId: 'performance',
        title: 'Lazy Loading Lists',
        content: 'Coming soon...',
        order: 1,
        estimatedReadTime: 12,
      ),
    ];
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