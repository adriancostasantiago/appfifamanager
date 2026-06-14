import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─── THEME EXTENSION ─────────────────────────────────────────────────────────

@immutable
class FCColors extends ThemeExtension<FCColors> {
  // Backgrounds
  final Color background;
  final Color backgroundDark;
  final Color card;
  final Color cardAlt;
  final Color cardDark;

  // Borders & dividers
  final Color border;
  final Color divider;

  // Accent / brand
  final Color accent;
  final Color accentLight;
  final Color accentStrong;
  final Color accentDark;
  final Color accentSubtle;
  final Color accentBg;

  // Text hierarchy
  final Color textPrimary; // headings, values
  final Color textSecondary; // labels, subtitles
  final Color muted; // placeholders, captions
  final Color subtle; // very secondary text
  final Color light; // lightest text (for dark bg only)
  final Color onAccent; // text ON accent-colored backgrounds

  // Semantic
  final Color green;
  final Color greenBg;
  final Color red;
  final Color redBg;
  final Color blue;
  final Color blueBg;
  final Color orange;
  final Color orangeBg;
  final Color amber;

  // Shadow / elevation feel
  final List<BoxShadow> cardShadow;

  const FCColors({
    required this.background,
    required this.backgroundDark,
    required this.card,
    required this.cardAlt,
    required this.cardDark,
    required this.border,
    required this.divider,
    required this.accent,
    required this.accentLight,
    required this.accentStrong,
    required this.accentDark,
    required this.accentSubtle,
    required this.accentBg,
    required this.textPrimary,
    required this.textSecondary,
    required this.muted,
    required this.subtle,
    required this.light,
    required this.onAccent,
    required this.green,
    required this.greenBg,
    required this.red,
    required this.redBg,
    required this.blue,
    required this.blueBg,
    required this.orange,
    required this.orangeBg,
    required this.amber,
    required this.cardShadow,
  });

