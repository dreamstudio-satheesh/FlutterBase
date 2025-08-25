import '../../../../shared/models/learning_chapter.dart';

/// Performance Optimization section content
class PerformanceContent {
  static List<LearningChapter> getChapters() {
    return [
      // Placeholder chapters - will be implemented in tasks 19-20
      const LearningChapter(
        id: 'lazy-loading',
        sectionId: 'performance',
        title: 'Lazy Loading Lists',
        content: 'Coming soon...',
        order: 1,
        estimatedReadTime: 12,
        codeExamples: [],
        learningObjectives: [],
        prerequisites: [],
      ),
      
      const LearningChapter(
        id: 'image-optimization',
        sectionId: 'performance',
        title: 'Image Optimization',
        content: 'Coming soon...',
        order: 2,
        estimatedReadTime: 15,
        codeExamples: [],
        learningObjectives: [],
        prerequisites: [],
      ),
    ];
  }
}