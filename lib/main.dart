import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:toln/toln.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/core/router.dart';
import 'package:app/core/theme/theme_cubit.dart';
import 'package:app/core/locale/locale_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('🚀 App starting...');

  // Get saved locale before initializing ToLn
  final prefs = await SharedPreferences.getInstance();
  final savedLocale = prefs.getString('app_locale');
  print('🌍 Saved locale from SharedPreferences: $savedLocale');

  // Initialize ToLn with English as base locale and saved locale as initial
  print(
    '🌍 Initializing ToLn with baseLocale: en, initialLocale: $savedLocale',
  );
  await ToLn.init(baseLocale: 'en', initialLocale: savedLocale);
  print('🌍 ToLn initialized successfully');
  print('🌍 ToLn.currentDirection: ${ToLn.currentDirection}');

  print('🔧 Setting up service locator...');
  await setupServiceLocator();
  print('🔧 Service locator ready');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
        BlocProvider(create: (context) => getIt<LocaleCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, localeState) {
              return ValueListenableBuilder(
                valueListenable: ToLn.localeNotifier,
                builder: (context, locale, child) {
                  print(
                    '🔄 ValueListenableBuilder triggered with locale: $locale',
                  );
                  return ToastificationWrapper(
                    child: MaterialApp.router(
                      key: ValueKey(locale.languageCode),
                      title: 'app_title'.toLn(),
                      theme: themeState.currentTheme.toThemeData(),
                      themeMode: ThemeMode.light,
                      routerConfig: router,
                      debugShowCheckedModeBanner: false,
                      locale: locale,
                      localizationsDelegates: const [
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      supportedLocales: const [
                        Locale('en'),
                        Locale('fa'),
                        Locale('ar'),
                        Locale('de'),
                      ],
                      builder: (context, child) {
                        return Directionality(
                          textDirection: ToLn.currentDirection,
                          child: child!,
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
