import '../../../../shared/models/learning_chapter.dart';

/// Flutter Basics section content
class FlutterBasicsContent {
  static List<LearningChapter> getChapters() {
    return [
      // Chapter 1: Introduction
      const LearningChapter(
        id: 'introduction',
        sectionId: 'flutter-basics',
        title: 'Introduction to Flutter',
        content: '''
# Welcome to Flutter! 🚀

Flutter is Google's revolutionary UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.

## What Makes Flutter Special?

### 🎯 **Single Codebase, Multiple Platforms**
Write once, run everywhere! Flutter allows you to create apps for:
- iOS and Android (Mobile)
- Web browsers
- Windows, macOS, and Linux (Desktop)

### ⚡ **Fast Development**
- **Hot Reload**: See changes instantly without losing app state
- **Rich Widget Library**: Pre-built components for Material and Cupertino design
- **Flexible UI**: Create custom designs with ease

### 🚀 **High Performance**
- Compiles to native ARM code
- 60fps animations out of the box
- Small app bundle sizes

## Flutter Architecture

Flutter uses a **reactive framework** where UI is built with widgets. Everything in Flutter is a widget!

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello Flutter!'),
        ),
        body: Center(
          child: Text(
            'Welcome to Flutter!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
```

## Key Concepts to Remember

1. **Everything is a Widget**: UI elements, layouts, animations
2. **Declarative UI**: Describe what the UI should look like
3. **Composition over Inheritance**: Build complex widgets from simple ones
4. **Immutable Widgets**: Widgets are immutable; state changes trigger rebuilds

## What You'll Learn in This Section

By the end of this section, you'll be able to:
- ✅ Understand Flutter's widget-based architecture
- ✅ Create your first Flutter app
- ✅ Use basic widgets like Text, Container, and Button
- ✅ Understand the difference between StatelessWidget and StatefulWidget
- ✅ Create responsive layouts with Flutter's layout widgets

## Let's Get Started!

Ready to dive into the world of Flutter development? In the next chapter, we'll explore widgets in detail and start building our first interactive app!

> 💡 **Pro Tip**: The best way to learn Flutter is by building. Follow along with the code examples and experiment with them!
        ''',
        order: 1,
        estimatedReadTime: 8,
        codeExamples: [
          CodeExample(
            id: 'hello-world',
            title: 'Hello World App',
            language: 'dart',
            code: '''
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Center(
          child: Text(
            'Hello, Flutter World!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}''',
            explanation: 'This is a basic Flutter app that displays "Hello, Flutter World!" in the center of the screen.',
            isRunnable: true,
          ),
        ],
        learningObjectives: [
          'Understand what Flutter is and its advantages',
          'Learn about Flutter\'s architecture and widget system',
          'Recognize the declarative UI paradigm',
          'Identify key Flutter concepts for further learning',
        ],
      ),

      // Chapter 2: Widgets Fundamentals - Placeholder for now
      const LearningChapter(
        id: 'widgets-fundamentals',
        sectionId: 'flutter-basics',
        title: 'Widget Fundamentals',
        content: 'Complete widget fundamentals content will be here...',
        order: 2,
        estimatedReadTime: 15,
        codeExamples: [],
        learningObjectives: [],
      ),

      // Chapter 3: Layouts - Placeholder for now
      const LearningChapter(
        id: 'layouts',
        sectionId: 'flutter-basics',
        title: 'Mastering Layouts',
        content: 'Complete layouts content will be here...',
        order: 3,
        estimatedReadTime: 20,
        codeExamples: [],
        learningObjectives: [],
      ),

      // Chapter 4: Interactive Exercises - Placeholder for now
      const LearningChapter(
        id: 'interactive-exercises',
        sectionId: 'flutter-basics',
        title: 'Interactive Exercises',
        content: 'Complete interactive exercises content will be here...',
        order: 4,
        estimatedReadTime: 45,
        codeExamples: [],
        learningObjectives: [],
      ),
    ];
  }
}