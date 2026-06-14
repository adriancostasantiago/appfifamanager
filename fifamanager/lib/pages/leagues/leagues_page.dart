import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';
import 'package:fifamanager/models/models.dart';
import 'package:fifamanager/core/theme/app_colors.dart';
import 'package:fifamanager/widgets/app_bottom_navigation.dart';
import 'package:fifamanager/widgets/app_drawer.dart';
import 'package:fifamanager/widgets/standings_table.dart';
import 'package:fifamanager/pages/leagues/full_standings_page.dart';

final _copaKnockoutRounds = [
  KnockoutRoundData(
    label: 'OITAVAS',
    matches: [
      CupMatchData(
        homeTeam: 'FLAMENGO',
        awayTeam: 'PALMEIRAS',
        score: '3-1',
        isHomeWinner: true,
        leg1Score: '1-1',
        leg1Status: MatchStatus.finalizado,
        leg2Score: '2-0',
        leg2Status: MatchStatus.pendente,
        venue: 'ARENA MARACANÃ',
      ),
      CupMatchData(
        homeTeam: 'CORINTHIANS',
        awayTeam: 'SÃO PAULO',
        score: '0-2',
        isAwayWinner: true,
        leg1Score: '0-1',
        leg1Status: MatchStatus.finalizado,
        leg2Score: '0-1',
        leg2Status: MatchStatus.finalizado,
        venue: 'ESTÁDIO MORUMBI',
      ),
      CupMatchData(
        homeTeam: 'GRÊMIO',
        awayTeam: 'INTER',
        score: '4-2',
        isHomeWinner: true,
        leg1Score: '2-1',
        leg1Status: MatchStatus.finalizado,
        leg2Score: '2-1',
        leg2Status: MatchStatus.finalizado,
        venue: 'ARENA DO GRÊMIO',
      ),
      CupMatchData(
        homeTeam: 'CRUZEIRO',
        awayTeam: 'ATLÉTICO MG',
        score: '1-2',
        isAwayWinner: true,
        leg1Score: '1-1',
        leg1Status: MatchStatus.finalizado,
        leg2Score: '0-1',
        leg2Status: MatchStatus.finalizado,
        venue: 'MINEIRÃO',
      ),
    ],
  ),
  KnockoutRoundData(
    label: 'QUARTAS',
    matches: [
      CupMatchData(
        homeTeam: 'FLAMENGO',
        awayTeam: 'SÃO PAULO',
        score: '2-1',
        isHomeWinner: true,
        leg1Score: '1-0',
        leg1Status: MatchStatus.finalizado,
        leg2Score: '1-1',
        leg2Status: MatchStatus.finalizado,
        venue: 'ARENA MARACANÃ',
      ),
      CupMatchData(
        homeTeam: 'GRÊMIO',
        awayTeam: 'ATLÉTICO MG',
        score: '0-2',
        leg1Score: '0-2',
        leg1Status: MatchStatus.pendente,
        leg2Score: '-',
        leg2Status: MatchStatus.aIniciar,
        venue: 'ARENA DO GRÊMIO',
      ),
    ],
  ),
  KnockoutRoundData(
    label: 'SEMI',
    matches: [
      CupMatchData(
        homeTeam: 'FLAMENGO',
        awayTeam: 'ATLÉTICO MG',
        score: '',
        leg1Score: '-',
        leg1Status: MatchStatus.aIniciar,
        leg2Score: '-',
        leg2Status: MatchStatus.aIniciar,
        venue: 'A DEFINIR',
      ),
    ],
  ),
  KnockoutRoundData(
    label: 'FINAL',
    matches: [
      CupMatchData(
        homeTeam: 'A DEFINIR',
        awayTeam: 'A DEFINIR',
        score: '',
        leg1Score: '-',
        leg1Status: MatchStatus.aIniciar,
        leg2Score: '-',
        leg2Status: MatchStatus.aIniciar,
        venue: 'A DEFINIR',
      ),
    ],
  ),
];

// ─── EXISTING DATA ───────────────────────────────────────────────────────────

