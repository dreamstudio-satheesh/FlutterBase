import 'package:equatable/equatable.dart';

/// Represents user progress for a specific chapter
class ChapterProgress extends Equatable {
  const ChapterProgress({
    required this.chapterId,
    this.isStarted = false,
    this.isCompleted = false,
    this.progressPercentage = 0.0,
    this.timeSpent = 0,
    this.lastAccessedAt,
    this.completedAt,
    this.bookmarkedAt,
  });

  final String chapterId;
  final bool isStarted;
  final bool isCompleted;
  final double progressPercentage;
  final int timeSpent; // in seconds
  final DateTime? lastAccessedAt;
  final DateTime? completedAt;
  final DateTime? bookmarkedAt;

  ChapterProgress copyWith({
    String? chapterId,
    bool? isStarted,
    bool? isCompleted,
    double? progressPercentage,
    int? timeSpent,
    DateTime? lastAccessedAt,
    DateTime? completedAt,
    DateTime? bookmarkedAt,
  }) {
    return ChapterProgress(
      chapterId: chapterId ?? this.chapterId,
      isStarted: isStarted ?? this.isStarted,
      isCompleted: isCompleted ?? this.isCompleted,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      timeSpent: timeSpent ?? this.timeSpent,
      lastAccessedAt: lastAccessedAt ?? this.lastAccessedAt,
      completedAt: completedAt ?? this.completedAt,
      bookmarkedAt: bookmarkedAt ?? this.bookmarkedAt,
    );
  }

  @override
  List<Object?> get props => [
        chapterId,
        isStarted,
        isCompleted,
        progressPercentage,
        timeSpent,
        lastAccessedAt,
        completedAt,
        bookmarkedAt,
      ];
}

/// Represents user progress for a learning section
class SectionProgress extends Equatable {
  const SectionProgress({
    required this.sectionId,
    this.chaptersProgress = const {},
    this.isStarted = false,
    this.isCompleted = false,
    this.completedChaptersCount = 0,
    this.totalChaptersCount = 0,
    this.totalTimeSpent = 0,
    this.lastAccessedAt,
    this.completedAt,
  });

  final String sectionId;
  final Map<String, ChapterProgress> chaptersProgress;
  final bool isStarted;
  final bool isCompleted;
  final int completedChaptersCount;
  final int totalChaptersCount;
  final int totalTimeSpent; // in seconds
  final DateTime? lastAccessedAt;
  final DateTime? completedAt;

  /// Calculate the overall progress percentage for this section
  double get progressPercentage {
    if (totalChaptersCount == 0) return 0.0;
    return completedChaptersCount / totalChaptersCount;
  }

  /// Get the progress for a specific chapter
  ChapterProgress? getChapterProgress(String chapterId) {
    return chaptersProgress[chapterId];
  }

  /// Check if a chapter is completed
  bool isChapterCompleted(String chapterId) {
    return chaptersProgress[chapterId]?.isCompleted ?? false;
  }

  SectionProgress copyWith({
    String? sectionId,
    Map<String, ChapterProgress>? chaptersProgress,
    bool? isStarted,
    bool? isCompleted,
    int? completedChaptersCount,
    int? totalChaptersCount,
    int? totalTimeSpent,
    DateTime? lastAccessedAt,
    DateTime? completedAt,
  }) {
    return SectionProgress(
      sectionId: sectionId ?? this.sectionId,
      chaptersProgress: chaptersProgress ?? this.chaptersProgress,
      isStarted: isStarted ?? this.isStarted,
      isCompleted: isCompleted ?? this.isCompleted,
      completedChaptersCount: completedChaptersCount ?? this.completedChaptersCount,
      totalChaptersCount: totalChaptersCount ?? this.totalChaptersCount,
      totalTimeSpent: totalTimeSpent ?? this.totalTimeSpent,
      lastAccessedAt: lastAccessedAt ?? this.lastAccessedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  List<Object?> get props => [
        sectionId,
        chaptersProgress,
        isStarted,
        isCompleted,
        completedChaptersCount,
        totalChaptersCount,
        totalTimeSpent,
        lastAccessedAt,
        completedAt,
      ];
}