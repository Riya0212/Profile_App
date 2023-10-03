import 'package:flutter/material.dart';

///colors used in the ui
class AppColors {
  ///const color val
  static const Color lightGreyWhite = Color.fromRGBO(251, 252, 255, 1);

  ///const color var
  static Color buttonTextColor = Color.alphaBlend(
    const Color.fromARGB(255, 2, 56, 110),
    const Color.fromARGB(255, 0, 11, 24),
  );

  ///const color var
  static Color darkBlue = Color.alphaBlend(
    const Color.fromARGB(255, 2, 56, 110),
    const Color.fromARGB(255, 0, 11, 24),
  );

  ///const color var
  static Color lightBlue = Color.alphaBlend(
    const Color.fromARGB(255, 2, 56, 110),
    const Color.fromARGB(255, 0, 82, 162),
  ).withOpacity(0.3);

  ///const color list
  static List<Color> colorList = [
    const Color.fromARGB(255, 0, 82, 162),
    const Color.fromARGB(255, 0, 73, 142),
    const Color.fromARGB(255, 2, 56, 110),
    Color.alphaBlend(
      const Color.fromARGB(255, 2, 56, 110),
      const Color.fromARGB(255, 0, 11, 24),
    ),
    Color.alphaBlend(
      const Color.fromARGB(255, 2, 56, 110),
      const Color.fromARGB(255, 0, 11, 24),
    ),
    const Color.fromARGB(255, 0, 38, 77),
    const Color.fromARGB(255, 0, 11, 24),
  ];
}
