import '../../../../shared/models/learning_chapter.dart';

/// State Management section content
class StateManagementContent {
  static List<LearningChapter> getChapters() {
    return [
      // Provider Basics chapter - placeholder
      const LearningChapter(
        id: 'provider-basics',
        sectionId: 'state-management',
        title: 'Provider Basics',
        content: 'Complete Provider basics content will be here...',
        order: 1,
        estimatedReadTime: 25,
        codeExamples: [],
        learningObjectives: [],
      ),

      // Riverpod chapter - placeholder
      const LearningChapter(
        id: 'riverpod-fundamentals',
        sectionId: 'state-management',
        title: 'Riverpod Fundamentals',
        content: 'Complete Riverpod fundamentals content will be here...',
        order: 2,
        estimatedReadTime: 30,
        codeExamples: [],
        learningObjectives: [],
      ),

      // Bloc pattern chapter - placeholder
      const LearningChapter(
        id: 'bloc-pattern',
        sectionId: 'state-management',
        title: 'Bloc Pattern',
        content: 'Complete Bloc pattern content will be here...',
        order: 3,
        estimatedReadTime: 35,
        codeExamples: [],
        learningObjectives: [],
      ),

      // Advanced patterns chapter - placeholder
      const LearningChapter(
        id: 'advanced-patterns',
        sectionId: 'state-management',
        title: 'Advanced Patterns',
        content: 'Complete advanced patterns content will be here...',
        order: 4,
        estimatedReadTime: 40,
        codeExamples: [],
        learningObjectives: [],
      ),
    ];
  }
}