import 'package:flutter/material.dart';

import 'home.dart';
import 'l10n/app_localizations.dart';
import 'theme.dart';

void main() {
  runApp(const HolidaysDemo());
}

class HolidaysDemo extends StatefulWidget {
  const HolidaysDemo({super.key});
  @override
  State<HolidaysDemo> createState() => _HolidaysDemoState();
}

class _HolidaysDemoState extends State<HolidaysDemo> {
  Locale _locale = const Locale('en');
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: appTheme(Brightness.light),
      darkTheme: appTheme(Brightness.dark),
      themeMode: _themeMode,
      home: HolidayHome(
        onLanguage: () => setState(() {
          _locale = Locale(_locale.languageCode == 'en' ? 'bn' : 'en');
        }),
        themeMode: _themeMode,
        onTheme: (mode) => setState(() => _themeMode = mode),
      ),
    );
  }
}
