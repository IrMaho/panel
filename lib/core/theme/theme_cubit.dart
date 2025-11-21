import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/theme/app_themes.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs)
    : super(
        ThemeState(
          currentTheme: AppThemes.oceanBlue,
          themeName: _prefs.getString('theme_name') ?? 'Ocean Blue',
        ),
      ) {
    _loadTheme();
  }

  void _loadTheme() {
    final themeName = _prefs.getString('theme_name') ?? 'Ocean Blue';
    final theme = AppThemes.getThemeByName(themeName);
    emit(state.copyWith(currentTheme: theme, themeName: themeName));
  }

  Future<void> changeTheme(AppThemeData theme) async {
    await _prefs.setString('theme_name', theme.name);
    emit(state.copyWith(currentTheme: theme, themeName: theme.name));
  }

  Future<void> setCustomTheme(AppThemeData theme) async {
    // Save custom theme parameters
    await _prefs.setString('theme_name', theme.name);
    emit(state.copyWith(currentTheme: theme, themeName: theme.name));
  }
}
