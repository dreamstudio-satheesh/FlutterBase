import 'package:flutter/material.dart';

/// Extension methods for String class
extension StringExtensions on String {
  /// Capitalizes the first letter of the string
  String get capitalize {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// Capitalizes the first letter of each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Checks if the string is a valid email
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Checks if the string is a valid password (min 6 characters)
  bool get isValidPassword {
    return length >= 6;
  }

  /// Checks if the string contains only alphabetic characters
  bool get isAlphabetic {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }

  /// Checks if the string contains only numeric characters
  bool get isNumeric {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  /// Removes all whitespace from the string
  String get removeWhitespace {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Truncates the string to a specified length and adds ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return substring(0, maxLength) + ellipsis;
  }

  /// Converts string to snake_case
  String get toSnakeCase {
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    ).replaceFirst(RegExp(r'^_'), '');
  }

  /// Converts string to camelCase
  String get toCamelCase {
    List<String> words = split('_');
    if (words.isEmpty) return this;
    
    String result = words.first.toLowerCase();
    for (int i = 1; i < words.length; i++) {
      result += words[i].capitalize;
    }
    return result;
  }

  /// Parses the string as a double, returns 0.0 if invalid
  double get toDoubleOrZero {
    return double.tryParse(this) ?? 0.0;
  }

  /// Parses the string as an int, returns 0 if invalid
  int get toIntOrZero {
    return int.tryParse(this) ?? 0;
  }
}

/// Extension methods for BuildContext
extension ContextExtensions on BuildContext {
  /// Gets the current theme
  ThemeData get theme => Theme.of(this);

  /// Gets the current color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Gets the current text theme
  TextTheme get textTheme => theme.textTheme;

  /// Gets the media query data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Gets the screen size
  Size get screenSize => mediaQuery.size;

  /// Gets the screen width
  double get screenWidth => screenSize.width;

  /// Gets the screen height
  double get screenHeight => screenSize.height;

  /// Checks if the device is in portrait mode
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  /// Checks if the device is in landscape mode
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  /// Gets the device pixel ratio
  double get pixelRatio => mediaQuery.devicePixelRatio;

  /// Gets the status bar height
  double get statusBarHeight => mediaQuery.padding.top;

  /// Gets the bottom padding (for devices with home indicator)
  double get bottomPadding => mediaQuery.padding.bottom;

  /// Checks if the device is a mobile device
  bool get isMobile => screenWidth < 600;

  /// Checks if the device is a tablet
  bool get isTablet => screenWidth >= 600 && screenWidth < 900;

  /// Checks if the device is a desktop
  bool get isDesktop => screenWidth >= 900;

  /// Shows a snack bar with the given message
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  /// Shows an error snack bar
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// Shows a success snack bar
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// Unfocus any currently focused widget
  void unfocus() {
    FocusScope.of(this).unfocus();
  }
}

/// Extension methods for DateTime
extension DateTimeExtensions on DateTime {
  /// Formats the date as "MMM dd, yyyy"
  String get formattedDate {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    return '${months[month - 1]} ${day.toString().padLeft(2, '0')}, $year';
  }

  /// Formats the time as "HH:mm"
  String get formattedTime {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  /// Formats the date and time as "MMM dd, yyyy at HH:mm"
  String get formattedDateTime {
    return '$formattedDate at $formattedTime';
  }

  /// Gets a relative time string (e.g., "2 hours ago")
  String get relativeTime {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  /// Checks if the date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Checks if the date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && month == yesterday.month && day == yesterday.day;
  }

  /// Checks if the date is in the current week
  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    return isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
           isBefore(endOfWeek.add(const Duration(days: 1)));
  }
}

/// Extension methods for List
extension ListExtensions<T> on List<T> {
  /// Safely gets an element at the given index
  T? safeElementAt(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Adds an element to the list if it doesn't already exist
  void addIfNotExists(T element) {
    if (!contains(element)) {
      add(element);
    }
  }

  /// Removes duplicate elements from the list
  List<T> get unique {
    return toSet().toList();
  }

  /// Splits the list into chunks of the specified size
  List<List<T>> chunk(int size) {
    List<List<T>> chunks = [];
    for (int i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }
}

/// Extension methods for double
extension DoubleExtensions on double {
  /// Formats the double as a percentage
  String get asPercentage {
    return '${(this * 100).toStringAsFixed(1)}%';
  }

  /// Formats the double as currency
  String get asCurrency {
    return '\$${toStringAsFixed(2)}';
  }

  /// Rounds to the specified number of decimal places
  double roundToDecimalPlaces(int decimalPlaces) {
    num mod = pow(10.0, decimalPlaces) as num;
    return ((this * mod).round().toDouble() / mod);
  }
}

/// Import required for pow function
import 'dart:math' show pow;