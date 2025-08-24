import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/extensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.large,
    this.fullWidth = true,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    Widget button;

    switch (variant) {
      case ButtonVariant.primary:
        button = _buildElevatedButton(context);
        break;
      case ButtonVariant.secondary:
        button = _buildOutlinedButton(context);
        break;
      case ButtonVariant.text:
        button = _buildTextButton(context);
        break;
    }

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }

    return button;
  }

  Widget _buildElevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
        disabledBackgroundColor: context.colorScheme.surfaceVariant,
        disabledForegroundColor: context.colorScheme.onSurfaceVariant,
        elevation: AppConstants.elevationLow,
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        ),
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildOutlinedButton(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: context.colorScheme.primary,
        disabledForegroundColor: context.colorScheme.onSurfaceVariant,
        side: BorderSide(
          color: isLoading 
              ? context.colorScheme.outline.withOpacity(0.3)
              : context.colorScheme.primary,
        ),
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        ),
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildTextButton(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: context.colorScheme.primary,
        disabledForegroundColor: context.colorScheme.onSurfaceVariant,
        padding: _getPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        ),
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: _getIconSize(),
            height: _getIconSize(),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == ButtonVariant.primary
                    ? context.colorScheme.onPrimary
                    : context.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: AppConstants.paddingSmall),
          const Text('Loading...'),
        ],
      );
    }

    return child;
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingSmall,
        );
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingLarge,
          vertical: AppConstants.paddingSmall,
        );
      case ButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingLarge,
          vertical: AppConstants.paddingMedium,
        );
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return AppConstants.iconSizeSmall;
      case ButtonSize.medium:
        return AppConstants.iconSizeMedium;
      case ButtonSize.large:
        return AppConstants.iconSizeMedium;
    }
  }
}

enum ButtonVariant {
  primary,
  secondary,
  text,
}

enum ButtonSize {
  small,
  medium,
  large,
}