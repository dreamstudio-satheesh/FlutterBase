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

      // Chapter 3: Layouts
      const LearningChapter(
        id: 'layouts',
        sectionId: 'flutter-basics',
        title: 'Mastering Layouts',
        content: '''
# Flutter Layouts Mastery 📐

Building beautiful, responsive layouts is at the heart of Flutter development. Understanding how to arrange widgets effectively will transform your app's user experience.

## Layout Fundamentals

In Flutter, everything is about **composition**. You build complex layouts by combining simple layout widgets in a tree structure.

### Key Layout Principles

1. **Constraints flow down** - Parent widgets pass size constraints to children
2. **Sizes flow up** - Children report their size back to parents  
3. **Parent sets position** - Parents decide where to place children

## Essential Layout Widgets

### 1. **Container** - The Swiss Army Knife

Container is the most versatile layout widget for single-child layouts.

```dart
Container(
  width: 200,
  height: 150,
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.symmetric(vertical: 8),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.blue.withOpacity(0.3),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Text(
    'Beautiful Container',
    style: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
)
```

### 2. **Row & Column** - Linear Layouts

Perfect for arranging widgets in horizontal or vertical lines.

#### Row Layout (Horizontal)
```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Icon(Icons.home, size: 32, color: Colors.blue),
    Icon(Icons.favorite, size: 32, color: Colors.red),
    Icon(Icons.settings, size: 32, color: Colors.grey),
  ],
)
```

#### Column Layout (Vertical)
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Welcome', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('to Flutter Layouts', style: TextStyle(fontSize: 18)),
    SizedBox(height: 16),
    ElevatedButton(
      onPressed: () => print('Button pressed!'),
      child: Text('Get Started'),
    ),
  ],
)
```

## MainAxis vs CrossAxis

Understanding these concepts is crucial for mastering Row and Column layouts:

### For Row (Horizontal):
- **MainAxis** = Horizontal (left to right)
- **CrossAxis** = Vertical (top to bottom)

### For Column (Vertical):
- **MainAxis** = Vertical (top to bottom)  
- **CrossAxis** = Horizontal (left to right)

## Alignment Options

### MainAxisAlignment
- `start` - Beginning of the main axis
- `end` - End of the main axis
- `center` - Center of the main axis
- `spaceBetween` - Space between children
- `spaceAround` - Space around children
- `spaceEvenly` - Even space distribution

### CrossAxisAlignment
- `start` - Beginning of the cross axis
- `end` - End of the cross axis
- `center` - Center of the cross axis
- `stretch` - Stretch to fill cross axis
- `baseline` - Align text baselines

## Flexible Layouts

### 3. **Expanded** - Fill Available Space

```dart
Row(
  children: [
    Container(
      width: 50,
      height: 50,
      color: Colors.red,
    ),
    Expanded(
      child: Container(
        height: 50,
        color: Colors.blue,
        child: Center(child: Text('Expands to fill space')),
      ),
    ),
    Container(
      width: 50,
      height: 50,
      color: Colors.green,
    ),
  ],
)
```

### 4. **Flexible** - Flexible Space Usage

```dart
Column(
  children: [
    Flexible(
      flex: 1,
      child: Container(
        width: double.infinity,
        color: Colors.red,
        child: Center(child: Text('Flex: 1')),
      ),
    ),
    Flexible(
      flex: 2,
      child: Container(
        width: double.infinity,
        color: Colors.blue,
        child: Center(child: Text('Flex: 2')),
      ),
    ),
    Flexible(
      flex: 1,
      child: Container(
        width: double.infinity,
        color: Colors.green,
        child: Center(child: Text('Flex: 1')),
      ),
    ),
  ],
)
```

## Advanced Layout Widgets

### 5. **Stack** - Overlapping Widgets

Perfect for creating layered UIs with overlapping elements.

```dart
Stack(
  children: [
    Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blue],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    Positioned(
      top: 20,
      left: 20,
      child: Icon(
        Icons.star,
        color: Colors.white,
        size: 32,
      ),
    ),
    Positioned(
      bottom: 20,
      right: 20,
      child: Text(
        'Overlay Text',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
)
```

### 6. **Wrap** - Flowing Layouts

When you need widgets to wrap to the next line/column automatically.

```dart
Wrap(
  spacing: 8.0,
  runSpacing: 8.0,
  children: [
    Chip(label: Text('Flutter')),
    Chip(label: Text('Dart')),
    Chip(label: Text('Mobile')),
    Chip(label: Text('Development')),
    Chip(label: Text('UI')),
    Chip(label: Text('Cross Platform')),
    Chip(label: Text('Google')),
    Chip(label: Text('Open Source')),
  ],
)
```

### 7. **GridView** - Grid Layouts

Perfect for displaying items in a grid pattern.

```dart
GridView.count(
  crossAxisCount: 2,
  crossAxisSpacing: 16,
  mainAxisSpacing: 16,
  padding: EdgeInsets.all(16),
  children: [
    Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Text('Item 1', style: TextStyle(color: Colors.white))),
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Text('Item 2', style: TextStyle(color: Colors.white))),
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Text('Item 3', style: TextStyle(color: Colors.white))),
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Text('Item 4', style: TextStyle(color: Colors.white))),
    ),
  ],
)
```

## Responsive Design Patterns

### MediaQuery for Screen Information

```dart
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isTablet = screenWidth > 600;
  
  return Container(
    padding: EdgeInsets.all(isTablet ? 32 : 16),
    child: Column(
      children: [
        Text(
          'Responsive Design',
          style: TextStyle(
            fontSize: isTablet ? 32 : 24,
          ),
        ),
        // Adapt layout based on screen size
        if (isTablet)
          Row(
            children: [
              Expanded(child: _buildContent()),
              SizedBox(width: 32),
              Expanded(child: _buildSidebar()),
            ],
          )
        else
          Column(
            children: [
              _buildContent(),
              SizedBox(height: 16),
              _buildSidebar(),
            ],
          ),
      ],
    ),
  );
}
```

### LayoutBuilder for Constraint-Based Design

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      // Wide layout (tablet/desktop)
      return Row(
        children: [
          Expanded(flex: 2, child: _buildMainContent()),
          Expanded(flex: 1, child: _buildSidebar()),
        ],
      );
    } else {
      // Narrow layout (mobile)
      return Column(
        children: [
          _buildMainContent(),
          _buildSidebar(),
        ],
      );
    }
  },
)
```

## Common Layout Patterns

### 1. **Card Layout**
```dart
Card(
  elevation: 4,
  margin: EdgeInsets.all(16),
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Card Title', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Card subtitle or description goes here.'),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: () {}, child: Text('CANCEL')),
            SizedBox(width: 8),
            ElevatedButton(onPressed: () {}, child: Text('OK')),
          ],
        ),
      ],
    ),
  ),
)
```

### 2. **List Item Layout**
```dart
ListTile(
  leading: CircleAvatar(
    backgroundColor: Colors.blue,
    child: Icon(Icons.person, color: Colors.white),
  ),
  title: Text('John Doe'),
  subtitle: Text('Flutter Developer'),
  trailing: Icon(Icons.arrow_forward_ios),
  onTap: () => print('Tapped!'),
)
```

### 3. **Bottom Sheet Layout**
```dart
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      SizedBox(height: 16),
      Text('Bottom Sheet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      SizedBox(height: 16),
      // Content goes here
    ],
  ),
)
```

## Layout Debugging Tips

### 1. **Container with Color**
Add colored containers to visualize layout boundaries:
```dart
Container(
  color: Colors.red.withOpacity(0.3), // Temporary debug color
  child: YourWidget(),
)
```

### 2. **Flutter Inspector**
Use Flutter Inspector in your IDE to:
- Visualize the widget tree
- See widget properties
- Understand layout constraints

### 3. **Debug Paint**
Show widget boundaries in debug mode:
```dart
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true; // Shows widget boundaries
  runApp(MyApp());
}
```

## Best Practices

### ✅ **Do:**
- Use `const` constructors for static layouts
- Choose the right layout widget for your use case
- Consider responsive design from the start
- Use `Expanded` and `Flexible` for dynamic sizing
- Test on different screen sizes

### ❌ **Don't:**
- Nest unnecessary layout widgets
- Hardcode pixel values for responsive layouts
- Ignore overflow errors
- Use `Row`/`Column` with many children (use `ListView` instead)
- Forget about accessibility in your layouts

## Layout Performance Tips

1. **Avoid deep widget trees** - Keep layouts shallow
2. **Use ListView.builder** for long lists instead of Column with many children
3. **Implement lazy loading** for expensive layouts
4. **Profile your layouts** using Flutter DevTools
5. **Consider using Slivers** for complex scrolling layouts

## Next Steps

Master these layout concepts to build:
- ✅ Responsive designs that work on all screen sizes
- ✅ Complex UIs with proper widget composition  
- ✅ Smooth scrolling experiences
- ✅ Professional-looking app interfaces

> 💡 **Pro Tip**: Start with simple layouts and gradually add complexity. The Flutter Inspector is your best friend for understanding layout behavior!
        ''',
        order: 3,
        estimatedReadTime: 20,
        codeExamples: [
          CodeExample(
            id: 'responsive-card',
            title: 'Responsive Card Layout',
            code: '''
class ResponsiveCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const ResponsiveCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 400;
        
        return Card(
          elevation: 4,
          margin: EdgeInsets.all(16),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: EdgeInsets.all(isWide ? 24 : 16),
              child: isWide
                  ? Row(
                      children: [
                        _buildIcon(),
                        SizedBox(width: 24),
                        Expanded(child: _buildContent()),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _buildIcon(),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                        SizedBox(height: 16),
                        _buildContent(),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: Colors.blue,
        size: 32,
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}''',
            language: 'dart',
            explanation: 'A responsive card that adapts its layout based on available width, switching between row and column layouts.',
            isRunnable: true,
          ),
          CodeExample(
            id: 'flexible-layout',
            title: 'Flexible Space Distribution',
            code: '''
class FlexibleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flexible Layout Demo')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Example 1: Basic Flexible
            Text('Basic Flexible Distribution', 
                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Container(
              height: 100,
              child: Row(
                children: [
                  Container(
                    width: 60,
                    color: Colors.red,
                    child: Center(child: Text('Fixed')),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      color: Colors.blue,
                      child: Center(child: Text('Flex: 1')),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      color: Colors.green,
                      child: Center(child: Text('Flex: 2')),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 32),
            
            // Example 2: Expanded vs Flexible
            Text('Expanded vs Flexible', 
                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Container(
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.orange,
                      child: Center(child: Text('Expanded\\n(Must fill)')),
                    ),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Container(
                      color: Colors.purple,
                      child: Center(child: Text('Flexible\\n(Can shrink)')),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 32),
            
            // Example 3: Complex Layout
            Text('Complex Layout Example', 
                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      color: Colors.blue[100],
                      child: Center(child: Text('Header')),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Container(
                              color: Colors.green[100],
                              child: Center(child: Text('Main Content\\n(Flex: 2)')),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              color: Colors.orange[100],
                              child: Center(child: Text('Sidebar\\n(Flex: 1)')),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      color: Colors.grey[200],
                      child: Center(child: Text('Footer')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}''',
            language: 'dart',
            explanation: 'Comprehensive demonstration of Flexible, Expanded, and complex layout patterns with visual examples.',
            isRunnable: true,
          ),
          CodeExample(
            id: 'stack-overlay',
            title: 'Stack Overlay Example',
            code: '''
class StackOverlayCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final bool isFavorite;

  const StackOverlayCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Background Image/Color
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple,
                  Colors.blue,
                  Colors.teal,
                ],
              ),
            ),
          ),
          
          // Overlay pattern
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          
          // Top-right favorite icon
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey[600],
                size: 20,
              ),
            ),
          ),
          
          // Bottom content
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Play button overlay
          Positioned.fill(
            child: Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.blue,
                  size: 36,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Usage example:
StackOverlayCard(
  imageUrl: 'https://example.com/image.jpg',
  title: 'Flutter Layouts',
  description: 'Master the art of Flutter layouts',
  isFavorite: true,
)''',
            language: 'dart',
            explanation: 'Advanced Stack example showing how to create layered UIs with positioned elements, gradients, and overlays.',
            isRunnable: true,
          ),
        ],
        prerequisites: ['introduction', 'widgets-fundamentals'],
        learningObjectives: [
          'Understand Flutter layout system and constraint propagation',
          'Master essential layout widgets (Container, Row, Column, Stack)',
          'Learn flexible layouts with Expanded and Flexible widgets',
          'Build responsive designs using MediaQuery and LayoutBuilder',
          'Apply common layout patterns and best practices',
          'Debug layout issues effectively using Flutter tools',
        ],
      ),

      // Chapter 4: Interactive Exercises
      const LearningChapter(
        id: 'interactive-exercises',
        sectionId: 'flutter-basics',
        title: 'Interactive Exercises',
        content: '''
# Interactive Exercises

Put your Flutter knowledge to the test with these hands-on exercises! Practice what you've learned about widgets, layouts, and basic Flutter concepts.

## Exercise 1: Build Your First Widget

Create a simple greeting widget that displays your name and a welcome message.

**Task**: Create a widget that:
- Shows "Welcome to Flutter!" as a title
- Displays your name below the title
- Uses different text styles for the title and name
- Centers everything on the screen

### Solution Structure
```dart
class GreetingWidget extends StatelessWidget {
  final String name;
  
  const GreetingWidget({
    Key? key,
    required this.name,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to Flutter!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Hello, \$name!',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
```

## Exercise 2: Layout Challenge

Create a profile card layout using various layout widgets.

**Task**: Build a profile card that contains:
- A circular avatar at the top
- Name and job title below the avatar
- A row of social media icons
- A bio text section
- Action buttons at the bottom

### Key Concepts Practiced
- Container for styling and padding
- Column for vertical arrangement
- Row for horizontal arrangement
- CircleAvatar for profile image
- Styling with BoxDecoration

### Solution Hints
```dart
class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar section
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            SizedBox(height: 15),
            
            // Name and title
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Flutter Developer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Social media icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.facebook, color: Colors.blue),
                Icon(Icons.link, color: Colors.blue),
                Icon(Icons.email, color: Colors.red),
              ],
            ),
            
            SizedBox(height: 15),
            
            // Bio
            Text(
              'Passionate Flutter developer creating beautiful mobile experiences. Love clean code and great UX.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
            
            SizedBox(height: 20),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Follow'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('Message'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## Exercise 3: Interactive Counter

Build the classic Flutter counter with your own styling and enhancements.

**Task**: Create an enhanced counter app that:
- Shows the current count
- Has increment and decrement buttons
- Changes color based on the count value
- Shows different messages for different count ranges
- Resets to zero with a reset button

### Key Concepts Practiced
- StatefulWidget and state management
- Conditional styling
- Button interactions
- setState() method

### Solution Framework
```dart
class EnhancedCounter extends StatefulWidget {
  @override
  _EnhancedCounterState createState() => _EnhancedCounterState();
}

class _EnhancedCounterState extends State<EnhancedCounter> {
  int _counter = 0;
  
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  
  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }
  
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }
  
  Color _getCounterColor() {
    if (_counter == 0) return Colors.grey;
    if (_counter < 5) return Colors.blue;
    if (_counter < 10) return Colors.green;
    return Colors.red;
  }
  
  String _getCounterMessage() {
    if (_counter == 0) return 'Start counting!';
    if (_counter < 5) return 'Getting started';
    if (_counter < 10) return 'Good progress!';
    return 'Wow, that\'s high!';
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enhanced Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getCounterMessage(),
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: _getCounterColor().withOpacity(0.1),
                border: Border.all(
                  color: _getCounterColor(),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(75),
              ),
              child: Center(
                child: Text(
                  '\$_counter',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: _getCounterColor(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: _decrementCounter,
                  child: Icon(Icons.remove),
                  backgroundColor: Colors.red,
                  heroTag: 'decrement',
                ),
                FloatingActionButton(
                  onPressed: _resetCounter,
                  child: Icon(Icons.refresh),
                  backgroundColor: Colors.grey,
                  heroTag: 'reset',
                ),
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  child: Icon(Icons.add),
                  backgroundColor: Colors.green,
                  heroTag: 'increment',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## Exercise 4: Custom Card Gallery

Create a scrollable gallery of custom cards showcasing different layout techniques.

**Task**: Build a gallery that demonstrates:
- Custom card designs with different layouts
- Horizontal scrolling
- Various alignment and positioning techniques
- Mix of images, text, and icons

### Key Concepts Practiced
- ListView and SingleChildScrollView
- Custom card layouts
- Asset management
- Mixed layout patterns

### Challenge Points
1. Create at least 5 different card designs
2. Each card should showcase a different layout pattern
3. Include proper spacing and visual hierarchy
4. Add subtle animations or hover effects

## Exercise 5: Responsive Grid

Build a responsive photo grid that adapts to different screen sizes.

**Task**: Create a photo grid that:
- Shows 2 columns on phones
- Shows 3 columns on tablets
- Shows 4 columns on larger screens
- Has proper aspect ratios for images
- Includes overlay text and icons

### Key Concepts Practiced
- MediaQuery for responsive design
- GridView with dynamic column count
- AspectRatio widget
- Stack for overlay content

### Bonus Challenges
- Add a search functionality
- Implement pull-to-refresh
- Add image zoom capability
- Include loading states

## Testing Your Knowledge

After completing these exercises, you should be comfortable with:

✅ **Widget Composition**: Combining multiple widgets to create complex UIs
✅ **Layout Systems**: Using Row, Column, Stack, and other layout widgets effectively
✅ **State Management**: Managing widget state with StatefulWidget
✅ **Responsive Design**: Creating UIs that work across different screen sizes
✅ **Styling**: Applying colors, padding, margins, and decorations
✅ **User Interaction**: Handling button presses and user input

## Next Steps

Once you've completed these exercises:
1. Experiment with different styling approaches
2. Try combining layouts in creative ways
3. Add animations to make your UIs more engaging
4. Move on to more advanced state management patterns

Remember: The best way to learn Flutter is by building! Don't be afraid to experiment and make mistakes – that's how you'll become proficient.
''',
        order: 4,
        estimatedReadTime: 45,
        prerequisites: [
          'Basic Flutter widget knowledge',
          'Understanding of StatelessWidget vs StatefulWidget',
          'Layout fundamentals (Row, Column, Container)',
          'Basic Dart syntax and classes',
        ],
        learningObjectives: [
          'Practice building real Flutter widgets from scratch',
          'Apply layout concepts in practical scenarios',
          'Understand state management with StatefulWidget',
          'Develop problem-solving skills for UI challenges',
          'Build confidence in Flutter development',
          'Learn debugging techniques for layout issues',
        ],
        codeExamples: [
          CodeExample(
            id: 'todo-app',
            title: 'Interactive Todo List',
            explanation: 'A fully functional todo list demonstrating state management, list handling, and user interactions.',
            code: '''
class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Todo> _todos = [];
  final _controller = TextEditingController();

  void _addTodo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todos.add(Todo(
          id: DateTime.now().millisecondsSinceEpoch,
          title: _controller.text,
          isCompleted: false,
        ));
        _controller.clear();
      });
    }
  }

  void _toggleTodo(int id) {
    setState(() {
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        _todos[index].isCompleted = !_todos[index].isCompleted;
      }
    });
  }

  void _deleteTodo(int id) {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List Exercise'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Add todo section
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter a todo item...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),
          
          // Todos list
          Expanded(
            child: _todos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.checklist,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No todos yet!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      final todo = _todos[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Checkbox(
                            value: todo.isCompleted,
                            onChanged: (_) => _toggleTodo(todo.id),
                          ),
                          title: Text(
                            todo.title,
                            style: TextStyle(
                              decoration: todo.isCompleted 
                                  ? TextDecoration.lineThrough 
                                  : null,
                              color: todo.isCompleted 
                                  ? Colors.grey 
                                  : null,
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteTodo(todo.id),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          
          // Statistics
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  'Total', 
                  _todos.length.toString(), 
                  Colors.blue,
                ),
                _buildStatItem(
                  'Completed', 
                  _todos.where((t) => t.isCompleted).length.toString(), 
                  Colors.green,
                ),
                _buildStatItem(
                  'Pending', 
                  _todos.where((t) => !t.isCompleted).length.toString(), 
                  Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class Todo {
  final int id;
  final String title;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
  });
}''',
            isRunnable: true,
          ),
          CodeExample(
            id: 'weather-card',
            title: 'Weather Card Exercise',
            explanation: 'Create a beautiful weather card showing current conditions with custom styling and layout techniques.',
            code: '''
class WeatherCard extends StatelessWidget {
  final String city;
  final int temperature;
  final String condition;
  final String iconCode;
  final int humidity;
  final int windSpeed;

  const WeatherCard({
    Key? key,
    required this.city,
    required this.temperature,
    required this.condition,
    required this.iconCode,
    required this.humidity,
    required this.windSpeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _getGradientColors(),
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      city,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      condition,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Icon(
                  _getWeatherIcon(),
                  size: 60,
                  color: Colors.white,
                ),
              ],
            ),
            
            SizedBox(height: 20),
            
            // Temperature
            Text(
              '\${temperature}°',
              style: TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.w100,
                color: Colors.white,
                height: 0.9,
              ),
            ),
            
            SizedBox(height: 20),
            
            // Weather details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '\${humidity}%',
                ),
                _buildDetailItem(
                  icon: Icons.air,
                  label: 'Wind',
                  value: '\${windSpeed} km/h',
                ),
                _buildDetailItem(
                  icon: Icons.thermostat,
                  label: 'Feels like',
                  value: '\${temperature + 2}°',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 20,
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  List<Color> _getGradientColors() {
    switch (condition.toLowerCase()) {
      case 'sunny':
        return [Colors.orange, Colors.amber];
      case 'rainy':
        return [Colors.blue[700]!, Colors.blue[500]!];
      case 'cloudy':
        return [Colors.grey[600]!, Colors.grey[400]!];
      default:
        return [Colors.blue[400]!, Colors.blue[200]!];
    }
  }

  IconData _getWeatherIcon() {
    switch (condition.toLowerCase()) {
      case 'sunny':
        return Icons.wb_sunny;
      case 'rainy':
        return Icons.grain;
      case 'cloudy':
        return Icons.wb_cloudy;
      default:
        return Icons.wb_sunny;
    }
  }
}''',
            isRunnable: true,
          ),
        ],
      ),
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