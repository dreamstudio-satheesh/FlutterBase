import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../../features/auth/providers/auth_provider.dart';
import 'router_service.dart';

/// Navigation service for centralized navigation management
class NavigationService {
  NavigationService._();
  
  static final NavigationService _instance = NavigationService._();
  static NavigationService get instance => _instance;

  /// Navigate to a specific route
  void navigateTo(String route, {Object? extra}) {
    _router?.go(route, extra: extra);
  }

  /// Navigate and replace current route
  void navigateAndReplace(String route, {Object? extra}) {
    _router?.pushReplacement(route, extra: extra);
  }

  /// Navigate and clear all previous routes
  void navigateAndClearStack(String route, {Object? extra}) {
    _router?.go(route, extra: extra);
  }

  /// Go back to previous route
  void goBack() {
    _router?.pop();
  }

  /// Check if we can go back
  bool canGoBack() {
    return _router?.canPop() ?? false;
  }

  /// Get current route location
  String get currentLocation => _router?.routerDelegate.currentConfiguration.uri.toString() ?? '';

  GoRouter? _router;

  /// Set the router instance (called internally)
  void setRouter(GoRouter router) {
    _router = router;
  }

  /// Navigation shortcuts for common routes
  void goToSplash() => navigateTo(AppRoutes.splash);
  void goToLogin() => navigateTo(AppRoutes.login);
  void goToHome() => navigateTo(AppRoutes.home);
  void goToProfile() => navigateTo(AppRoutes.profile);
  void goToSettings() => navigateTo(AppRoutes.settings);

  /// Learning-specific navigation
  void goToSection(String sectionId) => navigateTo('${AppRoutes.sections}/$sectionId');
  void goToChapter(String sectionId, String chapterId) => 
      navigateTo('${AppRoutes.sections}/$sectionId/chapters/$chapterId');
}

/// Route guard for checking authentication requirements
class RouteGuard {
  const RouteGuard._();

  /// Check if route requires authentication
  static bool requiresAuth(String route) {
    const publicRoutes = [
      AppRoutes.splash,
      AppRoutes.login,
    ];
    
    return !publicRoutes.contains(route);
  }

  /// Check if user has permission to access route
  static bool hasPermission(String route, WidgetRef ref) {
    final authState = ref.read(authProvider);
    
    // If route doesn't require auth, allow access
    if (!requiresAuth(route)) {
      return true;
    }
    
    // Check if user is authenticated
    return authState.isAuthenticated;
  }

  /// Check if route is for learning content and user has access
  static bool canAccessLearningContent(String route, WidgetRef ref) {
    final authState = ref.read(authProvider);
    
    // Must be authenticated first
    if (!authState.isAuthenticated) {
      return false;
    }
    
    // For now, all authenticated users can access all content
    // In the future, this could check subscription status, progress requirements, etc.
    return true;
  }

  /// Get redirect route if current route is not accessible
  static String? getRedirectRoute(String currentRoute, WidgetRef ref) {
    final authState = ref.read(authProvider);
    
    // Don't redirect while loading
    if (authState.isLoading) {
      return null;
    }
    
    // If not authenticated and trying to access protected route
    if (!authState.isAuthenticated && requiresAuth(currentRoute)) {
      return AppRoutes.login;
    }
    
    // If authenticated and on auth pages, redirect to home
    if (authState.isAuthenticated && 
        (currentRoute == AppRoutes.login || currentRoute == AppRoutes.splash)) {
      return AppRoutes.home;
    }
    
    // Check learning content access
    if (currentRoute.startsWith('/sections/') && 
        !canAccessLearningContent(currentRoute, ref)) {
      return AppRoutes.home;
    }
    
    return null;
  }
}

/// Navigation helper mixin for widgets
mixin NavigationHelper {
  /// Navigate to login screen
  void goToLogin(BuildContext context) {
    context.go(AppRoutes.login);
  }

  /// Navigate to home screen
  void goToHome(BuildContext context) {
    context.go(AppRoutes.home);
  }

  /// Navigate to specific section
  void goToSection(BuildContext context, String sectionId) {
    context.go('${AppRoutes.sections}/$sectionId');
  }

  /// Navigate to specific chapter
  void goToChapter(BuildContext context, String sectionId, String chapterId) {
    context.go('${AppRoutes.sections}/$sectionId/chapters/$chapterId');
  }

  /// Navigate with custom transition
  void navigateWithSlideTransition(
    BuildContext context,
    Widget destination, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: duration,
      ),
    );
  }

  /// Show confirmation dialog before navigation
  Future<bool> showNavigationConfirmation(
    BuildContext context, {
    String title = 'Leave this page?',
    String message = 'Your progress may not be saved.',
    String confirmText = 'Leave',
    String cancelText = 'Stay',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    
    return result ?? false;
  }
}

/// Navigation analytics and logging
class NavigationAnalytics {
  NavigationAnalytics._();
  
  static final NavigationAnalytics _instance = NavigationAnalytics._();
  static NavigationAnalytics get instance => _instance;

  final List<String> _navigationHistory = [];
  
  /// Track navigation events
  void trackNavigation(String from, String to) {
    _navigationHistory.add('$from -> $to');
    debugPrint('Navigation: $from -> $to');
    
    // In a real app, send to analytics service
    _logToAnalytics(from, to);
  }

  /// Get navigation history
  List<String> get navigationHistory => List.unmodifiable(_navigationHistory);

  /// Clear navigation history
  void clearHistory() {
    _navigationHistory.clear();
  }

  /// Log to analytics service (placeholder)
  void _logToAnalytics(String from, String to) {
    // In a real app, this would send data to services like:
    // - Firebase Analytics
    // - Mixpanel
    // - Custom analytics backend
    debugPrint('Analytics: Screen transition logged');
  }

  /// Track user engagement with specific sections
  void trackSectionEngagement(String sectionId, Duration timeSpent) {
    debugPrint('Section Engagement: $sectionId - ${timeSpent.inMinutes} minutes');
    // Send to analytics service
  }

  /// Track learning progress milestones
  void trackProgressMilestone(String event, Map<String, dynamic> properties) {
    debugPrint('Progress Milestone: $event - $properties');
    // Send to analytics service
  }
}

/// Deep linking handler
class DeepLinkHandler {
  DeepLinkHandler._();
  
  static final DeepLinkHandler _instance = DeepLinkHandler._();
  static DeepLinkHandler get instance => _instance;

  /// Handle deep link URLs
  String? handleDeepLink(String url, WidgetRef ref) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    // Handle different deep link patterns
    if (uri.pathSegments.isNotEmpty) {
      final firstSegment = uri.pathSegments.first;
      
      switch (firstSegment) {
        case 'section':
          if (uri.pathSegments.length >= 2) {
            final sectionId = uri.pathSegments[1];
            return '${AppRoutes.sections}/$sectionId';
          }
          break;
        case 'chapter':
          if (uri.pathSegments.length >= 3) {
            final sectionId = uri.pathSegments[1];
            final chapterId = uri.pathSegments[2];
            return '${AppRoutes.sections}/$sectionId/chapters/$chapterId';
          }
          break;
        case 'profile':
          return AppRoutes.profile;
        case 'settings':
          return AppRoutes.settings;
      }
    }

    // Default fallback
    return AppRoutes.home;
  }

  /// Generate shareable deep links
  String generateSectionLink(String sectionId) {
    return 'flutterlearning://section/$sectionId';
  }

  String generateChapterLink(String sectionId, String chapterId) {
    return 'flutterlearning://chapter/$sectionId/$chapterId';
  }
}