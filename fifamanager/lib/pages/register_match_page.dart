import 'package:flutter/material.dart';

class RegisterMatchPage extends StatefulWidget {
  const RegisterMatchPage({super.key});

  @override
  State<RegisterMatchPage> createState() => _RegisterMatchPageState();
}

class _RegisterMatchPageState extends State<RegisterMatchPage> {
  int _homeScore = 3;
  int _awayScore = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101314),
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
                      homeTeam: 'APEX WARRIORS',
                      awayTeam: 'SELECIONAR',
                      onHomeTap: () {},
                      onAwayTap: () {},
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
                    const _GoalsSection(title: 'MARCADORES (CASA)'),
                    const _GoalRow(
                      playerNumber: '10',
                      playerName: 'GABRIEL JESUS',
                      playerRole: 'ATACANTE',
                      goalCount: 2,
                      isOwnGoal: false,
                    ),
                    const _GoalRow(
                      playerNumber: '08',
                      playerName: 'K. DE BRUYNE',
                      playerRole: 'MEIO-CAMPO',
                      goalCount: 1,
                      isOwnGoal: false,
                    ),
                    const SizedBox(height: 22),
                    const _GoalsSection(title: 'MARCADORES (FORA)'),
                    const _GoalRow(
                      playerNumber: '04',
                      playerName: 'ZAGUEIRO (GOL CONTRA)',
                      playerRole: 'APEX WARRIORS FC',
                      goalCount: 1,
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
                        child: const Text(
                          'DESCARTAR RASCUNHO',
                          style: TextStyle(
                            color: Color(0xFF7C8579),
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
            icon: const Icon(Icons.arrow_back, color: Colors.white),
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
      children: const [
        Text(
          'REGISTRAR NOVA PARTIDA',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF00FF41),
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'TEMPORADA 2024 • LIGA PRO',
          style: TextStyle(
            color: Color(0xFF7C8579),
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
  final VoidCallback onHomeTap;
  final VoidCallback onAwayTap;

  const _TeamSelectionCard({
    required this.homeTeam,
    required this.awayTeam,
    required this.onHomeTap,
    required this.onAwayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: Text(
                  'MANDANTE',
                  style: TextStyle(
                    color: Color(0xFF00FF41),
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
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TeamCard(
                label: homeTeam,
                icon: Icons.shield,
                highlight: true,
                onTap: onHomeTap,
              ),
              const Text(
                'VS',
                style: TextStyle(
                  color: Color(0xFF7C8579),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              _TeamCard(
                label: awayTeam,
                icon: Icons.search,
                highlight: false,
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
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF121417),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: highlight
                  ? const Color(0xFF00FF41)
                  : const Color(0xFF1F2327),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFF101314),
                child: Icon(
                  icon,
                  color: highlight ? const Color(0xFF00FF41) : Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: highlight ? Colors.white : const Color(0xFF7C8579),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ScoreButton(icon: Icons.remove, onTap: onHomeDecrement),
          _ScoreValue(value: homeScore),
          _ScoreButton(icon: Icons.add, onTap: onHomeIncrement),
          const SizedBox(width: 14),
          const Text(
            '-',
            style: TextStyle(
              color: Color(0xFF7C8579),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFF101314),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF1F2327)),
        ),
        child: Icon(icon, color: const Color(0xFF7C8579), size: 22),
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
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class _GoalsSection extends StatelessWidget {
  final String title;

  const _GoalsSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF101314),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF00FF41)),
          ),
          child: const Text(
            '+ JOGADOR',
            style: TextStyle(
              color: Color(0xFF00FF41),
              fontSize: 12,
              fontWeight: FontWeight.w700,
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

  const _GoalRow({
    required this.playerNumber,
    required this.playerName,
    required this.playerRole,
    required this.goalCount,
    required this.isOwnGoal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF101314),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              playerNumber,
              style: const TextStyle(
                color: Color(0xFF00FF41),
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  playerRole,
                  style: const TextStyle(
                    color: Color(0xFF7C8579),
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
                  color: isOwnGoal
                      ? const Color(0xFF321B1B)
                      : const Color(0xFF0A1A0E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'x$goalCount',
                  style: TextStyle(
                    color: isOwnGoal
                        ? const Color(0xFFFF6B6B)
                        : const Color(0xFF00FF41),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.delete_outline, color: const Color(0xFF7C8579)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ActionButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00FF41),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: const Text(
          'FINALIZAR REGISTRO',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
