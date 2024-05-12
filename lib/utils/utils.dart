import 'package:flutter/material.dart';

/// Darken a color by [percent] amount (1 = black)
// ........................................................
Color darken(Color c, [double percent = 0.1]) {
  if (percent <= 0) return c;
  assert(percent <= 1);

  var f = 1 - percent;
  return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
      (c.blue * f).round());
}

/// Lighten a color by [percent] amount (1 = white)
// ........................................................
Color lighten(Color c, [double percent = 0.1]) {
  if (percent <= 0) return c;
  assert(percent <= 1);
  return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * percent).round(),
      c.green + ((255 - c.green) * percent).round(),
      c.blue + ((255 - c.blue) * percent).round());
}

Color tintColor(Color c, Brightness brightness, [double percent = 0.1]) {
  return switch (brightness) {
    Brightness.dark => lighten(c, percent),
    Brightness.light => darken(c, percent)
  };
}
