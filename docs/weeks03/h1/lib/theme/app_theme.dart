import 'package:flutter/material.dart';

class AppTheme {
  // ColorScheme Berbasis Material 3
  static const ColorScheme darkColorScheme = ColorScheme.dark(
    primary: Color(0xFF3B82F6),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF1E3A8A),
    onPrimaryContainer: Color(0xFFDBEAFE),
    secondary: Color(0xFF60A5FA),
    onSecondary: Color(0xFF0F172A),
    surface: Color(0xFF0F172A),
    onSurface: Color(0xFFF8FAFC),
    surfaceContainerLow: Color(0xFF131C2E),
    surfaceContainer: Color(0xFF1E293B),
    surfaceContainerHigh: Color(0xFF182234),
    onSurfaceVariant: Color(0xFF94A3B8),
    outline: Color(0xFF334155),
    outlineVariant: Color(0xFF1E293B),
  );

  static ThemeData get material3DarkTheme {
    return ThemeData(
      // Mengaktifkan Fitur Material 3
      useMaterial3: true,
      colorScheme: darkColorScheme,
      scaffoldBackgroundColor: darkColorScheme.surface,

      // 1. M3 AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: darkColorScheme.surface,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: darkColorScheme.onSurface,
        ),
        iconTheme: IconThemeData(color: darkColorScheme.onSurface),
      ),

      // 2. M3 Card Theme
      cardTheme: CardThemeData(
        color: darkColorScheme.surfaceContainer,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: darkColorScheme.outline),
        ),
      ),

      // 3. M3 Search / InputDecoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkColorScheme.surfaceContainerLow,
        hintStyle: TextStyle(
          color: darkColorScheme.onSurfaceVariant,
          fontSize: 14,
        ),
        prefixIconColor: darkColorScheme.onSurfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkColorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkColorScheme.primary, width: 2),
        ),
      ),

      // 4. M3 Chips Theme
      chipTheme: ChipThemeData(
        backgroundColor: darkColorScheme.surfaceContainerHigh,
        selectedColor: darkColorScheme.primaryContainer,
        labelStyle: TextStyle(
          fontSize: 12,
          color: darkColorScheme.onSurfaceVariant,
        ),
        secondaryLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: darkColorScheme.onPrimaryContainer,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: darkColorScheme.outline),
        ),
        showCheckmark: false,
      ),

      // 5. M3 Buttons Theme (Filled, Outlined, Text)
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: darkColorScheme.primary,
          foregroundColor: darkColorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),

      // 6. M3 Navigation Bar Theme (Pengganti BottomNavigationBar)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: darkColorScheme.surfaceContainer,
        indicatorColor: darkColorScheme.primaryContainer,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: darkColorScheme.onPrimaryContainer);
          }
          return IconThemeData(color: darkColorScheme.onSurfaceVariant);
        }),
      ),

      // 7. M3 FloatingActionButton (FAB)
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkColorScheme.primaryContainer,
        foregroundColor: darkColorScheme.onPrimaryContainer,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // 8. M3 Dialog / Modal Theme
      dialogTheme: DialogThemeData(
        backgroundColor: darkColorScheme.surfaceContainer,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),

      // 9. M3 SegmentedButton Theme
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return darkColorScheme.primaryContainer;
            }
            return darkColorScheme.surfaceContainerHigh;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return darkColorScheme.onPrimaryContainer;
            }
            return darkColorScheme.onSurfaceVariant;
          }),
        ),
      ),

      // 10. M3 Type Scale (Tipografi Terpadu)
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: darkColorScheme.onSurface,
          letterSpacing: -0.5,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: darkColorScheme.onSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          color: darkColorScheme.onSurface,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: darkColorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}