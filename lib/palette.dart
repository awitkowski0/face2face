import 'package:flutter/material.dart';

final ThemeData defaultTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Palette.grape[500],
    scaffoldBackgroundColor: Palette.mauve,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Palette.pink).copyWith(secondary: Palette.orange[500])
);

// the 500 value of any color is the primary color. all others are shades
// <500 is lighter, >500 is darker.
class Palette {
  Palette._();


  static const MaterialColor orange = MaterialColor(_orangePrimaryValue, <int, Color>{
    50: Color(0xFFFEF3EB),
    100: Color(0xFFFDE2CE),
    200: Color(0xFFFCCFAD),
    300: Color(0xFFFABC8C),
    400: Color(0xFFF9AD74),
    500: Color(_orangePrimaryValue),
    600: Color(0xFFF79753),
    700: Color(0xFFF68D49),
    800: Color(0xFFF58340),
    900: Color(0xFFF3722F),
  });
  static const int _orangePrimaryValue = 0xFFF89F5B;

  static const MaterialColor pink = MaterialColor(_pinkPrimaryValue, <int, Color>{
    50: Color(0xFFFCE8EE),
    100: Color(0xFFF7C5D4),
    200: Color(0xFFF29FB8),
    300: Color(0xFFED799C),
    400: Color(0xFFE95C86),
    500: Color(_pinkPrimaryValue),
    600: Color(0xFFE23969),
    700: Color(0xFFDE315E),
    800: Color(0xFFDA2954),
    900: Color(0xFFD31B42),
  });
  static const int _pinkPrimaryValue = 0xFFE53F71;


  static const MaterialColor orchid = MaterialColor(_orchidPrimaryValue, <int, Color>{
    50: Color(0xFFF3E7F1),
    100: Color(0xFFE1C2DB),
    200: Color(0xFFCE9AC3),
    300: Color(0xFFBA72AB),
    400: Color(0xFFAB5399),
    500: Color(_orchidPrimaryValue),
    600: Color(0xFF94307F),
    700: Color(0xFF8A2874),
    800: Color(0xFF80226A),
    900: Color(0xFF6E1657),
  });
  static const int _orchidPrimaryValue = 0xFF9C3587;


  static const MaterialColor mauve = MaterialColor(_mauvePrimaryValue, <int, Color>{
    50: Color(0xFFEDE7F0),
    100: Color(0xFFD1C3D9),
    200: Color(0xFFB29BC0),
    300: Color(0xFF9373A6),
    400: Color(0xFF7C5593),
    500: Color(_mauvePrimaryValue),
    600: Color(0xFF5D3178),
    700: Color(0xFF532A6D),
    800: Color(0xFF492363),
    900: Color(0xFF371650),
  });
  static const int _mauvePrimaryValue = 0xFF653780;


  static const MaterialColor grape = MaterialColor(_grapePrimaryValue, <int, Color>{
    50: Color(0xFFE8E3EA),
    100: Color(0xFFC5B9CB),
    200: Color(0xFF9F8BA8),
    300: Color(0xFF795C85),
    400: Color(0xFF5C396B),
    500: Color(_grapePrimaryValue),
    600: Color(0xFF39134A),
    700: Color(0xFF311040),
    800: Color(0xFF290C37),
    900: Color(0xFF1B0627),
  });
  static const int _grapePrimaryValue = 0xFF3F1651;
}
