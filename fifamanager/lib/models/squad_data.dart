// ─── MODELOS DE ELENCO ──────────────────────────────────────────────────────

import 'dart:ui';

class SquadData {
  final double averageOvr;
  final int playerCount;
  final String totalValue;
  final String totalSalary;
  final List<PlayerData> players;

  SquadData({
    required this.averageOvr,
    required this.playerCount,
    required this.totalValue,
    required this.totalSalary,
    required this.players,
  });
}

class PlayerData {
  final String name;
  final String country;
  final String position;
  final String photo;
  final int ovr;
  final String? marketValue;
  final String? salary;

  /// Quantos anos de contrato o jogador ainda possui (1 a 5).
  final int contractUntil;

  PlayerData({
    required this.name,
    required this.country,
    required this.position,
    required this.photo,
    required this.ovr,
    this.marketValue,
    this.salary,
    this.contractUntil = 1,
  });

  Color get ovrColor {
    if (ovr <= 50) {
      return const Color(0xFFE53935);
    } else if (ovr <= 60) {
      return const Color(0xFFFF9800);
    } else if (ovr <= 70) {
      return const Color.fromARGB(255, 255, 232, 29);
    } else if (ovr <= 80) {
      return const Color.fromARGB(255, 145, 231, 46);
    } else {
      return const Color.fromARGB(255, 9, 161, 72);
    }
  }
}

enum SquadViewMode { resumo, detalhado }