final _serieBTopStandings = [
  const FullStandingRowData(
    position: '1',
    club: 'VITÓRIA',
    points: '84',
    played: '38',
    victories: '25',
    draws: '9',
    defeats: '4',
    goalsFor: '78',
    goalsAgainst: '60',
    goalDiff: '+18',
    percent: '74%',
    highlight: true,
  ),
  FullStandingRowData(
    position: '2',
    club: 'FORTALEZA',
    points: '78',
    played: '38',
    victories: '23',
    draws: '9',
    defeats: '6',
    goalsFor: '72',
    goalsAgainst: '60',
    goalDiff: '+12',
    percent: '68%',
  ),
  FullStandingRowData(
    position: '3',
    club: 'CRUZEIRO',
    points: '75',
    played: '38',
    victories: '22',
    draws: '9',
    defeats: '7',
    goalsFor: '74',
    goalsAgainst: '64',
    goalDiff: '+10',
    percent: '66%',
  ),
  FullStandingRowData(
    position: '4',
    club: 'CUIABÁ',
    points: '70',
    played: '38',
    victories: '20',
    draws: '10',
    defeats: '8',
    goalsFor: '68',
    goalsAgainst: '62',
    goalDiff: '+6',
    percent: '61%',
  ),
  FullStandingRowData(
    position: '5',
    club: 'AMÉRICA-MG',
    points: '66',
    played: '38',
    victories: '19',
    draws: '9',
    defeats: '10',
    goalsFor: '70',
    goalsAgainst: '68',
    goalDiff: '+2',
    percent: '58%',
  ),
  FullStandingRowData(
    position: '6',
    club: 'CEARÁ',
    points: '62',
    played: '38',
    victories: '18',
    draws: '8',
    defeats: '12',
    goalsFor: '64',
    goalsAgainst: '65',
    goalDiff: '-1',
    percent: '54%',
  ),
];

final _copaTopStandings = [
  FullStandingRowData(
    position: '1',
    club: 'FLUMINENSE',
    points: '58',
    played: '12',
    victories: '18',
    draws: '5',
    defeats: '3',
    goalsFor: '52',
    goalsAgainst: '28',
    goalDiff: '+24',
    percent: '76%',
    highlight: true,
  ),
  FullStandingRowData(
    position: '2',
    club: 'ATLÉTICO-MG',
    points: '55',
    played: '12',
    victories: '17',
    draws: '4',
    defeats: '5',
    goalsFor: '48',
    goalsAgainst: '30',
    goalDiff: '+18',
    percent: '72%',
  ),
  FullStandingRowData(
    position: '3',
    club: 'CORINTHIANS',
    points: '52',
    played: '12',
    victories: '16',
    draws: '4',
    defeats: '6',
    goalsFor: '44',
    goalsAgainst: '28',
    goalDiff: '+16',
    percent: '68%',
  ),
];

final _serieBTopScorers = [
  TopScorerData(
    position: '2',
    name: 'LUCAS SILVA',
    club: 'FORTALEZA',
    goals: '21',
  ),
  TopScorerData(
    position: '3',
    name: 'FELIPE REIS',
    club: 'CRUZEIRO',
    goals: '19',
  ),
];

final _serieBMatches = [
  LeagueMatchData(
    homeTeam: 'VITÓRIA',
    awayTeam: 'FORTALEZA',
    score: '2-1',
    isHomeWinner: true,
    venue: 'BARRADÃO • RODADA 22',
    status: MatchStatus.finalizado,
  ),
  LeagueMatchData(
    homeTeam: 'CRUZEIRO',
    awayTeam: 'CUIABÁ',
    score: '2-1',
    isHomeWinner: true,
    venue: 'MINEIRÃO • RODADA 23',
    status: MatchStatus.pendente,
  ),
  LeagueMatchData(
    homeTeam: 'AMÉRICA-MG',
    awayTeam: 'CEARÁ',
    score: '?',
    venue: 'ARENA INDEPENDÊNCIA • RODADA 23',
    status: MatchStatus.aIniciar,
  ),
];

final _copaTopScorers = [
  TopScorerData(
    position: '1',
    name: 'GABRIEL MARTINS',
    club: 'FLUMINENSE',
    goals: '8',
  ),
  TopScorerData(
    position: '2',
    name: 'PAULO RICARDO',
    club: 'ATLÉTICO-MG',
    goals: '7',
  ),
  TopScorerData(
    position: '3',
    name: 'LUCAS NUNES',
    club: 'CORINTHIANS',
    goals: '6',
  ),
];

