import 'package:flutter/material.dart';

// ─── MODELOS DE TROFÉUS ──────────────────────────────────────────────────────

enum TrophyTier { seriea, serieb, copa }

class TrophyData {
  final String year;
  final String competitionLabel;
  final TrophyTier tier;
  final IconData icon;

  // Estatísticas da temporada — usadas pela ChampionPage
  final int jogos;
  final int vitorias;
  final int empates;
  final int derrotas;
  final int gols;
  final int golsSofridos;

  const TrophyData({
    required this.year,
    required this.competitionLabel,
    required this.tier,
    this.icon = Icons.emoji_events,
    this.jogos = 0,
    this.vitorias = 0,
    this.empates = 0,
    this.derrotas = 0,
    this.gols = 0,
    this.golsSofridos = 0,
  });

  /// Pontos totais (vitória = 3, empate = 1).
  int get pontos => vitorias * 3 + empates;

  /// Saldo de gols.
  int get saldoGols => gols - golsSofridos;

  /// Aproveitamento em percentual (0–100).
  double get aproveitamento => jogos == 0 ? 0 : (pontos / (jogos * 3)) * 100;
}

class TrophyGroupData {
  final String title;
  final String subtitle;
  final Color accentColor;
  final Image imageTrophy;
  final String imageURL;
  final List<TrophyData> trophies;

  const TrophyGroupData({
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.trophies,
    required this.imageTrophy,
    required this.imageURL,
  });
}
