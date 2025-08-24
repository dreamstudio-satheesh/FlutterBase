import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/learning_section.dart';
import '../../../shared/models/learning_chapter.dart';
import '../repositories/learning_content_repository.dart';

/// Provider for learning content repository
final learningContentRepositoryProvider = Provider<LearningContentRepository>((ref) {
  return LearningContentRepository.instance;
});

/// Provider for all learning sections
final learningSectionsProvider = Provider<List<LearningSection>>((ref) {
  final repository = ref.watch(learningContentRepositoryProvider);
  return repository.getAllSections();
});

/// Provider for a specific section by ID
final sectionProvider = Provider.family<LearningSection?, String>((ref, sectionId) {
  final repository = ref.watch(learningContentRepositoryProvider);
  return repository.getSectionById(sectionId);
});

/// Provider for chapters in a specific section
final sectionChaptersProvider = Provider.family<List<LearningChapter>, String>((ref, sectionId) {
  final repository = ref.watch(learningContentRepositoryProvider);
  return repository.getChaptersForSection(sectionId);
});

/// Provider for a specific chapter
final chapterProvider = Provider.family<LearningChapter?, ({String sectionId, String chapterId})>((ref, params) {
  final repository = ref.watch(learningContentRepositoryProvider);
  return repository.getChapter(params.sectionId, params.chapterId);
});

/// Provider for section summary
final sectionSummaryProvider = Provider.family<Map<String, dynamic>, String>((ref, sectionId) {
  final repository = ref.watch(learningContentRepositoryProvider);
  return repository.getSectionSummary(sectionId);
});

/// Provider for search results
final searchResultsProvider = Provider.family<List<LearningChapter>, String>((ref, query) {
  if (query.isEmpty) return [];
  
  final repository = ref.watch(learningContentRepositoryProvider);
  return repository.searchChapters(query);
});

/// Provider for chapters by difficulty
final chaptersByDifficultyProvider = Provider.family<List<LearningChapter>, SectionDifficulty>((ref, difficulty) {
  final repository = ref.watch(learningContentRepositoryProvider);
  return repository.getChaptersByDifficulty(difficulty);
});

/// Provider for total estimated learning time
final totalEstimatedTimeProvider = Provider<int>((ref) {
  final repository = ref.watch(learningContentRepositoryProvider);
  return repository.getTotalEstimatedTime();
});