final _copaMatches = [
  CupMatchData(
    homeTeam: 'FLUMINENSE',
    awayTeam: 'ATLÉTICO-MG',
    score: '2-1',
    isHomeWinner: true,
    leg1Score: '1-0',
    leg1Status: MatchStatus.finalizado,
    leg2Score: '1-1',
    leg2Status: MatchStatus.finalizado,
    venue: 'MARACANÃ',
  ),
  CupMatchData(
    homeTeam: 'CORINTHIANS',
    awayTeam: 'SÃO PAULO',
    score: '3-1',
    isHomeWinner: true,
    leg1Score: '1-0',
    leg1Status: MatchStatus.finalizado,
    leg2Score: '2-1',
    leg2Status: MatchStatus.pendente,
    venue: 'ARENA CORINTHIANS',
  ),
  CupMatchData(
    homeTeam: 'PALMEIRAS',
    awayTeam: 'BOTAFOGO',
    score: '?',
    leg1Score: '-',
    leg1Status: MatchStatus.aIniciar,
    leg2Score: '-',
    leg2Status: MatchStatus.aIniciar,
    venue: 'ALLIANZ PARQUE',
  ),
];

final _leagueTopStandings = [
  FullStandingRowData(
    position: '1',
    club: 'APEX SC',
    points: '94',
    played: '38',
    victories: '28',
    draws: '6',
    defeats: '4',
    goalsFor: '90',
    goalsAgainst: '48',
    goalDiff: '+42',
    percent: '79%',
    highlight: true,
  ),
  FullStandingRowData(
    position: '2',
    club: 'PALMEIRAS',
    points: '78',
    played: '38',
    victories: '24',
    draws: '6',
    defeats: '8',
    goalsFor: '82',
    goalsAgainst: '54',
    goalDiff: '+28',
    percent: '68%',
  ),
  FullStandingRowData(
    position: '3',
    club: 'FLAMENGO',
    points: '75',
    played: '38',
    victories: '23',
    draws: '6',
    defeats: '9',
    goalsFor: '80',
    goalsAgainst: '55',
    goalDiff: '+25',
    percent: '66%',
  ),
  FullStandingRowData(
    position: '4',
    club: 'BOTAFOGO',
    points: '72',
    played: '38',
    victories: '20',
    draws: '12',
    defeats: '6',
    goalsFor: '73',
    goalsAgainst: '55',
    goalDiff: '+18',
    percent: '63%',
  ),
  FullStandingRowData(
    position: '5',
    club: 'ATLÉTICO-MG',
    points: '68',
    played: '38',
    victories: '19',
    draws: '11',
    defeats: '8',
    goalsFor: '70',
    goalsAgainst: '55',
    goalDiff: '+15',
    percent: '61%',
  ),
  FullStandingRowData(
    position: '6',
    club: 'GRÊMIO',
    points: '65',
    played: '38',
    victories: '18',
    draws: '11',
    defeats: '9',
    goalsFor: '68',
    goalsAgainst: '58',
    goalDiff: '+10',
    percent: '57%',
  ),
];

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

final _topScorers = [
  TopScorerData(
    position: '1',
    name: 'ERLING HAALAND',
    club: 'MAN CITY',
    goals: '28',
  ),
  TopScorerData(
    position: '2',
    name: 'KYLIAN MBAPPÉ',
    club: 'REAL MADRID',
    goals: '24',
  ),
  TopScorerData(
    position: '3',
    name: 'MARCUS ROSSI',
    club: 'APEX SC',
    goals: '21',
  ),
];

final _leagueMatches = [
  LeagueMatchData(
    homeTeam: 'MAN CITY',
    awayTeam: 'ARSENAL',
    score: '2-0',
    isHomeWinner: true,
    venue: 'ETIHAD STADIUM • RODADA 28',
    status: MatchStatus.finalizado,
  ),
  LeagueMatchData(
    homeTeam: 'LIVERPOOL',
    awayTeam: 'CHELSEA',
    score: '1-1',
    venue: 'ANFIELD • RODADA 28',
    status: MatchStatus.finalizado,
  ),
  LeagueMatchData(
    homeTeam: 'APEX SC',
    awayTeam: 'JUVENTUS',
    score: '3-1',
    isHomeWinner: true,
    venue: 'ARENA APEX • RODADA 29',
    status: MatchStatus.finalizado,
  ),
  LeagueMatchData(
    homeTeam: 'REAL MADRID',
    awayTeam: 'BARCELONA',
    score: '1-2',
    isAwayWinner: true,
    venue: 'BERNABÉU • RODADA 31',
    status: MatchStatus.pendente,
  ),
  LeagueMatchData(
    homeTeam: 'BAYERN',
    awayTeam: 'DORTMUND',
    score: '?',
    venue: 'ALLIANZ ARENA • RODADA 31',
    status: MatchStatus.aIniciar,
  ),
];

