import 'package:equatable/equatable.dart';

/// Represents a chapter within a learning section
class LearningChapter extends Equatable {
  const LearningChapter({
    required this.id,
    required this.sectionId,
    required this.title,
    required this.content,
    this.order = 0,
    this.estimatedReadTime = 0,
    this.codeExamples = const [],
    this.interactiveElements = const [],
    this.prerequisites = const [],
    this.learningObjectives = const [],
  });

  final String id;
  final String sectionId;
  final String title;
  final String content;
  final int order;
  final int estimatedReadTime;
  final List<CodeExample> codeExamples;
  final List<InteractiveElement> interactiveElements;
  final List<String> prerequisites;
  final List<String> learningObjectives;

  LearningChapter copyWith({
    String? id,
    String? sectionId,
    String? title,
    String? content,
    int? order,
    int? estimatedReadTime,
    List<CodeExample>? codeExamples,
    List<InteractiveElement>? interactiveElements,
    List<String>? prerequisites,
    List<String>? learningObjectives,
  }) {
    return LearningChapter(
      id: id ?? this.id,
      sectionId: sectionId ?? this.sectionId,
      title: title ?? this.title,
      content: content ?? this.content,
      order: order ?? this.order,
      estimatedReadTime: estimatedReadTime ?? this.estimatedReadTime,
      codeExamples: codeExamples ?? this.codeExamples,
      interactiveElements: interactiveElements ?? this.interactiveElements,
      prerequisites: prerequisites ?? this.prerequisites,
      learningObjectives: learningObjectives ?? this.learningObjectives,
    );
  }

  @override
  List<Object?> get props => [
        id,
        sectionId,
        title,
        content,
        order,
        estimatedReadTime,
        codeExamples,
        interactiveElements,
        prerequisites,
        learningObjectives,
      ];
}

class CodeExample extends Equatable {
  const CodeExample({
    required this.id,
    required this.title,
    required this.code,
    required this.language,
    this.explanation = '',
    this.isRunnable = false,
  });

  final String id;
  final String title;
  final String code;
  final String language;
  final String explanation;
  final bool isRunnable;

  @override
  List<Object?> get props => [id, title, code, language, explanation, isRunnable];
}

class InteractiveElement extends Equatable {
  const InteractiveElement({
    required this.id,
    required this.type,
    required this.title,
    this.content = const {},
  });

  final String id;
  final InteractiveElementType type;
  final String title;
  final Map<String, dynamic> content;

  @override
  List<Object?> get props => [id, type, title, content];
}

enum InteractiveElementType {
  quiz,
  codePlayground,
  widget3dView,
  dragAndDrop,
  fillInTheBlank,
}