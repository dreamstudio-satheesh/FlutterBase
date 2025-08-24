import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Represents a learning section in the app (e.g., Flutter Basics, State Management)
class LearningSection extends Equatable {
  const LearningSection({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.chapters,
    this.estimatedTime = 0,
    this.difficulty = SectionDifficulty.beginner,
    this.isLocked = false,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> chapters; // List of chapter IDs
  final int estimatedTime; // in minutes
  final SectionDifficulty difficulty;
  final bool isLocked;

  /// Creates a copy of this section with the given fields replaced
  LearningSection copyWith({
    String? id,
    String? title,
    String? description,
    IconData? icon,
    Color? color,
    List<String>? chapters,
    int? estimatedTime,
    SectionDifficulty? difficulty,
    bool? isLocked,
  }) {
    return LearningSection(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      chapters: chapters ?? this.chapters,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      difficulty: difficulty ?? this.difficulty,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  /// Converts this section to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon.codePoint,
      'color': color.value,
      'chapters': chapters,
      'estimatedTime': estimatedTime,
      'difficulty': difficulty.name,
      'isLocked': isLocked,
    };
  }

  /// Creates a section from a JSON map
  factory LearningSection.fromJson(Map<String, dynamic> json) {
    return LearningSection(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
      color: Color(json['color'] as int),
      chapters: List<String>.from(json['chapters'] as List),
      estimatedTime: json['estimatedTime'] as int? ?? 0,
      difficulty: SectionDifficulty.values.firstWhere(
        (d) => d.name == json['difficulty'],
        orElse: () => SectionDifficulty.beginner,
      ),
      isLocked: json['isLocked'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        icon,
        color,
        chapters,
        estimatedTime,
        difficulty,
        isLocked,
      ];
}

/// Difficulty levels for learning sections
enum SectionDifficulty {
  beginner('Beginner'),
  intermediate('Intermediate'),
  advanced('Advanced');

  const SectionDifficulty(this.displayName);

  final String displayName;

  /// Gets the color associated with this difficulty level
  Color get color {
    switch (this) {
      case SectionDifficulty.beginner:
        return Colors.green;
      case SectionDifficulty.intermediate:
        return Colors.orange;
      case SectionDifficulty.advanced:
        return Colors.red;
    }
  }
}