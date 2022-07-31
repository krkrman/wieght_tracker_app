import 'package:flutter/material.dart';

class ColorManager {
  static const Color primaryColor = Color(0xff247c2c);
  static const Color accentColor = Color(0xff61697f);
  static const Color secondaryColor = Color(0xff0b778d);
  static const Color textSecondaryColor = Color(0xFFF0F0F0);
  static const Color buttonColor = Color(0xFF25C06D);
  static const List<Color> tasksColors = [
    Color(0xFFFF5147),
    Color(0xFFFF9D42),
    Color(0xFFF9C50B),
    Color(0xFF42A0FF),
    Colors.greenAccent,
    Colors.yellow,
    Colors.brown,
  ];
}

/// convert color from and to string
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
