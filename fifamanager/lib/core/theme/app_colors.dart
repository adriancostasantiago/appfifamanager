import 'package:flutter/material.dart';

/// Paleta de cores global do FC Manager.
/// Todas as páginas e widgets devem referenciar estas constantes
/// em vez de definir cores localmente.
abstract final class AppColors {
  // ── Backgrounds ───────────────────────────────────────────────────────────
  static const Color background     = Color(0xFF101314);
  static const Color backgroundDark = Color(0xFF121414);
  static const Color card           = Color(0xFF16191D);
  static const Color cardAlt        = Color(0xFF1A1E22);
  static const Color cardDark       = Color(0xFF131619);

  // ── Borders ───────────────────────────────────────────────────────────────
  static const Color border         = Color(0xFF1F2327);

  // ── Accent ────────────────────────────────────────────────────────────────
  static const Color accent         = Color(0xFF00FF41);
  static const Color accentLight    = Color(0xFF72FF70);
  static const Color accentStrong   = Color(0xFF1FE35B);
  static const Color accentDark     = Color(0xFF003907);
  static const Color accentSubtle   = Color(0xFF0A1A0E);
  static const Color accentBg       = Color(0xFF0B1C10);

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color muted          = Color(0xFF7C8579);
  static const Color subtle         = Color(0xFF9AA39C);
  static const Color light          = Color(0xFFD7E2D1);
  static const Color textSecondary  = Color(0xFFB0B6A7);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color red            = Color(0xFFE53935);
  static const Color blue           = Color(0xFF4FC3F7);
  static const Color orange         = Color(0xFFFFB74D);
  static const Color amber          = Colors.amber;
}
