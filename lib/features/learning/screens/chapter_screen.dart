import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/helpers.dart';
import '../providers/learning_content_provider.dart';
import '../../../shared/models/learning_chapter.dart';
import '../../../shared/models/learning_section.dart';

class ChapterScreen extends ConsumerStatefulWidget {
  const ChapterScreen({
    super.key,
    required this.sectionId,
    required this.chapterId,
  });

  final String sectionId;
  final String chapterId;

  @override
  ConsumerState<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends ConsumerState<ChapterScreen> 
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fabAnimationController;
  bool _showFab = false;
  int _selectedCodeExample = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: AppConstants.animationDurationMedium,
    );
    
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 200 && !_showFab) {
      setState(() => _showFab = true);
      _fabAnimationController.forward();
    } else if (_scrollController.offset <= 200 && _showFab) {
      setState(() => _showFab = false);
      _fabAnimationController.reverse();
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: AppConstants.animationDurationSlow,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chapter = ref.watch(chapterProvider((
      sectionId: widget.sectionId,
      chapterId: widget.chapterId,
    )));
    final section = ref.watch(sectionProvider(widget.sectionId));

    if (chapter == null || section == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Chapter Not Found')),
        body: const Center(
          child: Text('The requested chapter could not be found.'),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App Bar
          _buildSliverAppBar(chapter, section),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Chapter Info
                  _buildChapterInfo(chapter),
                  
                  const SizedBox(height: AppConstants.marginLarge),
                  
                  // Main Content
                  _buildMainContent(chapter),
                  
                  const SizedBox(height: AppConstants.marginLarge),
                  
                  // Code Examples
                  if (chapter.codeExamples.isNotEmpty)
                    _buildCodeExamples(chapter.codeExamples),
                  
                  const SizedBox(height: AppConstants.marginLarge),
                  
                  // Learning Objectives
                  if (chapter.learningObjectives.isNotEmpty)
                    _buildLearningObjectives(chapter.learningObjectives),
                  
                  const SizedBox(height: AppConstants.marginLarge),
                  
                  // Navigation Footer
                  _buildNavigationFooter(chapter, section),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _showFab
          ? ScaleTransition(
              scale: _fabAnimationController,
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                child: const Icon(Icons.keyboard_arrow_up),
              ),
            )
          : null,
    );
  }

  Widget _buildSliverAppBar(LearningChapter chapter, LearningSection section) {
    return SliverAppBar(
      expandedHeight: 160,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          chapter.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                section.color.withOpacity(0.8),
                section.color.withOpacity(0.6),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 20,
                top: 60,
                child: Icon(
                  section.icon,
                  size: 80,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _showBookmarkDialog(),
          icon: const Icon(Icons.bookmark_outline),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'share':
                _shareChapter(chapter);
                break;
              case 'report':
                _reportIssue(chapter);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(Icons.share),
                  SizedBox(width: 8),
                  Text('Share Chapter'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'report',
              child: Row(
                children: [
                  Icon(Icons.report_outline),
                  SizedBox(width: 8),
                  Text('Report Issue'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChapterInfo(LearningChapter chapter) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      ),
      child: Row(
        children: [
          Icon(
            Icons.schedule_outlined,
            size: AppConstants.iconSizeMedium,
            color: context.colorScheme.primary,
          ),
          const SizedBox(width: AppConstants.marginSmall),
          Text(
            '${chapter.estimatedReadTime} min read',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          
          const SizedBox(width: AppConstants.marginLarge),
          
          if (chapter.prerequisites.isNotEmpty) ...[
            Icon(
              Icons.checklist_outlined,
              size: AppConstants.iconSizeMedium,
              color: context.colorScheme.primary,
            ),
            const SizedBox(width: AppConstants.marginSmall),
            Text(
              '${chapter.prerequisites.length} prerequisite${chapter.prerequisites.length == 1 ? '' : 's'}',
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMainContent(LearningChapter chapter) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: _buildMarkdownContent(chapter.content),
    );
  }

  Widget _buildMarkdownContent(String content) {
    // Simple markdown-like rendering
    final lines = content.split('\n');
    final widgets = <Widget>[];
    
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      
      if (line.startsWith('# ')) {
        widgets.add(_buildHeading(line.substring(2), 1));
      } else if (line.startsWith('## ')) {
        widgets.add(_buildHeading(line.substring(3), 2));
      } else if (line.startsWith('### ')) {
        widgets.add(_buildHeading(line.substring(4), 3));
      } else if (line.startsWith('```dart')) {
        // Handle code blocks
        final codeLines = <String>[];
        i++; // Skip the opening ```
        while (i < lines.length && !lines[i].startsWith('```')) {
          codeLines.add(lines[i]);
          i++;
        }
        widgets.add(_buildCodeBlock(codeLines.join('\n')));
      } else if (line.startsWith('- ') || line.startsWith('* ')) {
        widgets.add(_buildListItem(line.substring(2)));
      } else if (line.trim().isNotEmpty) {
        widgets.add(_buildParagraph(line));
      } else {
        widgets.add(const SizedBox(height: AppConstants.marginSmall));
      }
      
      if (i < lines.length - 1) {
        widgets.add(const SizedBox(height: AppConstants.marginSmall));
      }
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  Widget _buildHeading(String text, int level) {
    final style = switch (level) {
      1 => context.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.colorScheme.primary,
        ),
      2 => context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      _ => context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
    };
    
    return Padding(
      padding: EdgeInsets.only(
        top: level == 1 ? 0 : AppConstants.marginMedium,
        bottom: AppConstants.marginSmall,
      ),
      child: Text(text, style: style),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: context.textTheme.bodyMedium?.copyWith(
        height: 1.6,
        color: context.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: AppConstants.marginMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8, right: 8),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeBlock(String code) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.marginMedium),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: IconButton(
              onPressed: () => _copyToClipboard(code),
              icon: const Icon(Icons.copy, size: 16),
              tooltip: 'Copy code',
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: HighlightView(
              code,
              language: 'dart',
              theme: githubTheme,
              textStyle: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeExamples(List<CodeExample> examples) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interactive Examples',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.marginMedium),
        
        // Tab Bar for examples
        if (examples.length > 1)
          Container(
            margin: const EdgeInsets.only(bottom: AppConstants.marginMedium),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: examples.asMap().entries.map((entry) {
                  final index = entry.key;
                  final example = entry.value;
                  final isSelected = index == _selectedCodeExample;
                  
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCodeExample = index),
                    child: Container(
                      margin: const EdgeInsets.only(right: AppConstants.marginSmall),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingMedium,
                        vertical: AppConstants.paddingSmall,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? context.colorScheme.primary 
                            : context.colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                      ),
                      child: Text(
                        example.title,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: isSelected 
                              ? context.colorScheme.onPrimary 
                              : context.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        
        // Selected example
        _buildCodeExampleCard(examples[_selectedCodeExample]),
      ],
    );
  }

  Widget _buildCodeExampleCard(CodeExample example) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              example.title,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppConstants.marginSmall),
            Text(
              example.explanation,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppConstants.marginMedium),
            _buildCodeBlock(example.code),
            if (example.isRunnable)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () => _runExample(example),
                  icon: const Icon(Icons.play_arrow, size: 16),
                  label: const Text('Run Example'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingMedium,
                      vertical: AppConstants.paddingSmall,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningObjectives(List<String> objectives) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events_outlined,
                color: context.colorScheme.primary,
                size: AppConstants.iconSizeMedium,
              ),
              const SizedBox(width: AppConstants.marginSmall),
              Text(
                'Learning Objectives',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.marginMedium),
          ...objectives.map((objective) => Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.marginSmall),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: AppConstants.iconSizeSmall,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(width: AppConstants.marginSmall),
                Expanded(
                  child: Text(
                    objective,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildNavigationFooter(LearningChapter chapter, LearningSection section) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Section'),
            ),
          ),
          const SizedBox(width: AppConstants.marginMedium),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _markAsCompleted(chapter),
              icon: const Icon(Icons.check),
              label: const Text('Mark Complete'),
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(String code) {
    Clipboard.setData(ClipboardData(text: code));
    context.showSuccessSnackBar('Code copied to clipboard!');
  }

  void _runExample(CodeExample example) {
    // Mock running example - in real app this would open a code playground
    context.showSnackBar('Running ${example.title}... (Demo)');
  }

  void _shareChapter(LearningChapter chapter) {
    // Mock sharing - in real app this would use proper sharing
    context.showSnackBar('Sharing ${chapter.title}... (Demo)');
  }

  void _reportIssue(LearningChapter chapter) {
    // Mock reporting - in real app this would open feedback form
    context.showSnackBar('Report issue for ${chapter.title}... (Demo)');
  }

  void _showBookmarkDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bookmark Chapter'),
        content: const Text('This chapter will be added to your bookmarks for quick access.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.showSuccessSnackBar('Chapter bookmarked!');
            },
            child: const Text('Bookmark'),
          ),
        ],
      ),
    );
  }

  void _markAsCompleted(LearningChapter chapter) {
    // Mock completion - in real app this would update user progress
    context.showSuccessSnackBar('${chapter.title} marked as completed!');
    Navigator.of(context).pop();
  }
}