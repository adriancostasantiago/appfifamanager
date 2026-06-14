// ─── MODELOS DE ELENCO ──────────────────────────────────────────────────────

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
}

enum SquadViewMode { resumo, detalhado }