// ─── PAGE ────────────────────────────────────────────────────────────────────

class LeaguesPage extends StatefulWidget {
  const LeaguesPage({super.key});

  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  LeagueTab _activeTab = LeagueTab.classificacao;
  LeagueSeries _activeSeries = LeagueSeries.serieA;

  // Copa: track selected round for knockout view
  int _copaRoundIndex = 0;

  // Match filter for partidas tabs
  MatchStatus _matchFilter = MatchStatus.todos;

  List<FullStandingRowData> get _selectedStandings {
    switch (_activeSeries) {
      case LeagueSeries.serieA:
        return _leagueTopStandings;
      case LeagueSeries.serieB:
        return _serieBTopStandings;
      case LeagueSeries.copa:
        return _copaTopStandings;
    }
  }

  List<TopScorerData> get _selectedScorers {
    switch (_activeSeries) {
      case LeagueSeries.serieA:
        return _topScorers;
      case LeagueSeries.serieB:
        return _serieBTopScorers;
      case LeagueSeries.copa:
        return _copaTopScorers;
    }
  }

  List<LeagueMatchData> get _selectedMatches {
    switch (_activeSeries) {
      case LeagueSeries.serieA:
        return _leagueMatches;
      case LeagueSeries.serieB:
        return _serieBMatches;
      default:
        return [];
    }
  }

  String get _seriesTitle {
    switch (_activeSeries) {
      case LeagueSeries.serieA:
        return 'SÉRIE A';
      case LeagueSeries.serieB:
        return 'SÉRIE B';
      case LeagueSeries.copa:
        return 'COPA';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101314),
      appBar: AppBar(
        backgroundColor: const Color(0xFF101314),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'FC MANAGER',
          style: TextStyle(
            color: Color(0xFF00FF41),
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ),
      drawer: const AppDrawer(activeRoute: AppRoutes.leagues),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SeriesToggle(
                      activeSeries: _activeSeries,
                      onSeriesChanged: (series) => setState(() {
                        _activeSeries = series;
                        _copaRoundIndex = 0;
                        _matchFilter = MatchStatus.todos;
                        // reset to default tab for the selected series
                        _activeTab = series == LeagueSeries.copa
                            ? LeagueTab.copaMataMata
                            : LeagueTab.classificacao;
                      }),
                    ),
                    const SizedBox(height: 24),
                    // Copa has its own 3-tab bar: Mata-Mata, Artilheiros, Partidas
                    if (_activeSeries == LeagueSeries.copa)
                      _CopaTabBar(
                        activeTab: _activeTab,
                        onTabSelected: (tab) =>
                            setState(() => _activeTab = tab),
                      )
                    else
                      _LeagueTabBar(
                        activeTab: _activeTab,
                        onTabSelected: (tab) =>
                            setState(() => _activeTab = tab),
                      ),
                    const SizedBox(height: 24),
                    const _RegisterMatchButton(),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _seriesTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.emoji_events,
                          color: Color(0xFF00FF41),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTabContent(),
                  ],
                ),
              ),
            ),
            const AppBottomNavigation(activeRoute: AppRoutes.leagues),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    // ── Copa tabs ─────────────────────────────────────────────────────────────
    if (_activeSeries == LeagueSeries.copa) {
      switch (_activeTab) {
        case LeagueTab.copaMataMata:
          return _KnockoutView(
            rounds: _copaKnockoutRounds,
            selectedRoundIndex: _copaRoundIndex,
            onRoundChanged: (i) => setState(() => _copaRoundIndex = i),
          );
        case LeagueTab.copaArtilharia:
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _SectionTitle('ARTILHEIROS'),
              const SizedBox(height: 16),
              ..._copaTopScorers.map(
                (scorer) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _TopScorerTile(
                    position: scorer.position,
                    name: scorer.name,
                    club: scorer.club,
                    goals: scorer.goals,
                  ),
                ),
              ),
            ],
          );
        case LeagueTab.copaJogos:
          final copaFiltered = _matchFilter == MatchStatus.todos
              ? _copaMatches
              : _copaMatches.where((m) => m.status == _matchFilter).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _SectionTitle('PARTIDAS'),
              const SizedBox(height: 16),
              _MatchFilterBar(
                selected: _matchFilter,
                onChanged: (f) => setState(() => _matchFilter = f),
              ),
              const SizedBox(height: 16),
              if (copaFiltered.isEmpty)
                _EmptyMatchList()
              else
                ...copaFiltered.map(
                  (match) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _KnockoutMatchCard(match: match),
                  ),
                ),
            ],
          );
        default:
          return const SizedBox.shrink();
      }
    }

    // ── Série A / B tabs ──────────────────────────────────────────────────────
    switch (_activeTab) {
      case LeagueTab.classificacao:
        return Column(
          children: [
            FullStandingsTable(standings: _selectedStandings),
            const SizedBox(height: 18),
            _ViewCompleteTableButton(
              standings: _selectedStandings,
              seriesTitle: _seriesTitle,
            ),
          ],
        );
      case LeagueTab.artilharia:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SectionTitle('ARTILHEIROS'),
            const SizedBox(height: 16),
            ..._selectedScorers.map(
              (scorer) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _TopScorerTile(
                  position: scorer.position,
                  name: scorer.name,
                  club: scorer.club,
                  goals: scorer.goals,
                ),
              ),
            ),
          ],
        );
      case LeagueTab.jogos:
        final filtered = _matchFilter == MatchStatus.todos
            ? _selectedMatches
            : _selectedMatches.where((m) => m.status == _matchFilter).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SectionTitle('PARTIDAS'),
            const SizedBox(height: 16),
            _MatchFilterBar(
              selected: _matchFilter,
              onChanged: (f) => setState(() => _matchFilter = f),
            ),
            const SizedBox(height: 16),
            if (filtered.isEmpty)
              _EmptyMatchList()
            else
              ...filtered.map(
                (match) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _LeagueMatchCard(match: match),
                ),
              ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

