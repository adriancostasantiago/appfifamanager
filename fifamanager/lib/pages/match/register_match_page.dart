import 'package:fifamanager/models/club.dart';
import 'package:fifamanager/models/models.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/core/theme/app_theme.dart';
import 'club_selection_page.dart';
import 'goal_scorer_selection_page.dart';

class RegisterMatchPage extends StatefulWidget {
  const RegisterMatchPage({super.key});

  @override
  State<RegisterMatchPage> createState() => _RegisterMatchPageState();
}

class _RegisterMatchPageState extends State<RegisterMatchPage> {
  int _homeScore = 3;
  int _awayScore = 1;
  String _awayTeam = 'SELECIONAR';
  bool _isSwapped = false;

  // Marcadores registrados
  final List<GoalScorerResult> _homeGoals = [];
  final List<GoalScorerResult> _awayGoals = [];

  // Jogadores mock — substitua pela fonte real (provider/bloc)
  final List<PlayerData> _myPlayers = [
    PlayerData(
      name: 'Gabriel Jesus',
      position: 'ATK',
      country: 'Brasil',
      ovr: 84,
      contractUntil: 2026,
      photo: '',
    ),
    PlayerData(
      name: 'K. De Bruyne',
      position: 'MID',
      country: 'Bélgica',
      ovr: 91,
      contractUntil: 2025,
      photo: '',
    ),
    PlayerData(
      name: 'Zagueiro Silva',
      position: 'DEF',
      country: 'Brasil',
      ovr: 78,
      contractUntil: 2027,
      photo: '',
    ),
    PlayerData(
      name: 'Goleiro Ramos',
      position: 'GK',
      country: 'Brasil',
      ovr: 80,
      contractUntil: 2026,
      photo: '',
    ),
  ];

  void _swapTeams() {
    setState(() {
      _isSwapped = !_isSwapped;
      // Também troca os placares
      final tempScore = _homeScore;
      _homeScore = _awayScore;
      _awayScore = tempScore;
    });
  }

  // Substitua pela sua fonte de dados real (provider, bloc, etc.)
  final List<Club> _clubs = const [
    Club(name: 'Rio Verde FC', league: 'Série A', country: 'Brasil', ovr: 84),
    Club(
      name: 'Atlético Aurora',
      league: 'Série A',
      country: 'Brasil',
      ovr: 82,
    ),
    Club(name: 'União Capital', league: 'Série B', country: 'Brasil', ovr: 77),
    Club(name: 'Vale do Sol', league: 'Série B', country: 'Brasil', ovr: 75),
    Club(
      name: 'Northchester United',
      league: 'Premier League',
      country: 'Inglaterra',
      ovr: 88,
    ),
    Club(
      name: 'Kingsbridge FC',
      league: 'Premier League',
      country: 'Inglaterra',
      ovr: 85,
    ),
    Club(
      name: 'London Eagles',
      league: 'Championship',
      country: 'Inglaterra',
      ovr: 79,
    ),
    Club(name: 'Madrid Stars', league: 'La Liga', country: 'Espanha', ovr: 90),
    Club(
      name: 'Catalonia Athletic',
      league: 'La Liga',
      country: 'Espanha',
      ovr: 87,
    ),
    Club(
      name: 'Sevilla Warriors',
      league: 'La Liga',
      country: 'Espanha',
      ovr: 81,
    ),
    Club(name: 'Milano FC', league: 'Serie A', country: 'Itália', ovr: 89),
    Club(name: 'Torino Legends', league: 'Serie A', country: 'Itália', ovr: 84),
    Club(name: 'Roma Imperiale', league: 'Serie A', country: 'Itália', ovr: 83),
    Club(
      name: 'Bayernstadt',
      league: 'Bundesliga',
      country: 'Alemanha',
      ovr: 91,
    ),
    Club(name: 'Dortheim', league: 'Bundesliga', country: 'Alemanha', ovr: 86),
    Club(
      name: 'Hamburg Lions',
      league: 'Bundesliga',
      country: 'Alemanha',
      ovr: 80,
    ),
    Club(name: 'Paris Étoile', league: 'Ligue 1', country: 'França', ovr: 92),
    Club(
      name: 'Olympique Riviera',
      league: 'Ligue 1',
      country: 'França',
      ovr: 84,
    ),
    Club(name: 'Monaco Royals', league: 'Ligue 1', country: 'França', ovr: 82),
    Club(
      name: 'Amsterdam City',
      league: 'Eredivisie',
      country: 'Holanda',
      ovr: 83,
    ),
    Club(
      name: 'Rotterdam FC',
      league: 'Eredivisie',
      country: 'Holanda',
      ovr: 80,
    ),
    Club(
      name: 'Lisboa United',
      league: 'Primeira Liga',
      country: 'Portugal',
      ovr: 85,
    ),
    Club(
      name: 'Porto Azul',
      league: 'Primeira Liga',
      country: 'Portugal',
      ovr: 82,
    ),
    Club(
      name: 'Andes FC',
      league: 'Primera División',
      country: 'Argentina',
      ovr: 81,
    ),
    Club(
      name: 'Buenos Aires Athletic',
      league: 'Primera División',
      country: 'Argentina',
      ovr: 84,
    ),
    Club(
      name: 'Montevideo Stars',
      league: 'Primera División',
      country: 'Uruguai',
      ovr: 78,
    ),
    Club(
      name: 'Santiago Warriors',
      league: 'Primera División',
      country: 'Chile',
      ovr: 79,
    ),
    Club(name: 'Tokyo Dragons', league: 'J1 League', country: 'Japão', ovr: 80),
    Club(name: 'Osaka Phoenix', league: 'J1 League', country: 'Japão', ovr: 78),
    Club(
      name: 'Seoul Tigers',
      league: 'K League 1',
      country: 'Coreia do Sul',
      ovr: 81,
    ),
  ];

