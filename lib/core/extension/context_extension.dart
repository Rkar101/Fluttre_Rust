import 'package:flutter/material.dart';

extension CustomContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  Color? get backgroundColor => theme.appBarTheme.backgroundColor;

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  Color get shadowColor => Theme.of(this).shadowColor;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  Color get primaryColor => Theme.of(this).primaryColor;

  Color get primaryColorDark => Theme.of(this).primaryColorDark;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get onSurface => Theme.of(this).colorScheme.onSurface;

  Color get secondaryFixed => Theme.of(this).colorScheme.secondaryFixed;

  Color get onSecondaryFixed => Theme.of(this).colorScheme.onSecondaryFixed;

  Color get primaryFixed => Theme.of(this).colorScheme.primaryFixed;

  Color get secondaryFixedDim => Theme.of(this).colorScheme.secondaryFixedDim;

  Color get primary => Theme.of(this).colorScheme.primary;

  Color get secondaryContainer => Theme.of(this).colorScheme.secondaryContainer;

  Color get onSecondaryContainer =>
      Theme.of(this).colorScheme.onSecondaryContainer;

  Color get primaryContainer => Theme.of(this).colorScheme.primaryContainer;

  Color get outline => Theme.of(this).colorScheme.outline;

  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  EdgeInsets get padding => MediaQuery.paddingOf(this);

  double get topPadding => MediaQuery.paddingOf(this).top;

  double get bottomPadding => MediaQuery.paddingOf(this).bottom;

  // Shortcut to check if the software keyboard is visible
  bool get isKeyboardOpen => MediaQuery.viewInsetsOf(this).bottom > 0;
}

extension CustomTheme on ThemeMode {
  String themeModeToString() {
    return switch (this) {
      ThemeMode.system => 'System Mode',
      ThemeMode.light => 'Light Mode',
      ThemeMode.dark => 'Dark Mode',
    };
  }
}
