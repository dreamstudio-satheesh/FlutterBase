import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Collection of helper functions for common operations
class AppHelpers {
  AppHelpers._();

  static Timer? _debounceTimer;
  static Timer? _throttleTimer;

  /// Generates a random string of the specified length
  static String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    math.Random random = math.Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  /// Calculates the reading time for a given text
  static int calculateReadingTime(String text, {int wordsPerMinute = 200}) {
    final wordCount = text.split(RegExp(r'\s+')).length;
    final readingTime = (wordCount / wordsPerMinute).ceil();
    return readingTime > 0 ? readingTime : 1;
  }

  /// Debounces a function call
  static void debounce(VoidCallback callback, Duration duration) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(duration, callback);
  }

  /// Haptic feedback helper
  static void lightHaptic() {
    HapticFeedback.lightImpact();
  }

  /// Progress calculation helpers
  static double calculateProgress(int completed, int total) {
    if (total == 0) return 0.0;
    return (completed / total).clamp(0.0, 1.0);
  }

  static String progressToPercentage(double progress) {
    return '${(progress * 100).round()}%';
  }

  /// Learning progress helpers
  static String getLearningStatus(double progress) {
    if (progress == 0) return 'Not Started';
    if (progress < 1) return 'In Progress';
    return 'Completed';
  }

  static Color getProgressColor(double progress) {
    if (progress == 0) return Colors.grey;
    if (progress < 0.5) return Colors.orange;
    if (progress < 1) return Colors.blue;
    return Colors.green;
  }
}