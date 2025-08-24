# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter learning app project that transforms a simple login app into a comprehensive Flutter education platform. The project follows a structured approach with sections (major modules) and chapters (sub-features), implementing 2025 Flutter best practices throughout.

## Development Commands

### Essential Flutter Commands
```bash
# Install dependencies
flutter pub get

# Run the app in development
flutter run

# Run app on specific device
flutter run -d chrome  # for web
flutter run -d android # for Android
flutter run -d ios     # for iOS

# Build for production
flutter build apk      # Android
flutter build ios      # iOS
flutter build web      # Web

# Clean build artifacts
flutter clean
```

### Testing Commands
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run tests with coverage
flutter test --coverage
```

### Code Quality Commands
```bash
# Analyze code for issues
flutter analyze

# Format code
dart format lib/ test/

# Check outdated dependencies
flutter pub outdated
```

## Architecture Overview

### Current State (Simple Architecture)
The app currently uses a basic single-file architecture with all screens in `lib/main.dart`:
- **SplashScreen**: Initial loading screen with 2-second delay
- **LoginScreen**: Authentication with hardcoded credentials (admin/1234)
- **HomeScreen**: Simple welcome screen
- Uses basic Navigator for routing between screens

### Target Architecture (Feature-First)
The project is designed to evolve into a feature-first architecture:

```
lib/
├── core/
│   ├── constants/     # App-wide constants, colors, strings
│   ├── themes/        # Material 3 theme configuration
│   ├── utils/         # Helper functions, extensions, validators
│   └── services/      # Core app services
├── features/
│   ├── auth/          # Authentication screens and logic
│   ├── learning/      # Learning sections and chapters
│   └── profile/       # User profile and progress
└── shared/
    ├── widgets/       # Reusable UI components
    └── models/        # Data models used across features
```

### Key Architectural Principles
- **State Management**: Transitioning from StatefulWidget to Riverpod
- **Navigation**: Migrating from Navigator to go_router for type-safe routing
- **Testing**: Comprehensive unit, widget, and integration tests
- **Performance**: Lazy loading, const constructors, optimized builds

## Development Workflow

The project follows a 40-task structured workflow divided into 4 phases:

1. **Foundation Phase (Tasks 1-10)**: Architecture setup, dependencies, core structure
2. **Content Creation Phase (Tasks 11-21)**: Learning content for 3 main sections
3. **Interactive Features Phase (Tasks 22-29)**: UI framework and interactive components
4. **Quality & Polish Phase (Tasks 30-40)**: Testing, accessibility, documentation

### Learning Content Structure
The app teaches Flutter through three main sections:
- **Flutter Basics**: Introduction, Widgets, Layouts
- **State Management**: Provider, Riverpod, Bloc patterns
- **Performance Optimization**: Lazy loading, Image optimization, DevTools

## Key Dependencies (Target State)

Based on the planned architecture, key dependencies will include:
- `flutter_riverpod` - State management
- `go_router` - Declarative routing
- `shared_preferences` or `hive` - Local storage
- `flutter_highlight` - Code syntax highlighting
- `mockito` - Testing mocks

## Authentication System

Current authentication uses hardcoded credentials:
- Username: `admin`
- Password: `1234`

This will be refactored into a proper authentication system with:
- Riverpod providers for auth state
- Secure credential validation
- Route guards for protected screens

## Testing Strategy

- **Unit Tests**: Core business logic and utilities
- **Widget Tests**: Individual UI components and screens
- **Integration Tests**: Complete user flows (splash → login → home)
- Current test file (`test/widget_test.dart`) needs updating for actual app structure

## Code Style and Linting

Uses `package:flutter_lints/flutter.yaml` for code analysis. Key practices:
- Prefer `const` constructors for better performance
- Use meaningful variable names and clear code structure
- Follow Flutter's official style guide
- Maintain consistent formatting with `dart format`

## Development Notes

- The project supports multi-platform deployment (Android, iOS, Web, Desktop)
- Current login flow: Splash (2s delay) → Login → Home
- All screens currently in single file but designed for modular refactoring
- Focus on educational value - code should be clear and well-documented for learning