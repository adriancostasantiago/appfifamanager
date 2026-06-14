// ─── MODELOS DE LIGA E COMPETIÇÕES ──────────────────────────────────────────

enum LeagueTab {
  classificacao,
  artilharia,
  jogos,
  copaMataMata,
  copaArtilharia,
  copaJogos,
}

enum LeagueSeries { serieA, serieB, copa }

enum MatchStatus { todos, finalizado, pendente, aIniciar }

/// Partida de jogo único (Série A / Série B)
class LeagueMatchData {
  final String homeTeam;
  final String awayTeam;
  final String score;
  final String venue;
  final MatchStatus status;
  final bool isHomeWinner;
  final bool isAwayWinner;

  const LeagueMatchData({
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
    required this.venue,
    required this.status,
    this.isHomeWinner = false,
    this.isAwayWinner = false,
  });
}

/// Partida de mata-mata com ida e volta (Copa)
class CupMatchData {
  final String homeTeam;
  final String awayTeam;
  final String score;
  final String venue;
  final bool isHomeWinner;
  final bool isAwayWinner;
  final String leg1Score;
  final MatchStatus leg1Status;
  final String leg2Score;
  final MatchStatus leg2Status;

  const CupMatchData({
    required this.homeTeam,
    required this.awayTeam,
    required this.score,
    required this.venue,
    this.isHomeWinner = false,
    this.isAwayWinner = false,
    required this.leg1Score,
    required this.leg1Status,
    required this.leg2Score,
    required this.leg2Status,
  });

  /// Derivado dos legs: ambos finalizado → finalizado; nenhum iniciado → aIniciar; senão → pendente
  MatchStatus get status {
    if (leg1Status == MatchStatus.finalizado &&
        leg2Status == MatchStatus.finalizado) {
      return MatchStatus.finalizado;
    }
    if (leg1Status == MatchStatus.aIniciar &&
        leg2Status == MatchStatus.aIniciar) {
      return MatchStatus.aIniciar;
    }
    return MatchStatus.pendente;
  }
}

class KnockoutRoundData {
  final String label;
  final List<CupMatchData> matches;

  const KnockoutRoundData({required this.label, required this.matches});
}

class TopScorerData {
  final String position;
  final String name;
  final String club;
  final String goals;

  const TopScorerData({
    required this.position,
    required this.name,
    required this.club,
    required this.goals,
  });
}
