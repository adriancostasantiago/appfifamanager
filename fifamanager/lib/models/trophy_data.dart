import 'package:flutter/material.dart';

// ─── MODELOS DE TROFÉUS ──────────────────────────────────────────────────────

enum TrophyTier { seriea, serieb, copa }

class TrophyData {
  final String year;
  final String competitionLabel;
  final TrophyTier tier;
  final IconData icon;

  const TrophyData({
    required this.year,
    required this.competitionLabel,
    required this.tier,
    this.icon = Icons.emoji_events,
  });
}

class TrophyGroupData {
  final String title;
  final String subtitle;
  final Color accentColor;
  final Image imageTrophy;
  final List<TrophyData> trophies;

  const TrophyGroupData({
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.trophies,
    required this.imageTrophy,
  });
}
