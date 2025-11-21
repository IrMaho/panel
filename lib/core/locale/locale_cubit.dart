import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toln/toln.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final SharedPreferences _prefs;

  LocaleCubit(this._prefs) : super(const LocaleState(locale: 'en')) {
    print('🌍 LocaleCubit initialized');
    _loadLocale();
  }

  void _loadLocale() async {
    final savedLocale = _prefs.getString('app_locale') ?? 'en';
    print('🌍 Loading saved locale: $savedLocale');

    // Load the locale in ToLn
    if (savedLocale != 'en') {
      print('🌍 Loading non-default locale in ToLn: $savedLocale');
      await ToLn.loadLocale(savedLocale);
    }

    emit(LocaleState(locale: savedLocale));
  }

  Future<void> changeLocale(String newLocale) async {
    print('🌍 Changing locale to: $newLocale');
    try {
      await ToLn.loadLocale(newLocale);
      print('🌍 ToLn.loadLocale completed for: $newLocale');
      print('🌍 ToLn.currentDirection: ${ToLn.currentDirection}');

      await _prefs.setString('app_locale', newLocale);
      print('🌍 Saved locale to SharedPreferences: $newLocale');

      emit(LocaleState(locale: newLocale));
      print('🌍 Emitted new state with locale: $newLocale');

      // Test translation
      final testKey = 'dashboard';
      final translated = testKey.toLn();
      print('🌍 Test translation "$testKey" -> "$translated"');
    } catch (e) {
      print('❌ Error changing locale: $e');
    }
  }
}
