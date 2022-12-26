import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xffffffff);
  static const Color darkPurple = Color(0xff6A68D0);
  static const Color darkPink = Color(0xffED5D74);
  static const Color bodyTextColor = Color(0xff252525);
  static const Color accentColor = Color(0xffEEE5FF);

  static const Map<int, Color> darkPurplecolor = {
    50: Color.fromRGBO(106, 104, 208, .1),
    100: Color.fromRGBO(106, 104, 208, .2),
    200: Color.fromRGBO(106, 104, 208, .3),
    300: Color.fromRGBO(106, 104, 208, .4),
    400: Color.fromRGBO(106, 104, 208, .5),
    500: Color.fromRGBO(106, 104, 208, .6),
    600: Color.fromRGBO(106, 104, 208, .7),
    700: Color.fromRGBO(106, 104, 208, .8),
    800: Color.fromRGBO(106, 104, 208, .9),
    900: Color.fromRGBO(106, 104, 208, 1),
  };

  static const MaterialColor materialDarkPurple =
      MaterialColor(0xff6A68D0, darkPurplecolor);
}
