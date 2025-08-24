import 'package:flutter/material.dart';
import '../../../shared/models/learning_section.dart';
import '../../../shared/models/learning_chapter.dart';
import '../../../core/constants/app_constants.dart';

/// Repository for managing learning content data
class LearningContentRepository {
  static final LearningContentRepository _instance = LearningContentRepository._();
  static LearningContentRepository get instance => _instance;
  
  LearningContentRepository._();

  /// Get all learning sections
  List<LearningSection> getAllSections() {
    return [
      _getFlutterBasicsSection(),
      _getStateManagementSection(),
      _getPerformanceSection(),
    ];
  }

  /// Get specific section by ID
  LearningSection? getSectionById(String sectionId) {
    final sections = getAllSections();
    try {
      return sections.firstWhere((section) => section.id == sectionId);
    } catch (e) {
      return null;
    }
  }

  /// Get chapters for a specific section
  List<LearningChapter> getChaptersForSection(String sectionId) {
    switch (sectionId) {
      case 'flutter-basics':
        return _getFlutterBasicsChapters();
      case 'state-management':
        return _getStateManagementChapters();
      case 'performance':
        return _getPerformanceChapters();
      default:
        return [];
    }
  }

  /// Get specific chapter by section and chapter ID
  LearningChapter? getChapter(String sectionId, String chapterId) {
    final chapters = getChaptersForSection(sectionId);
    try {
      return chapters.firstWhere((chapter) => chapter.id == chapterId);
    } catch (e) {
      return null;
    }
  }

  // Private methods for creating sections and chapters

  LearningSection _getFlutterBasicsSection() {
    return const LearningSection(
      id: 'flutter-basics',
      title: 'Flutter Basics',
      description: 'Learn the fundamentals of Flutter development from scratch',
      icon: Icons.flutter_dash,
      color: AppConstants.flutterBasicsColor,
      chapters: [
        'introduction',
        'widgets-fundamentals',
        'layouts',
        'interactive-exercises',
      ],
      estimatedTime: 120, // 2 hours
      difficulty: SectionDifficulty.beginner,
    );
  }

  LearningSection _getStateManagementSection() {
    return const LearningSection(
      id: 'state-management',
      title: 'State Management',
      description: 'Master different state management patterns in Flutter',
      icon: Icons.settings_suggest_outlined,
      color: AppConstants.stateManagementColor,
      chapters: [
        'provider-basics',
        'riverpod-advanced',
        'bloc-pattern',
        'hands-on-examples',
      ],
      estimatedTime: 180, // 3 hours
      difficulty: SectionDifficulty.intermediate,
    );
  }

  LearningSection _getPerformanceSection() {
    return const LearningSection(
      id: 'performance',
      title: 'Performance Optimization',
      description: 'Optimize your Flutter apps for production',
      icon: Icons.speed_outlined,
      color: AppConstants.performanceColor,
      chapters: [
        'lazy-loading',
        'image-optimization',
        'devtools-profiling',
      ],
      estimatedTime: 150, // 2.5 hours
      difficulty: SectionDifficulty.advanced,
    );
  }

