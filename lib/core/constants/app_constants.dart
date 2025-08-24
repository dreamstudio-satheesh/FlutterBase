import 'package:flutter/material.dart';

/// Application-wide constants for colors, dimensions, strings, and other values.
class AppConstants {
  AppConstants._();

  // App Information
  static const String appName = 'Flutter Learning Hub';
  static const String appVersion = '1.0.0';

  // Colors (Material 3 Color System)
  static const Color primaryColor = Color(0xFF6750A4);
  static const Color primaryContainer = Color(0xFFEADDFF);
  static const Color secondary = Color(0xFF625B71);
  static const Color secondaryContainer = Color(0xFFE8DEF8);
  static const Color tertiary = Color(0xFF7D5260);
  static const Color tertiaryContainer = Color(0xFFFFD8E4);
  
  static const Color surface = Color(0xFFFEF7FF);
  static const Color surfaceVariant = Color(0xFFE7E0EC);
  static const Color background = Color(0xFFFEF7FF);
  
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  
  static const Color outline = Color(0xFF79747E);
  static const Color shadow = Color(0xFF000000);
  
  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFFD0BCFF);
  static const Color darkPrimaryContainer = Color(0xFF4F378B);
  static const Color darkSecondary = Color(0xFFCCC2DC);
  static const Color darkSecondaryContainer = Color(0xFF4A4458);
  
  static const Color darkSurface = Color(0xFF141218);
  static const Color darkSurfaceVariant = Color(0xFF49454F);
  static const Color darkBackground = Color(0xFF141218);
  
  // Learning Section Colors
  static const Color flutterBasicsColor = Color(0xFF1976D2);
  static const Color stateManagementColor = Color(0xFF388E3C);
  static const Color performanceColor = Color(0xFFFF5722);
  
  // Dimensions
  static const double paddingTiny = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingExtraLarge = 32.0;
  
  static const double marginTiny = 4.0;
  static const double marginSmall = 8.0;
  static const double marginMedium = 16.0;
  static const double marginLarge = 24.0;
  static const double marginExtraLarge = 32.0;
  
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusExtraLarge = 28.0;
  
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeExtraLarge = 48.0;
  
  // Animation Durations
  static const Duration animationDurationFast = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);
  
  // Text Sizes
  static const double textSizeCaption = 12.0;
  static const double textSizeBody = 14.0;
  static const double textSizeSubtitle = 16.0;
  static const double textSizeTitle = 20.0;
  static const double textSizeHeadline = 24.0;
  static const double textSizeDisplay = 32.0;
  
  // Elevation
  static const double elevationNone = 0.0;
  static const double elevationLow = 1.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationExtraHigh = 12.0;
}

/// String constants for the application
class AppStrings {
  AppStrings._();

  // General
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String ok = 'OK';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String add = 'Add';
  static const String search = 'Search';
  static const String next = 'Next';
  static const String previous = 'Previous';
  static const String finish = 'Finish';
  static const String skip = 'Skip';
  
  // Authentication
  static const String login = 'Login';
  static const String logout = 'Logout';
  static const String username = 'Username';
  static const String password = 'Password';
  static const String loginButton = 'Login';
  static const String invalidCredentials = 'Invalid username or password';
  static const String welcome = 'Welcome';
  static const String welcomeBack = 'Welcome Back!';
  static const String pleaseLogin = 'Please login to continue';
  
  // Learning Sections
  static const String flutterBasics = 'Flutter Basics';
  static const String stateManagement = 'State Management';
  static const String performanceOptimization = 'Performance Optimization';
  
  // Flutter Basics Chapters
  static const String introduction = 'Introduction';
  static const String widgets = 'Widgets';
  static const String layouts = 'Layouts';
  static const String interactiveExercises = 'Interactive Exercises';
  
  // State Management Chapters
  static const String provider = 'Provider';
  static const String riverpod = 'Riverpod';
  static const String blocPattern = 'Bloc Pattern';
  static const String handsOnExamples = 'Hands-on Examples';
  
  // Performance Chapters
  static const String lazyLoading = 'Lazy Loading';
  static const String imageOptimization = 'Image Optimization';
  static const String devToolsProfiling = 'DevTools Profiling';
  
  // Progress
  static const String progress = 'Progress';
  static const String completed = 'Completed';
  static const String inProgress = 'In Progress';
  static const String notStarted = 'Not Started';
  static const String continueReading = 'Continue Reading';
  static const String startReading = 'Start Reading';
  static const String readNext = 'Read Next';
  
  // Navigation
  static const String home = 'Home';
  static const String profile = 'Profile';
  static const String settings = 'Settings';
  static const String about = 'About';
  
  // Error Messages
  static const String somethingWentWrong = 'Something went wrong';
  static const String networkError = 'Network error occurred';
  static const String noInternetConnection = 'No internet connection';
  static const String dataNotFound = 'Data not found';
  
  // Success Messages
  static const String progressSaved = 'Progress saved successfully';
  static const String chapterCompleted = 'Chapter completed!';
  static const String sectionCompleted = 'Section completed!';
}

/// Asset paths for the application
class AppAssets {
  AppAssets._();

  // Images
  static const String logoPath = 'assets/images/logo.png';
  static const String splashImagePath = 'assets/images/splash.png';
  static const String placeholderImagePath = 'assets/images/placeholder.png';
  
  // Lottie Animations
  static const String loadingAnimationPath = 'assets/animations/loading.json';
  static const String successAnimationPath = 'assets/animations/success.json';
  static const String errorAnimationPath = 'assets/animations/error.json';
  
  // Icons
  static const String flutterIconPath = 'assets/icons/flutter.png';
  static const String dartIconPath = 'assets/icons/dart.png';
}

/// Device breakpoints for responsive design
class AppBreakpoints {
  AppBreakpoints._();

  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
  static const double largeDesktop = 1800;
}