// ─── MATCH FILTER BAR ────────────────────────────────────────────────────────

class _MatchFilterBar extends StatelessWidget {
  final MatchStatus selected;
  final ValueChanged<MatchStatus> onChanged;

  const _MatchFilterBar({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(
            label: 'TODOS',
            selected: selected == MatchStatus.todos,
            onTap: () => onChanged(MatchStatus.todos),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'FINALIZADO',
            selected: selected == MatchStatus.finalizado,
            color: const Color(0xFF00FF41),
            onTap: () => onChanged(MatchStatus.finalizado),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'PENDENTE',
            selected: selected == MatchStatus.pendente,
            color: const Color(0xFFE0A86B),
            onTap: () => onChanged(MatchStatus.pendente),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'A INICIAR',
            selected: selected == MatchStatus.aIniciar,
            color: const Color(0xFF6B9EFF),
            onTap: () => onChanged(MatchStatus.aIniciar),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    this.color = Colors.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.14)
              : const Color(0xFF16191D),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? color : const Color(0xFF2A2F33),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: selected ? color : const Color(0xFF7C8579),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyMatchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      alignment: Alignment.center,
      child: const Column(
        children: [
          Icon(Icons.sports_soccer, color: Color(0xFF2A2F33), size: 40),
          SizedBox(height: 12),
          Text(
            'NENHUMA PARTIDA ENCONTRADA',
            style: TextStyle(
              color: Color(0xFF4A5047),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── KNOCKOUT VIEW ───────────────────────────────────────────────────────────

class _KnockoutView extends StatelessWidget {
  final List<KnockoutRoundData> rounds;
  final int selectedRoundIndex;
  final ValueChanged<int> onRoundChanged;

  const _KnockoutView({
    required this.rounds,
    required this.selectedRoundIndex,
    required this.onRoundChanged,
  });

  @override
  Widget build(BuildContext context) {
    final round = rounds[selectedRoundIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Round selector tabs
        _KnockoutRoundSelector(
          rounds: rounds,
          selectedIndex: selectedRoundIndex,
          onChanged: onRoundChanged,
        ),
        const SizedBox(height: 20),
        // Match cards for selected round
        ...round.matches.map(
          (match) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _KnockoutMatchCard(match: match),
          ),
        ),
      ],
    );
  }
}

class _KnockoutRoundSelector extends StatelessWidget {
  final List<KnockoutRoundData> rounds;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _KnockoutRoundSelector({
    required this.rounds,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(rounds.length, (i) {
        final selected = i == selectedIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(i),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  rounds[i].label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selected
                        ? const Color(0xFF00FF41)
                        : const Color(0xFF7C8579),
                    fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
                    fontSize: 11,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF00FF41)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// ─── LEAGUE MATCH CARD (Série A/B — jogo único, sem ida/volta) ───────────────

class _LeagueMatchCard extends StatelessWidget {
  final LeagueMatchData match;

  const _LeagueMatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      child: Column(
        children: [
          // Teams + score
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Row(
              children: [
                // Home
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TeamShieldIcon(highlighted: match.isHomeWinner),
                      const SizedBox(height: 10),
                      Text(
                        match.homeTeam,
                        style: TextStyle(
                          color: match.isHomeWinner
                              ? const Color(0xFF00FF41)
                              : Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                // Score badge
                _ScoreBadge(score: match.score, status: match.status),
                // Away
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: _TeamShieldIcon(highlighted: match.isAwayWinner),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        match.awayTeam,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: match.isAwayWinner
                              ? const Color(0xFF00FF41)
                              : Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Divider
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 18),
            color: const Color(0xFF1F2327),
          ),
          // Venue + pending warning
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              children: [
                Text(
                  match.venue,
                  style: const TextStyle(
                    color: Color(0xFF4A5047),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
                if (match.status == MatchStatus.pendente) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0A86B).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFE0A86B).withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.schedule,
                          color: Color(0xFFE0A86B),
                          size: 11,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'RESULTADO NÃO REFLETE NA CLASSIFICAÇÃO',
                          style: TextStyle(
                            color: Color(0xFFE0A86B),
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KnockoutMatchCard extends StatelessWidget {
  final CupMatchData match;

  const _KnockoutMatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      child: Column(
        children: [
          // Teams + score row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Row(
              children: [
                // Home team
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _TeamShieldIcon(highlighted: match.isHomeWinner),
                      const SizedBox(height: 10),
                      Text(
                        match.homeTeam,
                        style: TextStyle(
                          color: match.isHomeWinner
                              ? const Color(0xFF00FF41)
                              : Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                // Score badge (agregado — derivado de ida+volta)
                _AggregateBadge(
                  score: match.score,
                  leg1Status: match.leg1Status,
                  leg2Status: match.leg2Status,
                ),
                // Away team
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: _TeamShieldIcon(highlighted: match.isAwayWinner),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        match.awayTeam,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: match.isAwayWinner
                              ? const Color(0xFF00FF41)
                              : Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Divider
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 18),
            color: const Color(0xFF1F2327),
          ),
          // Legs + venue
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _LegChip(
                      label: 'IDA',
                      score: match.leg1Score,
                      status: match.leg1Status,
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 1,
                      height: 32,
                      color: const Color(0xFF2A2F33),
                    ),
                    const SizedBox(width: 12),
                    _LegChip(
                      label: 'VOLTA',
                      score: match.leg2Score,
                      status: match.leg2Status,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  match.venue,
                  style: const TextStyle(
                    color: Color(0xFF4A5047),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
                if (match.status == MatchStatus.pendente) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0A86B).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFE0A86B).withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.schedule,
                          color: Color(0xFFE0A86B),
                          size: 11,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'RESULTADO NÃO REFLETE NA CLASSIFICAÇÃO',
                          style: TextStyle(
                            color: Color(0xFFE0A86B),
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegChip extends StatelessWidget {
  final String label;
  final String score;
  final MatchStatus status;

  const _LegChip({
    required this.label,
    required this.score,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final Color accentColor;
    final String statusLabel;

    switch (status) {
      case MatchStatus.finalizado:
        accentColor = const Color(0xFF00FF41);
        statusLabel = 'FINALIZADO';
        break;
      case MatchStatus.pendente:
        accentColor = const Color(0xFFE0A86B);
        statusLabel = 'PENDENTE';
        break;
      case MatchStatus.aIniciar:
        accentColor = const Color(0xFF6B9EFF);
        statusLabel = 'A INICIAR';
        break;
      case MatchStatus.todos:
        accentColor = const Color(0xFF4A5047);
        statusLabel = '';
        break;
    }

    final hasScore = score.isNotEmpty && score != '-';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label IDA / VOLTA
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF4A5047),
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: 6),
        // Score
        Text(
          hasScore ? score : '-',
          style: TextStyle(
            color: hasScore ? Colors.white : const Color(0xFF2A2F33),
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 6),
        // Status badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: accentColor.withValues(alpha: 0.30)),
          ),
          child: Text(
            statusLabel,
            style: TextStyle(
              color: accentColor,
              fontSize: 8,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}

class _TeamShieldIcon extends StatelessWidget {
  final bool highlighted;

  const _TeamShieldIcon({this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF101314),
        shape: BoxShape.circle,
        border: Border.all(
          color: highlighted
              ? const Color(0xFF00FF41)
              : const Color(0xFF2A2F33),
          width: highlighted ? 2 : 1,
        ),
      ),
      child: Icon(
        Icons.shield,
        color: highlighted ? const Color(0xFF00FF41) : const Color(0xFF4A5047),
        size: 22,
      ),
    );
  }
}

class _AggregateBadge extends StatelessWidget {
  final String score;
  final MatchStatus leg1Status;
  final MatchStatus leg2Status;

  const _AggregateBadge({
    required this.score,
    required this.leg1Status,
    required this.leg2Status,
  });

  @override
  Widget build(BuildContext context) {
    // Derive aggregate label from individual leg statuses:
    // both finalizado → FINAL
    // both aIniciar   → '' (vazio)
    // anything else   → PARCIAL
    final bothFinal =
        leg1Status == MatchStatus.finalizado &&
        leg2Status == MatchStatus.finalizado;
    final noneStarted =
        leg1Status == MatchStatus.aIniciar &&
        leg2Status == MatchStatus.aIniciar;

    final String label = bothFinal
        ? 'FINAL'
        : noneStarted
        ? ''
        : 'PARCIAL';
    final Color accentColor = bothFinal
        ? const Color(0xFF00FF41)
        : noneStarted
        ? const Color(0xFF4A5047)
        : const Color(0xFFE0A86B);
    final Color bgColor = bothFinal
        ? const Color(0xFF0A1A0E)
        : noneStarted
        ? const Color(0xFF1A1E22)
        : const Color(0xFF1E1608);
    final Color borderColor = bothFinal
        ? const Color(0xFF00FF41).withValues(alpha: 0.35)
        : noneStarted
        ? const Color(0xFF2A2F33)
        : const Color(0xFFE0A86B).withValues(alpha: 0.35);

    final hasScore = !noneStarted;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            hasScore ? score : '?',
            style: TextStyle(
              color: hasScore ? accentColor : const Color(0xFF4A5047),
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: accentColor,
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  final String score;
  final MatchStatus status;

  const _ScoreBadge({required this.score, required this.status});

  @override
  Widget build(BuildContext context) {
    // Visual config per status
    final Color accentColor;
    final Color bgColor;
    final Color borderColor;
    final String label;

    switch (status) {
      case MatchStatus.finalizado:
        accentColor = const Color(0xFF00FF41);
        bgColor = const Color(0xFF0A1A0E);
        borderColor = const Color(0xFF00FF41).withValues(alpha: 0.35);
        label = 'FINALIZADA';
        break;
      case MatchStatus.pendente:
        accentColor = const Color(0xFFE0A86B);
        bgColor = const Color(0xFF1E1608);
        borderColor = const Color(0xFFE0A86B).withValues(alpha: 0.35);
        label = 'PENDENTE';
        break;
      case MatchStatus.aIniciar:
        accentColor = const Color(0xFF6B9EFF);
        bgColor = const Color(0xFF0A0F1E);
        borderColor = const Color(0xFF6B9EFF).withValues(alpha: 0.35);
        label = 'A INICIAR';
        break;
      case MatchStatus.todos:
        accentColor = const Color(0xFF4A5047);
        bgColor = const Color(0xFF1A1E22);
        borderColor = const Color(0xFF2A2F33);
        label = '';
        break;
    }

    final hasScore =
        status == MatchStatus.finalizado || status == MatchStatus.pendente;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            hasScore ? score : '?',
            style: TextStyle(
              color: hasScore ? accentColor : const Color(0xFF4A5047),
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: accentColor,
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── SHARED WIDGETS ──────────────────────────────────────────────────────────

// ─── COPA TAB BAR (Mata-Mata • Artilheiros • Partidas) ────────────────────────

class _CopaTabBar extends StatelessWidget {
  final LeagueTab activeTab;
  final ValueChanged<LeagueTab> onTabSelected;

  const _CopaTabBar({required this.activeTab, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _LeagueTabButton(
          label: 'MATA-MATA',
          selected: activeTab == LeagueTab.copaMataMata,
          onTap: () => onTabSelected(LeagueTab.copaMataMata),
        ),
        const SizedBox(width: 24),
        _LeagueTabButton(
          label: 'ARTILHEIROS',
          selected: activeTab == LeagueTab.copaArtilharia,
          onTap: () => onTabSelected(LeagueTab.copaArtilharia),
        ),
        const SizedBox(width: 24),
        _LeagueTabButton(
          label: 'PARTIDAS',
          selected: activeTab == LeagueTab.copaJogos,
          onTap: () => onTabSelected(LeagueTab.copaJogos),
        ),
      ],
    );
  }
}

// ─── SÉRIE A/B TAB BAR ────────────────────────────────────────────────────────

class _LeagueTabBar extends StatelessWidget {
  final LeagueTab activeTab;
  final ValueChanged<LeagueTab> onTabSelected;

  const _LeagueTabBar({required this.activeTab, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _LeagueTabButton(
          label: 'CLASSIFICAÇÃO',
          selected: activeTab == LeagueTab.classificacao,
          onTap: () => onTabSelected(LeagueTab.classificacao),
        ),
        const SizedBox(width: 28),
        _LeagueTabButton(
          label: 'ARTILHARIA',
          selected: activeTab == LeagueTab.artilharia,
          onTap: () => onTabSelected(LeagueTab.artilharia),
        ),
        const SizedBox(width: 28),
        _LeagueTabButton(
          label: 'PARTIDAS',
          selected: activeTab == LeagueTab.jogos,
          onTap: () => onTabSelected(LeagueTab.jogos),
        ),
      ],
    );
  }
}

class _LeagueTabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LeagueTabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: selected
                  ? const Color(0xFF00FF41)
                  : const Color(0xFF7C8579),
              fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
              fontSize: 12,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 2,
            width: 80,
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF00FF41) : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

class _SeriesToggle extends StatelessWidget {
  final LeagueSeries activeSeries;
  final ValueChanged<LeagueSeries> onSeriesChanged;

  const _SeriesToggle({
    required this.activeSeries,
    required this.onSeriesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          _buildSeriesButton(
            label: 'SÉRIE A',
            selected: activeSeries == LeagueSeries.serieA,
            onTap: () => onSeriesChanged(LeagueSeries.serieA),
          ),
          const SizedBox(width: 8),
          _buildSeriesButton(
            label: 'SÉRIE B',
            selected: activeSeries == LeagueSeries.serieB,
            onTap: () => onSeriesChanged(LeagueSeries.serieB),
          ),
          const SizedBox(width: 8),
          _buildSeriesButton(
            label: 'COPA',
            selected: activeSeries == LeagueSeries.copa,
            onTap: () => onSeriesChanged(LeagueSeries.copa),
          ),
        ],
      ),
    );
  }

  Widget _buildSeriesButton({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF00FF41) : const Color(0xFF131618),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? Colors.black : Colors.white,
              fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterMatchButton extends StatelessWidget {
  const _RegisterMatchButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.of(context).pushNamed('/register-match'),
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text(
          'REGISTRAR PARTIDA',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00FF41),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _ViewCompleteTableButton extends StatelessWidget {
  final String seriesTitle;
  final List<FullStandingRowData> standings;

  const _ViewCompleteTableButton({
    required this.seriesTitle,
    required this.standings,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => FullStandingsPage(
                seriesTitle: seriesTitle,
                standings: standings,
              ),
            ),
          );
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color(0xFF0A1A0E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'VER TABELA COMPLETA',
          style: TextStyle(
            color: Color(0xFF00FF41),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _TopScorerTile extends StatelessWidget {
  final String position;
  final String name;
  final String club;
  final String goals;

  const _TopScorerTile({
    required this.position,
    required this.name,
    required this.club,
    required this.goals,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF00FF41)),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0C120C), Color(0xFF101314)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Text(
                position,
                style: const TextStyle(
                  color: Color(0xFF00FF41),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  club,
                  style: const TextStyle(
                    color: Color(0xFF7C8579),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Text(
            goals,
            style: const TextStyle(
              color: Color(0xFF00FF41),
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
