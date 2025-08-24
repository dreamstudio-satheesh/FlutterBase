import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/learning/screens/home_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import 'navigation_service.dart';

/// Application routes
class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  
  // Learning routes
  static const String sections = '/sections';
  static const String section = '/sections/:sectionId';
  static const String chapter = '/sections/:sectionId/chapters/:chapterId';
  
  // Learning specific sections
  static const String flutterBasics = '/sections/flutter-basics';
  static const String stateManagement = '/sections/state-management';
  static const String performance = '/sections/performance';
}

/// Router configuration provider
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  
  final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.splash,
    navigatorKey: NavigationService.instance._router?.routerDelegate.navigatorKey,
    redirect: (context, state) {
      // Use RouteGuard for centralized redirect logic
      return RouteGuard.getRedirectRoute(state.matchedLocation, ref);
    },
    routes: [
      // Splash Screen
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Authentication Routes
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      
      // Main App Routes (Protected)
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      
      // Learning Section Routes
      GoRoute(
        path: AppRoutes.sections,
        name: 'sections',
        builder: (context, state) => const Placeholder(), // TODO: Create SectionsScreen
        routes: [
          // Individual Section
          GoRoute(
            path: ':sectionId',
            name: 'section',
            builder: (context, state) {
              final sectionId = state.pathParameters['sectionId']!;
              return Placeholder(); // TODO: Create SectionDetailScreen
            },
            routes: [
              // Chapter within Section
              GoRoute(
                path: 'chapters/:chapterId',
                name: 'chapter',
                builder: (context, state) {
                  final sectionId = state.pathParameters['sectionId']!;
                  final chapterId = state.pathParameters['chapterId']!;
                  return Placeholder(); // TODO: Create ChapterScreen
                },
              ),
            ],
          ),
        ],
      ),
      
      // Profile Routes
      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        builder: (context, state) => const Placeholder(), // TODO: Create ProfileScreen
      ),
      
      // Settings Routes
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => const Placeholder(), // TODO: Create SettingsScreen
      ),
    ],
    errorBuilder: (context, state) => _ErrorScreen(error: state.error),
  );
  
  // Set the router instance in NavigationService
  NavigationService.instance.setRouter(router);
  
  return router;
});

/// Error screen for navigation errors
class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({required this.error});
  
  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Oops! Page not found',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? 'The page you are looking for does not exist.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Navigation helper extensions
extension GoRouterExtensions on GoRouter {
  /// Navigate to login screen
  void goToLogin() => go(AppRoutes.login);
  
  /// Navigate to home screen
  void goToHome() => go(AppRoutes.home);
  
  /// Navigate to specific learning section
  void goToSection(String sectionId) => go('${AppRoutes.sections}/$sectionId');
  
  /// Navigate to specific chapter
  void goToChapter(String sectionId, String chapterId) => 
      go('${AppRoutes.sections}/$sectionId/chapters/$chapterId');
  
  /// Navigate to profile
  void goToProfile() => go(AppRoutes.profile);
  
  /// Navigate to settings
  void goToSettings() => go(AppRoutes.settings);
}