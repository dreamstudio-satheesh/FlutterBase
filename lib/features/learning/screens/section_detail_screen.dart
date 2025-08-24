import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/services/navigation_service.dart';
import '../providers/learning_content_provider.dart';
import '../../../shared/models/learning_section.dart';
import '../../../shared/models/learning_chapter.dart';

class SectionDetailScreen extends ConsumerWidget {
  const SectionDetailScreen({
    super.key,
    required this.sectionId,
  });

  final String sectionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final section = ref.watch(sectionProvider(sectionId));
    final chapters = ref.watch(sectionChaptersProvider(sectionId));

    if (section == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Section Not Found')),
        body: const Center(
          child: Text('The requested section could not be found.'),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Section Header
          _buildSliverAppBar(context, section),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Info
                  _buildSectionInfo(context, section),
                  
                  const SizedBox(height: AppConstants.marginLarge),
                  
                  // Chapters List
                  _buildChaptersList(context, chapters, section),
                  
                  const SizedBox(height: AppConstants.marginLarge),
                  
                  // Progress Section (placeholder)
                  _buildProgressSection(context, chapters),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, LearningSection section) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          section.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
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
                top: 80,
                child: Icon(
                  section.icon,
                  size: 100,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionInfo(BuildContext context, LearningSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About This Section',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.marginMedium),
        
        Text(
          section.description,
          style: context.textTheme.bodyLarge?.copyWith(
            height: 1.6,
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        
        const SizedBox(height: AppConstants.marginLarge),
        
        // Stats Row
        Row(
          children: [
            _buildStatItem(
              context,
              icon: Icons.menu_book_outlined,
              label: 'Chapters',
              value: section.chapters.length.toString(),
            ),
            const SizedBox(width: AppConstants.marginLarge),
            _buildStatItem(
              context,
              icon: Icons.schedule_outlined,
              label: 'Duration',
              value: '${section.estimatedTime} min',
            ),
            const SizedBox(width: AppConstants.marginLarge),
            _buildStatItem(
              context,
              icon: Icons.trending_up,
              label: 'Level',
              value: section.difficulty.displayName,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: AppConstants.iconSizeSmall,
              color: context.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: AppConstants.marginTiny),
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.marginTiny),
        Text(
          value,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildChaptersList(
    BuildContext context,
    List<LearningChapter> chapters,
    LearningSection section,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chapters',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppConstants.marginMedium),
        
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: chapters.length,
          separatorBuilder: (context, index) => const SizedBox(height: AppConstants.marginSmall),
          itemBuilder: (context, index) {
            final chapter = chapters[index];
            return _buildChapterCard(context, chapter, section, index + 1);
          },
        ),
      ],
    );
  }

  Widget _buildChapterCard(
    BuildContext context,
    LearningChapter chapter,
    LearningSection section,
    int order,
  ) {
    // Mock progress - in real app this would come from user progress provider
    final isCompleted = false;
    final isInProgress = order == 1; // First chapter is in progress
    final isLocked = order > 2; // Chapters after 2nd are locked

    return Card(
      elevation: AppConstants.elevationLow,
      child: InkWell(
        onTap: isLocked ? null : () {
          NavigationService.instance.goToChapter(section.id, chapter.id);
        },
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Row(
            children: [
              // Chapter Status Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getStatusColor(isCompleted, isInProgress, isLocked, section.color)
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                  border: Border.all(
                    color: _getStatusColor(isCompleted, isInProgress, isLocked, section.color)
                        .withOpacity(0.3),
                  ),
                ),
                child: Icon(
                  _getStatusIcon(isCompleted, isInProgress, isLocked),
                  color: _getStatusColor(isCompleted, isInProgress, isLocked, section.color),
                  size: AppConstants.iconSizeMedium,
                ),
              ),
              
              const SizedBox(width: AppConstants.marginMedium),
              
              // Chapter Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chapter $order',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppConstants.marginTiny),
                    Text(
                      chapter.title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isLocked 
                            ? context.colorScheme.onSurfaceVariant.withOpacity(0.6)
                            : context.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppConstants.marginTiny),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_outlined,
                          size: AppConstants.iconSizeSmall,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: AppConstants.marginTiny),
                        Text(
                          '${chapter.estimatedReadTime} min read',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Arrow or Lock Icon
              Icon(
                isLocked ? Icons.lock_outline : Icons.arrow_forward_ios,
                size: AppConstants.iconSizeSmall,
                color: context.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context, List<LearningChapter> chapters) {
    // Mock progress data
    final completedChapters = 0;
    final totalChapters = chapters.length;
    final progress = totalChapters > 0 ? completedChapters / totalChapters : 0.0;

    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Progress',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$completedChapters/$totalChapters chapters',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.marginMedium),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: context.colorScheme.surfaceVariant,
            valueColor: AlwaysStoppedAnimation(context.colorScheme.primary),
          ),
          const SizedBox(height: AppConstants.marginSmall),
          Text(
            progress > 0 
                ? 'Great progress! Keep learning to complete this section.'
                : 'Start your learning journey with the first chapter!',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(bool isCompleted, bool isInProgress, bool isLocked, Color sectionColor) {
    if (isCompleted) return Colors.green;
    if (isInProgress) return sectionColor;
    if (isLocked) return Colors.grey;
    return sectionColor.withOpacity(0.7);
  }

  IconData _getStatusIcon(bool isCompleted, bool isInProgress, bool isLocked) {
    if (isCompleted) return Icons.check_circle;
    if (isInProgress) return Icons.play_circle_outline;
    if (isLocked) return Icons.lock_outline;
    return Icons.radio_button_unchecked;
  }
}