  @override
  FCColors copyWith({
    Color? background,
    Color? backgroundDark,
    Color? card,
    Color? cardAlt,
    Color? cardDark,
    Color? border,
    Color? divider,
    Color? accent,
    Color? accentLight,
    Color? accentStrong,
    Color? accentDark,
    Color? accentSubtle,
    Color? accentBg,
    Color? textPrimary,
    Color? textSecondary,
    Color? muted,
    Color? subtle,
    Color? light,
    Color? onAccent,
    Color? green,
    Color? greenBg,
    Color? red,
    Color? redBg,
    Color? blue,
    Color? blueBg,
    Color? orange,
    Color? orangeBg,
    Color? amber,
    List<BoxShadow>? cardShadow,
  }) {
    return FCColors(
      background: background ?? this.background,
      backgroundDark: backgroundDark ?? this.backgroundDark,
      card: card ?? this.card,
      cardAlt: cardAlt ?? this.cardAlt,
      cardDark: cardDark ?? this.cardDark,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      accent: accent ?? this.accent,
      accentLight: accentLight ?? this.accentLight,
      accentStrong: accentStrong ?? this.accentStrong,
      accentDark: accentDark ?? this.accentDark,
      accentSubtle: accentSubtle ?? this.accentSubtle,
      accentBg: accentBg ?? this.accentBg,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      muted: muted ?? this.muted,
      subtle: subtle ?? this.subtle,
      light: light ?? this.light,
      onAccent: onAccent ?? this.onAccent,
      green: green ?? this.green,
      greenBg: greenBg ?? this.greenBg,
      red: red ?? this.red,
      redBg: redBg ?? this.redBg,
      blue: blue ?? this.blue,
      blueBg: blueBg ?? this.blueBg,
      orange: orange ?? this.orange,
      orangeBg: orangeBg ?? this.orangeBg,
      amber: amber ?? this.amber,
      cardShadow: cardShadow ?? this.cardShadow,
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
      divider: Color.lerp(divider, other.divider, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentLight: Color.lerp(accentLight, other.accentLight, t)!,
      accentStrong: Color.lerp(accentStrong, other.accentStrong, t)!,
      accentDark: Color.lerp(accentDark, other.accentDark, t)!,
      accentSubtle: Color.lerp(accentSubtle, other.accentSubtle, t)!,
      accentBg: Color.lerp(accentBg, other.accentBg, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      subtle: Color.lerp(subtle, other.subtle, t)!,
      light: Color.lerp(light, other.light, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      green: Color.lerp(green, other.green, t)!,
      greenBg: Color.lerp(greenBg, other.greenBg, t)!,
      red: Color.lerp(red, other.red, t)!,
      redBg: Color.lerp(redBg, other.redBg, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      blueBg: Color.lerp(blueBg, other.blueBg, t)!,
      orange: Color.lerp(orange, other.orange, t)!,
      orangeBg: Color.lerp(orangeBg, other.orangeBg, t)!,
      amber: Color.lerp(amber, other.amber, t)!,
      cardShadow: t < 0.5 ? cardShadow : other.cardShadow,
    );
  }
}

// ─── PALETAS ─────────────────────────────────────────────────────────────────

class AppTheme {
  // ── DARK ──────────────────────────────────────────────────────────────────
  static const FCColors _dark = FCColors(
    background: Color(0xFF101314),
    backgroundDark: Color(0xFF121414),
    card: Color(0xFF16191D),
    cardAlt: Color(0xFF1A1E22),
    cardDark: Color(0xFF131619),
    border: Color(0xFF1F2327),
    divider: Color(0xFF232729),

    accent: Color(0xFF00FF41),
    accentLight: Color(0xFF72FF70),
    accentStrong: Color(0xFF1FE35B),
    accentDark: Color(0xFF003907),
    accentSubtle: Color(0xFF0A1A0E),
    accentBg: Color(0xFF0B1C10),

    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFB0B6A7),
    muted: Color(0xFF7C8579),
    subtle: Color(0xFF9AA39C),
    light: Color(0xFFD7E2D1),
    onAccent: Color(0xFF003907),

    green: Color(0xFF00FF41),
    greenBg: Color(0xFF0B1C10),
    red: Color(0xFFE53935),
    redBg: Color(0xFF2A0E0D),
    blue: Color(0xFF4FC3F7),
    blueBg: Color(0xFF0C1E2A),
    orange: Color(0xFFFFB74D),
    orangeBg: Color(0xFF2A1A05),
    amber: Colors.amber,

    cardShadow: [],
  );

  // ── LIGHT ─────────────────────────────────────────────────────────────────
  // Conceito: fundo cinza-azulado suave (#F0F2F5), cards brancos com sombra
  // sutil, accent verde vibrante (#00A650), texto quase-preto para contraste
  // total. Hierarquia clara: primary #111827 / secondary #374151 / muted #6B7280
  static const FCColors _light = FCColors(
    background: Color(0xFFF0F2F5), // cinza-azulado, não branco puro
    backgroundDark: Color(0xFFE4E8ED), // seções mais profundas (drawer, appbar)
    card: Color(0xFFFFFFFF), // cards brancos com sombra
    cardAlt: Color(0xFFF7F9FC), // card interno / sub-card
    cardDark: Color(0xFFEDF0F4), // linha zebra / header de tabela

    border: Color(0xFFDDE1E8), // borda visível mas suave
    divider: Color(0xFFE8EBF0), // divisor dentro de cards

    accent: Color(0xFF00A650), // verde mais escuro — legível no claro
    accentLight: Color(0xFF34C472), // verde médio
    accentStrong: Color(0xFF008040), // verde intenso para hover/press
    accentDark: Color(0xFF005C2E), // texto sobre accent
    accentSubtle: Color(0xFFE8F8EF), // fundo pill/chip verde
    accentBg: Color(0xFFF0FAF4), // fundo seção accent

    textPrimary: Color(0xFF111827), // quase-preto — máximo contraste
    textSecondary: Color(0xFF374151), // títulos secundários
    muted: Color(0xFF6B7280), // labels, captions
    subtle: Color(0xFF9CA3AF), // placeholders
    light: Color(0xFF111827), // no light theme = igual textPrimary
    onAccent: Color(0xFFFFFFFF), // texto SOBRE botões verdes

    green: Color(0xFF00A650),
    greenBg: Color(0xFFE8F8EF),
    red: Color(0xFFDC2626), // vermelho mais saturado no claro
    redBg: Color(0xFFFEF2F2),
    blue: Color(0xFF2563EB), // azul legível
    blueBg: Color(0xFFEFF6FF),
    orange: Color(0xFFD97706), // âmbar escuro — legível
    orangeBg: Color(0xFFFFFBEB),
    amber: Color(0xFFD97706),

    cardShadow: [
      BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 2)),
      BoxShadow(color: Color(0x08000000), blurRadius: 1, offset: Offset(0, 0)),
    ],
  );

  // ── THEMEDATA ─────────────────────────────────────────────────────────────
  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _dark.background,
    cardColor: _dark.card,
    primaryColor: _dark.accent,
    dividerColor: _dark.divider,
    appBarTheme: AppBarTheme(
      backgroundColor: _dark.background,
      foregroundColor: _dark.textPrimary,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(color: _dark.textPrimary),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _dark.card,
      selectedItemColor: _dark.accent,
      unselectedItemColor: _dark.muted,
    ),
    extensions: const [_dark],
  );

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: _light.background,
    cardColor: _light.card,
    primaryColor: _light.accent,
    dividerColor: _light.divider,
    appBarTheme: AppBarTheme(
      backgroundColor: _light.card, // appbar branca no light
      foregroundColor: _light.textPrimary,
      elevation: 0,
      shadowColor: const Color(0x14000000),
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: IconThemeData(color: _light.textPrimary),
      titleTextStyle: TextStyle(
        color: _light.accent,
        fontWeight: FontWeight.w900,
        fontSize: 18,
        letterSpacing: 1.2,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _light.card,
      selectedItemColor: _light.accent,
      unselectedItemColor: _light.muted,
      elevation: 8,
    ),
    extensions: const [_light],
  );
}

// ─── EXTENSION DE ACESSO ─────────────────────────────────────────────────────

extension FCThemeX on BuildContext {
  FCColors get colors => Theme.of(this).extension<FCColors>()!;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}
