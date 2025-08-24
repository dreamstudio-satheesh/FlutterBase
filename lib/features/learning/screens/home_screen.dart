import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/extensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.home,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Navigate to profile
            },
            icon: Icon(
              Icons.account_circle_outlined,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            _buildWelcomeSection(context),
            
            const SizedBox(height: AppConstants.marginLarge),
            
            // Learning Sections Preview
            _buildLearningSectionsPreview(context),
            
            const SizedBox(height: AppConstants.marginLarge),
            
            // Recent Progress
            _buildRecentProgress(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
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
            '${AppStrings.welcome} to ${AppConstants.appName}!',
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: AppConstants.marginSmall),
          Text(
            'Continue your Flutter learning journey with interactive lessons and hands-on coding.',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onPrimaryContainer.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningSectionsPreview(BuildContext context) {
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
        _buildSectionCard(
          context,
          title: AppStrings.flutterBasics,
          description: 'Learn the fundamentals of Flutter development',
          icon: Icons.flutter_dash,
          color: AppConstants.flutterBasicsColor,
          progress: 0.0,
        ),
        _buildSectionCard(
          context,
          title: AppStrings.stateManagement,
          description: 'Master state management patterns',
          icon: Icons.settings_suggest_outlined,
          color: AppConstants.stateManagementColor,
          progress: 0.0,
        ),
        _buildSectionCard(
          context,
          title: AppStrings.performanceOptimization,
          description: 'Optimize your Flutter apps for production',
          icon: Icons.speed_outlined,
          color: AppConstants.performanceColor,
          progress: 0.0,
        ),
      ],
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required double progress,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.marginMedium),
      child: Card(
        child: InkWell(
          onTap: () {
            context.showSnackBar('$title section coming soon!');
          },
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.paddingMedium),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppConstants.paddingSmall),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: AppConstants.iconSizeLarge,
                  ),
                ),
                const SizedBox(width: AppConstants.marginMedium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppConstants.marginTiny),
                      Text(
                        description,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppConstants.marginSmall),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: context.colorScheme.surfaceVariant,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: AppConstants.iconSizeSmall,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentProgress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Progress',
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppConstants.marginMedium),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
            border: Border.all(
              color: context.colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.timeline_outlined,
                size: AppConstants.iconSizeExtraLarge,
                color: context.colorScheme.onSurfaceVariant.withOpacity(0.7),
              ),
              const SizedBox(height: AppConstants.marginMedium),
              Text(
                'No progress yet',
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppConstants.marginSmall),
              Text(
                'Start your learning journey by selecting a section above!',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurfaceVariant.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}