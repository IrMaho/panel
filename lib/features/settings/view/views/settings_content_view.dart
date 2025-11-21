import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:toln/toln.dart';
import 'package:app/core/theme/theme_cubit.dart';
import 'package:app/core/theme/app_themes.dart';
import 'package:app/core/locale/locale_cubit.dart';
import 'package:app/features/settings/bloc/settings_cubit.dart';

class SettingsContentView extends StatelessWidget {
  const SettingsContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    'Settings',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn().slideX(begin: -0.2),
                  const SizedBox(height: 8),
                  Text(
                    'Customize your dashboard experience',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                  ).animate(delay: 100.ms).fadeIn(),
                  const SizedBox(height: 32),

                  // Theme Section
                  Text(
                    'Theme Selection',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate(delay: 200.ms).fadeIn(),
                  const SizedBox(height: 16),

                  // Current Theme Indicator
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: themeState.currentTheme.primaryColor.withValues(
                        alpha: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: themeState.currentTheme.primaryColor,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.palette,
                          color: themeState.currentTheme.primaryColor,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Current Theme: ${themeState.themeName}',
                          style: TextStyle(
                            color: themeState.currentTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ).animate(delay: 250.ms).fadeIn().scale(),
                  const SizedBox(height: 24),

                  // Theme Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: 1.5,
                        ),
                    itemCount: AppThemes.allThemes.length,
                    itemBuilder: (context, index) {
                      final theme = AppThemes.allThemes[index];
                      final isSelected = themeState.themeName == theme.name;

                      return _ThemeCard(
                        theme: theme,
                        isSelected: isSelected,
                        onTap: () {
                          context.read<ThemeCubit>().changeTheme(theme);
                        },
                      ).animate(delay: (300 + index * 50).ms).fadeIn().scale();
                    },
                  ),
                  const SizedBox(height: 48),

                  // Language Selection Section
                  Text(
                    'language_selection'.toLn(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate(delay: 600.ms).fadeIn(),
                  const SizedBox(height: 16),

                  // Current Language Indicator
                  BlocBuilder<LocaleCubit, LocaleState>(
                    builder: (context, localeState) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: themeState.currentTheme.primaryColor
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: themeState.currentTheme.primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.language,
                              color: themeState.currentTheme.primaryColor,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'current_language'.toLn(),
                              style: TextStyle(
                                color: themeState.currentTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ).animate(delay: 650.ms).fadeIn().scale();
                    },
                  ),
                  const SizedBox(height: 24),

                  // Language Grid
                  BlocBuilder<LocaleCubit, LocaleState>(
                    builder: (context, localeState) {
                      return FutureBuilder<List<LocaleInfo>>(
                        future: ToLn.getAvailableLocales(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final locales = snapshot.data!;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 24,
                                  mainAxisSpacing: 24,
                                  childAspectRatio: 1.8,
                                ),
                            itemCount: locales.length,
                            itemBuilder: (context, index) {
                              final locale = locales[index];
                              final isSelected =
                                  localeState.locale == locale.code;

                              return _LanguageCard(
                                    code: locale.code,
                                    name: locale.name,
                                    isSelected: isSelected,
                                    onTap: () {
                                      context.read<LocaleCubit>().changeLocale(
                                        locale.code,
                                      );
                                    },
                                  )
                                  .animate(delay: (700 + index * 50).ms)
                                  .fadeIn()
                                  .scale();
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _ThemeCard extends StatefulWidget {
  final AppThemeData theme;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeCard({
    required this.theme,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_ThemeCard> createState() => _ThemeCardState();
}

class _ThemeCardState extends State<_ThemeCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..setTranslationRaw(0.0, _isHovered ? -8.0 : 0.0, 0.0),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.isSelected
                    ? widget.theme.primaryColor
                    : Colors.grey[300]!,
                width: widget.isSelected ? 3 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.theme.primaryColor.withValues(
                    alpha: widget.isSelected ? 0.3 : (_isHovered ? 0.15 : 0.08),
                  ),
                  blurRadius: _isHovered ? 20 : 12,
                  offset: Offset(0, _isHovered ? 8 : 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Color Preview
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: widget.theme.primaryGradient,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(14),
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 48,
                            )
                          else
                            Icon(
                              Icons.palette,
                              color: Colors.white.withValues(alpha: 0.8),
                              size: 36,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Theme Name
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: widget.theme.surfaceColor,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(14),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.theme.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.theme.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        // Color Dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _ColorDot(color: widget.theme.primaryColor),
                            _ColorDot(color: widget.theme.accentColor),
                            _ColorDot(color: widget.theme.successColor),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;

  const _ColorDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}

class _LanguageCard extends StatefulWidget {
  final String code;
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.code,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_LanguageCard> createState() => _LanguageCardState();
}

class _LanguageCardState extends State<_LanguageCard> {
  bool _isHovered = false;

  IconData _getFlagIcon(String code) {
    switch (code) {
      case 'en':
        return Icons.language;
      case 'fa':
        return Icons.translate;
      case 'ar':
        return Icons.translate_outlined;
      case 'de':
        return Icons.public;
      default:
        return Icons.language;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..setTranslationRaw(0.0, _isHovered ? -8.0 : 0.0, 0.0),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300]!,
                width: widget.isSelected ? 3 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.isSelected
                      ? Theme.of(context).primaryColor.withValues(alpha: 0.3)
                      : Colors.black.withValues(
                          alpha: _isHovered ? 0.15 : 0.08,
                        ),
                  blurRadius: _isHovered ? 20 : 12,
                  offset: Offset(0, _isHovered ? 8 : 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getFlagIcon(widget.code),
                  size: 32,
                  color: widget.isSelected
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 12),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: widget.isSelected ? Colors.white : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.code.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: widget.isSelected
                        ? Colors.white.withValues(alpha: 0.9)
                        : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
