import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/helpers.dart';
import '../../../core/services/navigation_service.dart';
import '../../../shared/widgets/custom_button.dart';
import '../providers/learning_content_provider.dart';
import '../../../shared/models/learning_section.dart';

class SectionsScreen extends ConsumerWidget {
  const SectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = ref.watch(learningSectionsProvider);
    final totalTime = ref.watch(totalEstimatedTimeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Sections'),
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeaderSection(context, totalTime),
            
            const SizedBox(height: AppConstants.marginLarge),
            
            // Sections List
            _buildSectionsList(context, sections),
            
            const SizedBox(height: AppConstants.marginLarge),
            
            // Learning Path Info
            _buildLearningPathInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, int totalTime) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colorScheme.primaryContainer,
            context.colorScheme.primaryContainer.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flutter Mastery Path',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: AppConstants.marginSmall),
          Text(
            'Complete interactive learning experience designed to take you from beginner to Flutter expert',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onPrimaryContainer.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: AppConstants.marginMedium),
          Row(
            children: [
              Icon(
                Icons.schedule_outlined,
                color: context.colorScheme.onPrimaryContainer,
                size: AppConstants.iconSizeMedium,
              ),
              const SizedBox(width: AppConstants.marginSmall),
              Text(
                '${totalTime ~/ 60}h ${totalTime % 60}m total learning time',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionsList(BuildContext context, List<LearningSection> sections) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Learning Sections',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppConstants.marginMedium),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sections.length,
          separatorBuilder: (context, index) => const SizedBox(height: AppConstants.marginMedium),
          itemBuilder: (context, index) {
            final section = sections[index];
            return _buildSectionCard(context, section, index + 1);
          },
        ),
      ],
    );
  }

  Widget _buildSectionCard(BuildContext context, LearningSection section, int order) {
    return Card(
      elevation: AppConstants.elevationLow,
      child: InkWell(
        onTap: () => NavigationService.instance.goToSection(section.id),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  // Order Number
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: section.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                    ),
                    child: Center(
                      child: Text(
                        order.toString(),
                        style: context.textTheme.titleMedium?.copyWith(
                          color: section.color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.marginMedium),
                  
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(AppConstants.paddingSmall),
                    decoration: BoxDecoration(
                      color: section.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                    ),
                    child: Icon(
                      section.icon,
                      color: section.color,
                      size: AppConstants.iconSizeLarge,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Difficulty Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.paddingSmall,
                      vertical: AppConstants.paddingTiny,
                    ),
                    decoration: BoxDecoration(
                      color: section.difficulty.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                      border: Border.all(
                        color: section.difficulty.color.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      section.difficulty.displayName,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: section.difficulty.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppConstants.marginMedium),
              
              // Title and Description
              Text(
                section.title,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: AppConstants.marginSmall),
              Text(
                section.description,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              
              const SizedBox(height: AppConstants.marginMedium),
              
              // Footer Info
              Row(
                children: [
                  Icon(
                    Icons.menu_book_outlined,
                    size: AppConstants.iconSizeSmall,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppConstants.marginTiny),
                  Text(
                    '${section.chapters.length} chapters',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  
                  const SizedBox(width: AppConstants.marginMedium),
                  
                  Icon(
                    Icons.schedule_outlined,
                    size: AppConstants.iconSizeSmall,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppConstants.marginTiny),
                  Text(
                    '${section.estimatedTime} min',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  
                  const Spacer(),
                  
                  Icon(
                    Icons.arrow_forward_ios,
                    size: AppConstants.iconSizeSmall,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLearningPathInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingLarge),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: context.colorScheme.primary,
                size: AppConstants.iconSizeMedium,
              ),
              const SizedBox(width: AppConstants.marginSmall),
              Text(
                'Learning Tips',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.marginMedium),
          
          ...[
            '📚 Start with Flutter Basics if you\'re new to Flutter',
            '🔄 Progress through sections in order for the best experience',
            '💻 Practice with the interactive code examples',
            '⏱️ Take breaks every 30 minutes to retain information better',
            '🎯 Complete all exercises to reinforce your learning',
          ].map((tip) => Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.marginSmall),
            child: Text(
              tip,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
          )).toList(),
        ],
      ),
    );
  }
}