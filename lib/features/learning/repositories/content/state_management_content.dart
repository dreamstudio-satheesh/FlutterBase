import '../../../../shared/models/learning_chapter.dart';
import '../../../../shared/models/code_example.dart';

/// State Management section content
class StateManagementContent {
  static List<LearningChapter> getChapters() {
    return [
      // Chapter 1: Provider Basics
      const LearningChapter(
        id: 'provider-basics',
        sectionId: 'state-management',
        title: 'Provider Basics',
        content: '''
# Provider: State Management Made Simple 🔄

Provider is the most popular and officially recommended state management solution for Flutter. It's built on top of InheritedWidget and provides a simple, scalable way to manage app state.

## Why Provider?

### ✅ **Benefits**
- **Simple to learn**: Easy concepts and minimal boilerplate
- **Officially recommended**: Backed by the Flutter team
- **Performant**: Efficient widget rebuilds
- **Testable**: Easy to unit test your business logic
- **Flexible**: Works with any architectural pattern

### ❌ **When NOT to use Provider**
- Very simple apps with minimal state
- Apps requiring complex state logic (consider Bloc/Cubit)
- Teams preferring immutable state management

## Core Concepts

### 1. **ChangeNotifier**
The heart of Provider - a class that can notify listeners when it changes.

```dart
class Counter extends ChangeNotifier {
  int _count = 0;
  
  int get count => _count;
  
  void increment() {
    _count++;
    notifyListeners(); // Triggers UI rebuild
  }
  
  void decrement() {
    if (_count > 0) {
      _count--;
      notifyListeners();
    }
  }
  
  void reset() {
    _count = 0;
    notifyListeners();
  }
}
```

### 2. **ChangeNotifierProvider**
Provides the ChangeNotifier to the widget tree.

```dart
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}
```

### 3. **Consumer**
Listens to changes and rebuilds when the state changes.

```dart
class CounterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Counter>(
      builder: (context, counter, child) {
        return Column(
          children: [
            Text(
              'Count: \${counter.count}',
              style: TextStyle(fontSize: 24),
            ),
            if (child != null) child, // Static child optimization
          ],
        );
      },
      child: Text('This widget never rebuilds'),
    );
  }
}
```

## Next Steps

After mastering Provider basics:

1. ✅ **Learn advanced Provider patterns** (ProxyProvider, StreamProvider)
2. ✅ **Combine with Repository pattern** for clean architecture
3. ✅ **Explore Riverpod** - The next evolution of Provider
4. ✅ **Consider Bloc/Cubit** for complex state logic

> 💡 **Pro Tip**: Start simple with ChangeNotifierProvider, then graduate to more advanced patterns as your app grows in complexity!
        ''',
        order: 1,
        estimatedReadTime: 25,
        prerequisites: [
          'Understanding of StatefulWidget and setState',
          'Basic knowledge of Flutter widget tree',
          'Familiarity with Dart classes and inheritance',
          'Understanding of Observer pattern (helpful)',
        ],
        learningObjectives: [
          'Understand Provider as a state management solution',
          'Learn ChangeNotifier and ChangeNotifierProvider patterns',
          'Master Consumer, Provider.of(), and Selector widgets',
          'Build real-world apps using Provider architecture',
          'Implement multiple providers with MultiProvider',
          'Write testable code with Provider dependency injection',
          'Apply Provider best practices and avoid common pitfalls',
        ],
        codeExamples: [
          CodeExample(
            id: 'counter-provider',
            title: 'Basic Counter with Provider',
            explanation: 'A simple counter app demonstrating ChangeNotifier, ChangeNotifierProvider, and Consumer usage.',
            code: '''
// Counter Model
class Counter extends ChangeNotifier {
  int _count = 0;
  
  int get count => _count;
  
  void increment() {
    _count++;
    notifyListeners();
  }
  
  void decrement() {
    if (_count > 0) {
      _count--;
      notifyListeners();
    }
  }
  
  void reset() {
    _count = 0;
    notifyListeners();
  }
}

// Main App Setup
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Provider Counter')),
      body: Center(
        child: Consumer<Counter>(
          builder: (context, counter, child) {
            return Text(
              '\${counter.count}',
              style: TextStyle(fontSize: 48),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<Counter>(context, listen: false).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}''',
            isRunnable: true,
          ),
        ],
      ),

      // Chapter 2: Riverpod Advanced
      const LearningChapter(
        id: 'riverpod-advanced',
        sectionId: 'state-management',
        title: 'Riverpod: Next-Gen State Management',
        content: '''
# Riverpod: The Evolution of Provider 🚀

Riverpod is the next generation of Provider, built from the ground up to address Provider's limitations. It offers compile-time safety, better testability, and more powerful features while maintaining simplicity.

## Why Riverpod?

### ✅ **Advantages over Provider**
- **Compile-time safety**: Catch errors at compile time, not runtime
- **No BuildContext needed**: Access providers from anywhere
- **Better testing**: Easy dependency injection and mocking
- **Immutable by design**: Prevents common state mutation bugs
- **DevTools integration**: Excellent debugging experience
- **Auto-dispose**: Automatic resource cleanup

## Core Concepts

### 1. **Provider Declaration**
Providers are declared as global variables, making them accessible everywhere.

```dart
// Simple state provider
final counterProvider = StateProvider<int>((ref) => 0);

// Computed provider
final doubledCounterProvider = Provider<int>((ref) {
  final count = ref.watch(counterProvider);
  return count * 2;
});

// Async provider
final userProvider = FutureProvider<User>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getCurrentUser();
});
```

### 2. **ConsumerWidget**
Replace StatelessWidget with ConsumerWidget to access providers.

```dart
class CounterScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    
    return Scaffold(
      body: Center(
        child: Text('Count: \$count'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: Icon(Icons.add),
      ),
    );
  }
}
```

## Provider Types

### 1. **StateProvider**
For simple mutable state.

### 2. **StateNotifierProvider** 
For complex state management with immutable state.

### 3. **FutureProvider**
For asynchronous operations.

### 4. **StreamProvider**
For reactive data streams.

## Advanced Features

### 1. **Family Modifier**
Create providers that depend on parameters.

### 2. **AutoDispose Modifier**
Automatically dispose providers when no longer used.

### 3. **Select for Performance**
Watch only specific parts of complex state.

## Best Practices

### ✅ **Do:**
1. **Use appropriate provider types** for different scenarios
2. **Leverage .family and .autoDispose** modifiers when needed
3. **Keep providers focused** on single responsibilities
4. **Use select()** for performance optimization
5. **Test with provider overrides**

### ❌ **Don't:**
1. **Don't mutate state directly** - always use state = newState
2. **Don't forget to dispose** resources in StateNotifier
3. **Don't overuse .family** - consider alternatives for better performance
4. **Don't access ref.read** in build methods - use ref.watch instead

> 💡 **Pro Tip**: Riverpod shines in large applications. Start simple and gradually adopt more advanced features as your app grows!
        ''',
        order: 2,
        estimatedReadTime: 30,
        prerequisites: [
          'Understanding of Provider basics',
          'Familiarity with immutable data patterns',
          'Knowledge of async programming in Dart',
          'Basic understanding of state management concepts',
        ],
        learningObjectives: [
          'Understand Riverpod advantages over Provider',
          'Master different provider types (State, Future, Stream, etc.)',
          'Learn advanced modifiers (.family, .autoDispose, .select)',
          'Implement complex state management with StateNotifier',
          'Build reactive UIs with computed providers',
          'Write comprehensive tests with provider overrides',
          'Apply Riverpod best practices in real-world applications',
        ],
        codeExamples: [
          CodeExample(
            id: 'riverpod-basics',
            title: 'Riverpod Counter with State Management',
            explanation: 'A comprehensive counter app demonstrating StateProvider, computed providers, and ConsumerWidget usage.',
            code: '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Simple state provider
final counterProvider = StateProvider<int>((ref) => 0);

// Computed providers
final doubledCounterProvider = Provider<int>((ref) {
  final count = ref.watch(counterProvider);
  return count * 2;
});

final counterMessageProvider = Provider<String>((ref) {
  final count = ref.watch(counterProvider);
  
  if (count == 0) return 'Start counting!';
  if (count < 5) return 'Keep going!';
  if (count < 10) return 'Great progress!';
  return 'Amazing! You\\'re at \$count!';
});

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class CounterScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final message = ref.watch(counterMessageProvider);
    final doubled = ref.watch(doubledCounterProvider);
    
    return Scaffold(
      appBar: AppBar(title: Text('Riverpod Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('\$count', style: TextStyle(fontSize: 64)),
            SizedBox(height: 20),
            Text('Doubled: \$doubled', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: Icon(Icons.add),
      ),
    );
  }
}''',
            isRunnable: true,
          ),
        ],
      ),
    ];
  }
}