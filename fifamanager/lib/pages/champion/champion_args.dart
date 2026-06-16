import 'package:flutter/material.dart';

/// Dados passados da [TrophyRoomPage] para a [ChampionPage] via
/// [Navigator.pushNamed] arguments.
class ChampionArgs {
  final String teamName;
  final int jogos;
  final int vitorias;
  final int gols;
  final String year;
  final String competitionLabel;
  final Color accentColor;

  const ChampionArgs({
    required this.teamName,
    required this.jogos,
    required this.vitorias,
    required this.gols,
    this.year = '',
    this.competitionLabel = '',
    this.accentColor = const Color(0xFF00FF41),
  });
}