  List<LearningChapter> _getFlutterBasicsChapters() {
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
            language: 'dart',
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

      // Chapter 2: Widgets Fundamentals
      const LearningChapter(
        id: 'widgets-fundamentals',
        sectionId: 'flutter-basics',
        title: 'Widget Fundamentals',
        content: '''
# Understanding Flutter Widgets 🧩

Widgets are the building blocks of every Flutter app. Everything you see on the screen is a widget - from simple text and buttons to complex layouts and animations.

## What Are Widgets?

In Flutter, **everything is a widget**. A widget is a description of part of a user interface. Widgets are:
- **Immutable**: Once created, they cannot be changed
- **Composable**: Complex widgets are built from simpler ones
- **Declarative**: You describe what the UI should look like

## Widget Tree Hierarchy

Flutter apps are structured as a tree of widgets:

```
MyApp
├── MaterialApp
    ├── Scaffold
        ├── AppBar
        │   └── Text("My App")
        └── Body
            └── Column
                ├── Text("Hello")
                └── ElevatedButton
                    └── Text("Click Me")
```

## Types of Widgets

### 1. **StatelessWidget** 
Widgets that don't change over time.

```dart
class WelcomeText extends StatelessWidget {
  final String name;
  
  const WelcomeText({Key? key, required this.name}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Text('Welcome, \$name!');
  }
}
```

### 2. **StatefulWidget**
Widgets that can change their state during the app's lifetime.

```dart
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;
  
  void _increment() {
    setState(() {
      _count++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: \$_count'),
        ElevatedButton(
          onPressed: _increment,
          child: Text('Increment'),
        ),
      ],
    );
  }
}
```

## Essential Widgets You Must Know

### Text Widget
Displays text with styling options.

```dart
Text(
  'Hello Flutter!',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
)
```

### Container Widget  
A versatile widget for styling and positioning.

```dart
Container(
  width: 200,
  height: 100,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.all(8),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        offset: Offset(2, 2),
        blurRadius: 4,
      ),
    ],
  ),
  child: Text('Styled Container'),
)
```

### Column & Row Widgets
Layout widgets for arranging children vertically or horizontally.

```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ],
)

Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Icon(Icons.home),
    Icon(Icons.search),
    Icon(Icons.settings),
  ],
)
```

### Button Widgets
Interactive widgets for user actions.

```dart
// Elevated Button (Primary action)
ElevatedButton(
  onPressed: () => print('Pressed!'),
  child: Text('Click Me'),
)

// Text Button (Secondary action)
TextButton(
  onPressed: () => print('Text pressed!'),
  child: Text('Text Button'),
)

// Outlined Button
OutlinedButton(
  onPressed: () => print('Outlined pressed!'),
  child: Text('Outlined'),
)
```

## Widget Lifecycle

### StatelessWidget Lifecycle
1. **Constructor** - Widget created
2. **build()** - UI rendered
3. **Widget disposed** - When removed from tree

### StatefulWidget Lifecycle
1. **Constructor** - Widget created  
2. **createState()** - State object created
3. **initState()** - Initialize state
4. **build()** - UI rendered
5. **setState()** - Trigger rebuild
6. **dispose()** - Clean up resources

## Best Practices

### ✅ **Do:**
- Use `const` constructors when possible
- Keep widgets small and focused
- Extract reusable widgets into separate classes
- Use meaningful names for widgets

### ❌ **Don't:**
- Create deeply nested widget trees
- Rebuild widgets unnecessarily
- Ignore the widget lifecycle
- Forget to dispose resources

## Widget Categories

### **Layout Widgets**
- `Container`, `Padding`, `Center`
- `Column`, `Row`, `Stack`
- `Expanded`, `Flexible`, `Spacer`

### **Input Widgets**
- `TextField`, `Checkbox`, `Switch`
- `Slider`, `DropdownButton`

### **Display Widgets**  
- `Text`, `Image`, `Icon`
- `Card`, `ListTile`, `Chip`

### **Material Design Widgets**
- `Scaffold`, `AppBar`, `FloatingActionButton`
- `Drawer`, `BottomNavigationBar`

## Key Concepts to Remember

1. **Composition over Inheritance** - Build complex UIs by combining simple widgets
2. **Widget Rebuild** - Flutter rebuilds widgets when state changes
3. **Keys** - Help Flutter identify widgets during rebuilds
4. **Context** - Provides information about widget's location in the tree

## Next Steps

Now that you understand widgets, you're ready to:
- ✅ Create your own custom widgets
- ✅ Understand when to use StatelessWidget vs StatefulWidget  
- ✅ Build responsive layouts with layout widgets
- ✅ Handle user interactions with buttons and forms

> 💡 **Pro Tip**: Start with simple widgets and gradually build complexity. The Flutter Inspector in your IDE is invaluable for understanding the widget tree!
        ''',
        order: 2,
        estimatedReadTime: 15,
        codeExamples: [
          CodeExample(
            id: 'stateless-widget',
            title: 'StatelessWidget Example',
            code: '''
class WelcomeCard extends StatelessWidget {
  final String name;
  final String message;
  
  const WelcomeCard({
    Key? key, 
    required this.name,
    this.message = 'Welcome to Flutter!',
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, \$name!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}''',
            language: 'dart',
            explanation: 'A reusable StatelessWidget that displays a welcome card with customizable name and message.',
            isRunnable: true,
          ),
          CodeExample(
            id: 'stateful-counter',
            title: 'StatefulWidget Counter',
            code: '''
class CounterWidget extends StatefulWidget {
  const CounterWidget({Key? key}) : super(key: key);
  
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;
  
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Counter Value:',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            '\$_counter',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _incrementCounter,
                child: Text('Increment'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: _resetCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}''',
            language: 'dart',
            explanation: 'A StatefulWidget that demonstrates state management with a counter that can be incremented and reset.',
            isRunnable: true,
          ),
          CodeExample(
            id: 'styled-container',
            title: 'Styled Container Widget',
            code: '''
class StyledContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  
  const StyledContainer({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.blue,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            offset: Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 0,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            backgroundColor,
            backgroundColor.withOpacity(0.8),
          ],
        ),
      ),
      child: child,
    );
  }
}

// Usage example:
StyledContainer(
  backgroundColor: Colors.purple,
  child: Text(
    'Beautiful Container!',
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
)''',
            language: 'dart',
            explanation: 'A custom container widget with gradient background, shadow, and rounded corners.',
            isRunnable: true,
          ),
        ],
        prerequisites: ['introduction'],
        learningObjectives: [
          'Understand the concept of widgets and widget tree',
          'Differentiate between StatelessWidget and StatefulWidget',
          'Learn essential Flutter widgets (Text, Container, Column, Row, Buttons)',
          'Master widget lifecycle and state management basics',
          'Apply best practices for widget composition',
        ],
      ),

      // More chapters will be added in subsequent tasks...
    ];
  }

  List<LearningChapter> _getStateManagementChapters() {
    return [
      // Placeholder chapters - will be implemented in tasks 15-18
      const LearningChapter(
        id: 'provider-basics',
        sectionId: 'state-management',
        title: 'Provider Basics',
        content: 'Coming soon...',
        order: 1,
        estimatedReadTime: 15,
      ),
    ];
  }

  List<LearningChapter> _getPerformanceChapters() {
    return [
      // Placeholder chapters - will be implemented in tasks 19-21
      const LearningChapter(
        id: 'lazy-loading',
        sectionId: 'performance',
        title: 'Lazy Loading Lists',
        content: 'Coming soon...',
        order: 1,
        estimatedReadTime: 12,
      ),
    ];
  }

  /// Search chapters by query
  List<LearningChapter> searchChapters(String query) {
    final allChapters = <LearningChapter>[];
    
    // Get all chapters from all sections
    for (final section in getAllSections()) {
      allChapters.addAll(getChaptersForSection(section.id));
    }
    
    // Filter by query
    return allChapters.where((chapter) {
      return chapter.title.toLowerCase().contains(query.toLowerCase()) ||
             chapter.content.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  /// Get chapters by difficulty
  List<LearningChapter> getChaptersByDifficulty(SectionDifficulty difficulty) {
    final sections = getAllSections().where((section) => section.difficulty == difficulty);
    final chapters = <LearningChapter>[];
    
    for (final section in sections) {
      chapters.addAll(getChaptersForSection(section.id));
    }
    
    return chapters;
  }

  /// Get total estimated time for all content
  int getTotalEstimatedTime() {
    return getAllSections()
        .map((section) => section.estimatedTime)
        .fold(0, (sum, time) => sum + time);
  }

  /// Get section progress summary
  Map<String, dynamic> getSectionSummary(String sectionId) {
    final section = getSectionById(sectionId);
    final chapters = getChaptersForSection(sectionId);
    
    if (section == null) return {};
    
    return {
      'section': section,
      'chapters': chapters,
      'totalChapters': chapters.length,
      'estimatedTime': section.estimatedTime,
      'difficulty': section.difficulty.displayName,
    };
  }
}