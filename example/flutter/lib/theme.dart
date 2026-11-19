import 'package:flutter/material.dart';

abstract final class Space {
  static const tight = 4.0;
  static const small = 8.0;
  static const medium = 12.0;
  static const page = 16.0;
  static const section = 24.0;
  static const touch = 48.0;
  static const appBar = 72.0;
  static const radius = 16.0;
  static const cellRadius = 12.0;
  static const contentWidth = 640.0;
  static const railBreakpoint = 700.0;
  static const calendarMinWidth = 336.0;
}

@immutable
class DayColors extends ThemeExtension<DayColors> {
  const DayColors({
    required this.working,
    required this.workingSurface,
    required this.holiday,
    required this.holidaySurface,
  });
  final Color working;
  final Color workingSurface;
  final Color holiday;
  final Color holidaySurface;
  @override
  DayColors copyWith({
    Color? working,
    Color? workingSurface,
    Color? holiday,
    Color? holidaySurface,
  }) => DayColors(
    working: working ?? this.working,
    workingSurface: workingSurface ?? this.workingSurface,
    holiday: holiday ?? this.holiday,
    holidaySurface: holidaySurface ?? this.holidaySurface,
  );
  @override
  DayColors lerp(DayColors? other, double t) {
    if (other == null) return this;
    return DayColors(
      working: Color.lerp(working, other.working, t)!,
      workingSurface: Color.lerp(workingSurface, other.workingSurface, t)!,
      holiday: Color.lerp(holiday, other.holiday, t)!,
      holidaySurface: Color.lerp(holidaySurface, other.holidaySurface, t)!,
    );
  }
}

ThemeData appTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xff503268),
    primary: dark ? const Color(0xffd9b8f2) : const Color(0xff503268),
    brightness: brightness,
    surface: dark ? const Color(0xff17121e) : const Color(0xfffcfaff),
  );
  final base = ThemeData(useMaterial3: true, colorScheme: scheme);
  return base.copyWith(
    scaffoldBackgroundColor: dark
        ? scheme.surfaceContainerLow
        : const Color(0xfff2edf8),
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
      toolbarHeight: Space.appBar,
      titleTextStyle: base.textTheme.titleLarge?.copyWith(
        color: scheme.onPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: base.textTheme.copyWith(
      bodyLarge: base.textTheme.bodyLarge?.copyWith(height: 1.45),
      bodyMedium: base.textTheme.bodyMedium?.copyWith(height: 1.45),
      titleLarge: base.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: base.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(Space.touch, Space.touch),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Space.cellRadius),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(Space.touch, Space.touch),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Space.cellRadius),
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        minimumSize: const Size(Space.touch, Space.touch),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.all(Space.page),
    ),
    extensions: [
      dark
          ? const DayColors(
              working: Color(0xff8ed6af),
              workingSurface: Color(0xff153c2a),
              holiday: Color(0xffefc16a),
              holidaySurface: Color(0xff493414),
            )
          : const DayColors(
              working: Color(0xff17623f),
              workingSurface: Color(0xffdff0e5),
              holiday: Color(0xff855400),
              holidaySurface: Color(0xffffefd2),
            ),
    ],
  );
}
