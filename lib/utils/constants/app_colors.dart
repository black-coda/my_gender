import 'package:flutter/material.dart';
import 'package:my_gender/extensions/string/as_html_color_to_color.dart';


@immutable
class AppColors {
  static final loginButtonColor = '#cfc9c2'.htmlColorToColor();
  static const loginButtonTextColor = Colors.black;
  static final googleColor = '#4285F4'.htmlColorToColor();
  static final facebookColor = '#3b5998'.htmlColorToColor();
  const AppColors._();
}


class ThemeScheme{
  // Light and dark ColorSchemes made by FlexColorScheme v7.3.1.
// These ColorScheme objects require Flutter 3.7 or later.
  static const ColorScheme flexSchemeLight = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff5c000e),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xfff4cace),
    onPrimaryContainer: Color(0xff141111),
    secondary: Color(0xff74540e),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffffdea3),
    onSecondaryContainer: Color(0xff14120e),
    tertiary: Color(0xffad8845),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xffffe8c0),
    onTertiaryContainer: Color(0xff141310),
    error: Color(0xffb00020),
    onError: Color(0xffffffff),
    errorContainer: Color(0xfffcd8df),
    onErrorContainer: Color(0xff141213),
    surface: Color(0xfffaf8f8),
    onSurface: Color(0xff090909),
    surfaceContainerHighest: Color(0xffe5e0e1),
    onSurfaceVariant: Color(0xff111111),
    outline: Color(0xff7c7c7c),
    outlineVariant: Color(0xffc8c8c8),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xff131010),
    onInverseSurface: Color(0xfff5f5f5),
    inversePrimary: Color(0xffd18a95),
    surfaceTint: Color(0xff5c000e),
  );

  static const ColorScheme flexSchemeDark = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xff9c5a69),
    onPrimary: Color(0xfffbf6f7),
    primaryContainer: Color(0xff5f111e),
    onPrimaryContainer: Color(0xffeee2e4),
    secondary: Color(0xffedce9b),
    onSecondary: Color(0xff141410),
    secondaryContainer: Color(0xff805e23),
    onSecondaryContainer: Color(0xfff3eee5),
    tertiary: Color(0xfff5dfb9),
    onTertiary: Color(0xff141412),
    tertiaryContainer: Color(0xff8e6e3c),
    onTertiaryContainer: Color(0xfff6f1e9),
    error: Color(0xffcf6679),
    onError: Color(0xff140c0d),
    errorContainer: Color(0xffb1384e),
    onErrorContainer: Color(0xfffbe8ec),
    surface: Color(0xff181415),
    onSurface: Color(0xffececec),
    surfaceContainerHighest: Color(0xff3c3637),
    onSurfaceVariant: Color(0xffe0dfdf),
    outline: Color(0xff797979),
    outlineVariant: Color(0xff2d2d2d),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xfff9f6f7),
    onInverseSurface: Color(0xff131313),
    inversePrimary: Color(0xff52353b),
    surfaceTint: Color(0xff9c5a69),
  );

}