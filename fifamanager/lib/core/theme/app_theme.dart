import 'package:flutter/material.dart';

@immutable
class FCColors extends ThemeExtension<FCColors> {
  final Color background;
  final Color backgroundDark;
  final Color card;
  final Color cardAlt;
  final Color cardDark;

  final Color border;

  final Color accent;
  final Color accentLight;
  final Color accentStrong;
  final Color accentDark;
  final Color accentSubtle;
  final Color accentBg;

  final Color muted;
  final Color subtle;
  final Color light;
  final Color textSecondary;

  final Color green;
  final Color red;
  final Color blue;
  final Color orange;
  final Color amber;

  const FCColors({
    required this.background,
    required this.backgroundDark,
    required this.card,
    required this.cardAlt,
    required this.cardDark,
    required this.border,
    required this.accent,
    required this.accentLight,
    required this.accentStrong,
    required this.accentDark,
    required this.accentSubtle,
    required this.accentBg,
    required this.muted,
    required this.subtle,
    required this.light,
    required this.textSecondary,
    required this.green,
    required this.red,
    required this.blue,
    required this.orange,
    required this.amber,
  });

  @override
  FCColors copyWith({
    Color? background,
    Color? backgroundDark,
    Color? card,
    Color? cardAlt,
    Color? cardDark,
    Color? border,
    Color? accent,
    Color? accentLight,
    Color? accentStrong,
    Color? accentDark,
    Color? accentSubtle,
    Color? accentBg,
    Color? muted,
    Color? subtle,
    Color? light,
    Color? textSecondary,
    Color? green,
    Color? red,
    Color? blue,
    Color? orange,
    Color? amber,
  }) {
    return FCColors(
      background: background ?? this.background,
      backgroundDark: backgroundDark ?? this.backgroundDark,
      card: card ?? this.card,
      cardAlt: cardAlt ?? this.cardAlt,
      cardDark: cardDark ?? this.cardDark,
      border: border ?? this.border,
      accent: accent ?? this.accent,
      accentLight: accentLight ?? this.accentLight,
      accentStrong: accentStrong ?? this.accentStrong,
      accentDark: accentDark ?? this.accentDark,
      accentSubtle: accentSubtle ?? this.accentSubtle,
      accentBg: accentBg ?? this.accentBg,
      muted: muted ?? this.muted,
      subtle: subtle ?? this.subtle,
      light: light ?? this.light,
      textSecondary: textSecondary ?? this.textSecondary,
      green: green ?? this.green,
      red: red ?? this.red,
      blue: blue ?? this.blue,
      orange: orange ?? this.orange,
      amber: amber ?? this.amber,
    );
  }

  @override
  FCColors lerp(ThemeExtension<FCColors>? other, double t) {
    if (other is! FCColors) return this;

    return FCColors(
      background: Color.lerp(background, other.background, t)!,
      backgroundDark: Color.lerp(backgroundDark, other.backgroundDark, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardAlt: Color.lerp(cardAlt, other.cardAlt, t)!,
      cardDark: Color.lerp(cardDark, other.cardDark, t)!,
      border: Color.lerp(border, other.border, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentLight: Color.lerp(accentLight, other.accentLight, t)!,
      accentStrong: Color.lerp(accentStrong, other.accentStrong, t)!,
      accentDark: Color.lerp(accentDark, other.accentDark, t)!,
      accentSubtle: Color.lerp(accentSubtle, other.accentSubtle, t)!,
      accentBg: Color.lerp(accentBg, other.accentBg, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      subtle: Color.lerp(subtle, other.subtle, t)!,
      light: Color.lerp(light, other.light, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      green: Color.lerp(green, other.green, t)!,
      red: Color.lerp(red, other.red, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
    );
  }
}

class AppTheme {
  static const FCColors darkColors = FCColors(
    background: Color(0xFF101314),
    backgroundDark: Color(0xFF121414),
    card: Color(0xFF16191D),
    cardAlt: Color(0xFF1A1E22),
    cardDark: Color(0xFF131619),

    border: Color(0xFF1F2327),

    accent: Color(0xFF00FF41),
    accentLight: Color(0xFF72FF70),
    accentStrong: Color(0xFF1FE35B),
    accentDark: Color(0xFF003907),
    accentSubtle: Color(0xFF0A1A0E),
    accentBg: Color(0xFF0B1C10),

    muted: Color(0xFF7C8579),
    subtle: Color(0xFF9AA39C),
    light: Color(0xFFD7E2D1),
    textSecondary: Color(0xFFB0B6A7),

    green: Color(0xFF00FF41),
    red: Color(0xFFE53935),
    blue: Color(0xFF4FC3F7),
    orange: Color(0xFFFFB74D),
    amber: Colors.amber,
  );

  static const FCColors lightColors = FCColors(
    background: Color(0xFFF5F7F8),
    backgroundDark: Color(0xFFE8ECEF),
    card: Colors.white,
    cardAlt: Color(0xFFF3F5F7),
    cardDark: Color(0xFFE7EBEF),

    border: Color(0xFFD6DCE2),

    accent: Color(0xFF00C853),
    accentLight: Color(0xFF5EF38D),
    accentStrong: Color(0xFF00A844),
    accentDark: Color(0xFF006D2E),
    accentSubtle: Color(0xFFE7F8EC),
    accentBg: Color(0xFFF0FFF5),

    muted: Color(0xFF6B7280),
    subtle: Color(0xFF4B5563),
    light: Color(0xFF111827),
    textSecondary: Color(0xFF374151),

    green: Color(0xFF00FF41),
    red: Color(0xFFE53935),
    blue: Color(0xFF2196F3),
    orange: Color(0xFFFF9800),
    amber: Colors.amber,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkColors.background,
    cardColor: darkColors.card,
    primaryColor: darkColors.accent,
    extensions: const [darkColors],
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightColors.background,
    cardColor: lightColors.card,
    primaryColor: lightColors.accent,
    extensions: const [lightColors],
  );
}

extension FCThemeExtension on BuildContext {
  FCColors get colors => Theme.of(this).extension<FCColors>()!;
}
