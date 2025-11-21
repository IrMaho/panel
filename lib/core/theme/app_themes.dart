import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  final String name;
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color surfaceColor;
  final Color successColor;
  final Color warningColor;
  final Color errorColor;

  const AppThemeData({
    required this.name,
    required this.primaryColor,
    required this.accentColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.successColor,
    required this.warningColor,
    required this.errorColor,
  });

  // Gradients
  LinearGradient get primaryGradient => LinearGradient(
    colors: [primaryColor, primaryColor.withOpacity(0.7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  LinearGradient get accentGradient => LinearGradient(
    colors: [accentColor, accentColor.withOpacity(0.7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Convert to ThemeData
  ThemeData toThemeData() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: GoogleFonts.poppinsTextTheme(),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class AppThemes {
  // 1. Ocean Blue (Default)
  static const oceanBlue = AppThemeData(
    name: 'Ocean Blue',
    primaryColor: Color(0xFF1A237E),
    accentColor: Color(0xFF00BCD4),
    backgroundColor: Color(0xFFF5F7FA),
    surfaceColor: Color(0xFFFFFFFF),
    successColor: Color(0xFF4CAF50),
    warningColor: Color(0xFFFFC107),
    errorColor: Color(0xFFF44336),
  );

  // 2. Forest Green
  static const forestGreen = AppThemeData(
    name: 'Forest Green',
    primaryColor: Color(0xFF1B5E20),
    accentColor: Color(0xFF4CAF50),
    backgroundColor: Color(0xFFF1F8F4),
    surfaceColor: Color(0xFFFFFFFF),
    successColor: Color(0xFF66BB6A),
    warningColor: Color(0xFFFFB74D),
    errorColor: Color(0xFFE57373),
  );

  // 3. Sunset Orange
  static const sunsetOrange = AppThemeData(
    name: 'Sunset Orange',
    primaryColor: Color(0xFFE65100),
    accentColor: Color(0xFFFF9800),
    backgroundColor: Color(0xFFFFF3E0),
    surfaceColor: Color(0xFFFFFFFF),
    successColor: Color(0xFF66BB6A),
    warningColor: Color(0xFFFFCA28),
    errorColor: Color(0xFFEF5350),
  );

  // 4. Royal Purple
  static const royalPurple = AppThemeData(
    name: 'Royal Purple',
    primaryColor: Color(0xFF4A148C),
    accentColor: Color(0xFF9C27B0),
    backgroundColor: Color(0xFFF3E5F5),
    surfaceColor: Color(0xFFFFFFFF),
    successColor: Color(0xFF66BB6A),
    warningColor: Color(0xFFFFB74D),
    errorColor: Color(0xFFEF5350),
  );

  // 5. Midnight Dark
  static const midnightDark = AppThemeData(
    name: 'Midnight Dark',
    primaryColor: Color(0xFF0D47A1),
    accentColor: Color(0xFF42A5F5),
    backgroundColor: Color(0xFF121212),
    surfaceColor: Color(0xFF1E1E1E),
    successColor: Color(0xFF4CAF50),
    warningColor: Color(0xFFFF9800),
    errorColor: Color(0xFFF44336),
  );

  static final List<AppThemeData> allThemes = [
    oceanBlue,
    forestGreen,
    sunsetOrange,
    royalPurple,
    midnightDark,
  ];

  static AppThemeData getThemeByName(String name) {
    return allThemes.firstWhere(
      (theme) => theme.name == name,
      orElse: () => oceanBlue,
    );
  }
}
