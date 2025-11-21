part of 'theme_cubit.dart';

class ThemeState {
  final AppThemeData currentTheme;
  final String themeName;

  const ThemeState({required this.currentTheme, required this.themeName});

  ThemeState copyWith({AppThemeData? currentTheme, String? themeName}) {
    return ThemeState(
      currentTheme: currentTheme ?? this.currentTheme,
      themeName: themeName ?? this.themeName,
    );
  }
}
