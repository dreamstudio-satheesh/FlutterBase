import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/extensions.dart';
import '../../../core/utils/validators.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    context.unfocus();

    try {
      // Simulate network request
      await Future.delayed(const Duration(milliseconds: 800));

      final username = _usernameController.text.trim();
      final password = _passwordController.text;

      if (username == 'admin' && password == '1234') {
        if (mounted) {
          context.showSuccessSnackBar('Login successful!');
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        if (mounted) {
          context.showErrorSnackBar(AppStrings.invalidCredentials);
        }
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar('Login failed. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppConstants.marginExtraLarge * 2),
                
                // Header Section
                _buildHeader(),
                
                const SizedBox(height: AppConstants.marginExtraLarge),
                
                // Login Form
                _buildLoginForm(),
                
                const SizedBox(height: AppConstants.marginLarge),
                
                // Login Button
                _buildLoginButton(),
                
                const SizedBox(height: AppConstants.marginMedium),
                
                // Demo Credentials
                _buildDemoCredentials(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          decoration: BoxDecoration(
            color: context.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
          ),
          child: Icon(
            Icons.login_rounded,
            size: AppConstants.iconSizeExtraLarge * 1.5,
            color: context.colorScheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: AppConstants.marginLarge),
        Text(
          AppStrings.welcomeBack,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppConstants.marginSmall),
        Text(
          AppStrings.pleaseLogin,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        CustomTextField(
          controller: _usernameController,
          label: AppStrings.username,
          prefixIcon: Icons.person_outline,
          validator: AppValidators.validateUsername,
          textInputAction: TextInputAction.next,
          enabled: !_isLoading,
        ),
        const SizedBox(height: AppConstants.marginMedium),
        CustomTextField(
          controller: _passwordController,
          label: AppStrings.password,
          prefixIcon: Icons.lock_outline,
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          validator: AppValidators.validatePassword,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _handleLogin(),
          enabled: !_isLoading,
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return CustomButton(
      onPressed: _isLoading ? null : _handleLogin,
      isLoading: _isLoading,
      child: Text(
        AppStrings.loginButton,
        style: const TextStyle(
          fontSize: AppConstants.textSizeBody,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDemoCredentials() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        border: Border.all(
          color: context.colorScheme.outline.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Demo Credentials',
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppConstants.marginSmall),
          Text(
            'Username: admin\nPassword: 1234',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              fontFamily: 'monospace',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}