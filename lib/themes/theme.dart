import 'package:flutter/material.dart';
import 'package:mini_games/themes/constant.dart';

class GlobalThemData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
      ),
      textTheme: TextTheme(
        headlineSmall: boldTextStyle,
        headlineMedium: boldTextStyle,
        headlineLarge: boldTextStyle,
        titleLarge: boldTextStyle,
        titleMedium: boldTextStyle,
        titleSmall: boldTextStyle.copyWith(color: kGreyColor.shade800),
        labelLarge: labelTextStyle.copyWith(fontSize: 15),
        labelMedium: labelTextStyle,
        labelSmall: labelTextStyle,
      ),
      iconButtonTheme: iconButtonTheme,
      textButtonTheme: textButtonTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme,
      floatingActionButtonTheme: floatingActionButtonTheme,
    );
  }

  static const TextStyle boldTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    letterSpacing: .6,
  );

  static const TextStyle labelTextStyle = TextStyle(
    letterSpacing: .6,
    color: kGreyColor,
  );

  static IconButtonThemeData iconButtonTheme = IconButtonThemeData(
    style: IconButton.styleFrom(
      padding: const EdgeInsets.all(4),
      foregroundColor: kWhiteColor,
      backgroundColor: kWhiteColor.withOpacity(0.3),
      disabledBackgroundColor: kWhiteColor.withOpacity(0.3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
    ),
  );

  static TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 12),
      foregroundColor: kWhiteColor,
      backgroundColor: kPrimaryColor,
      disabledBackgroundColor: kGreyColor.shade200,
      textStyle: const TextStyle(letterSpacing: 1, fontWeight: FontWeight.w500),
    ),
  );

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: kWhiteColor,
      backgroundColor: kPrimaryColor,
      disabledBackgroundColor: kGreyColor.shade200,
      padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
  );

  static OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(
        width: 1.0,
        color: kGreyColor.shade500,
      ),
    ),
  );

  static const floatingActionButtonTheme = FloatingActionButtonThemeData(
    foregroundColor: kWhiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(40),
      ),
    ),
  );

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: kPrimaryColor,
    onPrimary: kBlackColor,
    secondary: kWhiteColor,
    onSecondary: kSecondaryColor,
    error: kRedColor,
    onError: kWhiteColor,
    surface: kWhiteColor,
    onSurface: kBlackColor,
    brightness: Brightness.light,
  );
}