  void _openClubSelection() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClubSelectionPage(
          clubs: _clubs,
          onClubSelected: (club) {
            setState(() => _awayTeam = club.name);
          },
        ),
      ),
    );
  }

  void _openGoalScorerSelection({required bool forHomeSection}) {
    final homeTeamName = _isSwapped ? _awayTeam : 'APEX WARRIORS';
    final awayTeamName = _isSwapped ? 'APEX WARRIORS' : _awayTeam;

    const List<PlayerData> awayPlayers = [];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GoalScorerSelectionPage(
          homePlayers: _myPlayers,
          awayPlayers: awayPlayers,
          homeTeamName: homeTeamName,
          awayTeamName: awayTeamName,
          // Abre já na aba correspondente à seção que chamou
          initialShowingHome: forHomeSection,
          onScorerSelected: (result) {
            setState(() {
              // Se a seção que chamou é CASA:
              //   - jogador da casa  → gol normal   → _homeGoals (isOwnGoal=false)
              //   - jogador visitante → gol contra  → _homeGoals (isOwnGoal=true)
              // Se a seção que chamou é VISITANTE:
              //   - jogador visitante → gol normal  → _awayGoals (isOwnGoal=false)
              //   - jogador da casa   → gol contra  → _awayGoals (isOwnGoal=true)
              // Em ambos os casos o gol entra na lista da seção que originou a chamada.
              if (forHomeSection) {
                _homeGoals.add(result);
              } else {
                _awayGoals.add(result);
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Column(
          children: [
            _RegisterMatchHeader(onBack: () => Navigator.of(context).pop()),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _RegisterMatchTitle(),
                    const SizedBox(height: 24),
                    _TeamSelectionCard(
                      homeTeam: _isSwapped ? _awayTeam : 'APEX WARRIORS',
                      awayTeam: _isSwapped ? 'APEX WARRIORS' : _awayTeam,
                      isSwapped: _isSwapped,
                      onHomeTap: _isSwapped ? _openClubSelection : () {},
                      onAwayTap: _isSwapped ? () {} : _openClubSelection,
                      onSwap: _swapTeams,
                    ),
                    const SizedBox(height: 22),
                    _ScoreControls(
                      homeScore: _homeScore,
                      awayScore: _awayScore,
                      onHomeIncrement: () => setState(() => _homeScore++),
                      onHomeDecrement: () => setState(
                        () => _homeScore = (_homeScore - 1).clamp(0, 99),
                      ),
                      onAwayIncrement: () => setState(() => _awayScore++),
                      onAwayDecrement: () => setState(
                        () => _awayScore = (_awayScore - 1).clamp(0, 99),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _GoalsSection(
                      title: 'MARCADORES (CASA)',
                      onAddTap: () =>
                          _openGoalScorerSelection(forHomeSection: true),
                    ),
                    ..._homeGoals.asMap().entries.map((entry) {
                      final i = entry.key;
                      final g = entry.value;
                      return _GoalRow(
                        playerNumber: '${i + 1}',
                        playerName: g.player.name,
                        playerRole: g.isOwnGoal
                            ? '${g.player.position} • GOL CONTRA'
                            : g.player.position,
                        goalCount: g.goalCount,
                        isOwnGoal: g.isOwnGoal,
                        onDelete: () => setState(() => _homeGoals.removeAt(i)),
                      );
                    }),
                    if (_homeGoals.isEmpty)
                      _EmptyGoalHint(
                        onTap: () =>
                            _openGoalScorerSelection(forHomeSection: true),
                      ),
                    const SizedBox(height: 22),
                    _GoalsSection(
                      title: 'MARCADORES (FORA)',
                      onAddTap: () =>
                          _openGoalScorerSelection(forHomeSection: false),
                    ),
                    ..._awayGoals.asMap().entries.map((entry) {
                      final i = entry.key;
                      final g = entry.value;
                      return _GoalRow(
                        playerNumber: '${i + 1}',
                        playerName: g.player.name,
                        playerRole: g.isOwnGoal
                            ? '${g.player.position} • GOL CONTRA'
                            : g.player.position,
                        goalCount: g.goalCount,
                        isOwnGoal: g.isOwnGoal,
                        onDelete: () => setState(() => _awayGoals.removeAt(i)),
                      );
                    }),
                    if (_awayGoals.isEmpty)
                      _EmptyGoalHint(
                        onTap: () =>
                            _openGoalScorerSelection(forHomeSection: false),
                        isOwnGoal: true,
                      ),
                    const SizedBox(height: 24),
                    _ActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(height: 18),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'DESCARTAR RASCUNHO',
                          style: TextStyle(
                            color: context.colors.muted,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisterMatchHeader extends StatelessWidget {
  final VoidCallback onBack;

  const _RegisterMatchHeader({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 6),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: Icon(Icons.arrow_back, color: context.colors.textPrimary),
          ),
        ],
      ),
    );
  }
}

class _RegisterMatchTitle extends StatelessWidget {
  const _RegisterMatchTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'REGISTRAR NOVA PARTIDA',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.colors.accent,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'TEMPORADA 2024 • LIGA PRO',
          style: TextStyle(
            color: context.colors.muted,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}

class _TeamSelectionCard extends StatelessWidget {
  final String homeTeam;
  final String awayTeam;
  final bool isSwapped;
  final VoidCallback onHomeTap;
  final VoidCallback onAwayTap;
  final VoidCallback onSwap;

  const _TeamSelectionCard({
    required this.homeTeam,
    required this.awayTeam,
    required this.isSwapped,
    required this.onHomeTap,
    required this.onAwayTap,
    required this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
        boxShadow: colors.cardShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'MANDANTE',
                  style: TextStyle(
                    color: isSwapped ? colors.textPrimary : colors.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'VISITANTE',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: isSwapped ? colors.accent : colors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Botão de troca acima do VS
          GestureDetector(
            onTap: onSwap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: colors.accentBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colors.accent.withValues(alpha: 0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.swap_horiz, color: colors.accent, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'TROCAR MANDANTE',
                    style: TextStyle(
                      color: colors.accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TeamCard(
                label: homeTeam,
                icon: isSwapped ? Icons.search : Icons.shield,
                highlight: !isSwapped,
                onTap: onHomeTap,
              ),
              Text(
                'VS',
                style: TextStyle(
                  color: colors.muted,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              _TeamCard(
                label: awayTeam,
                icon: isSwapped ? Icons.shield : Icons.search,
                highlight: isSwapped,
                onTap: onAwayTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TeamCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool highlight;
  final VoidCallback onTap;

  const _TeamCard({
    required this.label,
    required this.icon,
    required this.highlight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: colors.cardDark,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: highlight ? colors.accent : colors.border,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: colors.background,
                child: Icon(
                  icon,
                  color: highlight ? colors.accent : colors.textPrimary,
                  size: 28,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: highlight ? colors.textPrimary : colors.muted,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScoreControls extends StatelessWidget {
  final int homeScore;
  final int awayScore;
  final VoidCallback onHomeIncrement;
  final VoidCallback onHomeDecrement;
  final VoidCallback onAwayIncrement;
  final VoidCallback onAwayDecrement;

  const _ScoreControls({
    required this.homeScore,
    required this.awayScore,
    required this.onHomeIncrement,
    required this.onHomeDecrement,
    required this.onAwayIncrement,
    required this.onAwayDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
        boxShadow: colors.cardShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ScoreButton(icon: Icons.remove, onTap: onHomeDecrement),
          _ScoreValue(value: homeScore),
          _ScoreButton(icon: Icons.add, onTap: onHomeIncrement),
          const SizedBox(width: 14),
          Text(
            '-',
            style: TextStyle(
              color: colors.muted,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 14),
          _ScoreButton(icon: Icons.add, onTap: onAwayIncrement),
          _ScoreValue(value: awayScore),
          _ScoreButton(icon: Icons.remove, onTap: onAwayDecrement),
        ],
      ),
    );
  }
}

class _ScoreButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ScoreButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.border),
        ),
        child: Icon(icon, color: colors.muted, size: 22),
      ),
    );
  }
}

class _ScoreValue extends StatelessWidget {
  final int value;

  const _ScoreValue({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$value',
      style: TextStyle(
        color: context.colors.textPrimary,
        fontSize: 28,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _GoalsSection extends StatelessWidget {
  final String title;
  final VoidCallback onAddTap;

  const _GoalsSection({required this.title, required this.onAddTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ),
        GestureDetector(
          onTap: onAddTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            decoration: BoxDecoration(
              color: colors.accentBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colors.accent),
            ),
            child: Text(
              '+ JOGADOR',
              style: TextStyle(
                color: colors.accent,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _GoalRow extends StatelessWidget {
  final String playerNumber;
  final String playerName;
  final String playerRole;
  final int goalCount;
  final bool isOwnGoal;
  final VoidCallback onDelete;

  const _GoalRow({
    required this.playerNumber,
    required this.playerName,
    required this.playerRole,
    required this.goalCount,
    required this.isOwnGoal,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
        boxShadow: colors.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              playerNumber,
              style: TextStyle(
                color: colors.accent,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  playerName,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  playerRole,
                  style: TextStyle(
                    color: colors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isOwnGoal ? colors.redBg : colors.accentBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'x$goalCount',
                  style: TextStyle(
                    color: isOwnGoal ? colors.red : colors.accent,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onDelete,
                child: Icon(Icons.delete_outline, color: colors.muted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyGoalHint extends StatelessWidget {
  final VoidCallback onTap;
  final bool isOwnGoal;

  const _EmptyGoalHint({required this.onTap, this.isOwnGoal = false});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: (isOwnGoal ? colors.red : colors.accent).withValues(
              alpha: 0.25,
            ),
            style: BorderStyle.solid,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 16,
              color: isOwnGoal ? colors.red : colors.accent,
            ),
            const SizedBox(width: 8),
            Text(
              isOwnGoal ? 'Adicionar gol contra' : 'Adicionar marcador',
              style: TextStyle(
                color: isOwnGoal ? colors.red : colors.accent,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ActionButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.accent,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          'FINALIZAR REGISTRO',
          style: TextStyle(
            color: colors.onAccent,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
