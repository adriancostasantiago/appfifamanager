import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';
import 'package:fifamanager/widgets/app_bottom_navigation.dart';
import 'package:fifamanager/widgets/app_drawer.dart';
import 'package:fifamanager/widgets/standings_table.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      drawer: const AppDrawer(activeRoute: AppRoutes.home),
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: colors.textPrimary),
        title: Text(
          'FC MANAGER',
          style: TextStyle(
            color: colors.accent,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    _ClubOverviewCard(),
                    SizedBox(height: 20),
                    _ActionButton(),
                    SizedBox(height: 24),
                    _SeriesCard(),
                    SizedBox(height: 24),
                    _RecentMatchesCard(),
                  ],
                ),
              ),
            ),
            const AppBottomNavigation(activeRoute: AppRoutes.home),
          ],
        ),
      ),
    );
  }
}

class _ClubOverviewCard extends StatelessWidget {
  const _ClubOverviewCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'APEX SC',
          style: TextStyle(
            color: context.colors.textPrimary,
            fontSize: 38,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 16),
        // Container(
        //   width: double.infinity,
        //   padding: const EdgeInsets.all(20),
        //   decoration: BoxDecoration(
        //     color: const Color(0xFF171A1D),
        //     borderRadius: BorderRadius.circular(22),
        //     border: Border.all(color: const Color(0xFF1F2327)),
        //   ),
        //   child: Row(
        //     children: [
        //       Container(
        //         width: 54,
        //         height: 54,
        //         decoration: BoxDecoration(
        //           color: const Color(0xFF0B180A),
        //           borderRadius: BorderRadius.circular(16),
        //         ),
        //         child: const Icon(
        //           Icons.account_balance_wallet,
        //           color: Color(0xFF00FF41),
        //         ),
        //       ),
        //       const SizedBox(width: 14),
        //       Expanded(
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: const [
        //             Text(
        //               'SALDO ATUAL',
        //               style: TextStyle(
        //                 color: Color(0xFF7C8579),
        //                 fontSize: 12,
        //                 letterSpacing: 1.5,
        //                 fontWeight: FontWeight.w700,
        //               ),
        //             ),
        //             SizedBox(height: 8),
        //             Text(
        //               '$420.5M',
        //               style: TextStyle(
        //                 color: Color(0xFF00FF41),
        //                 fontSize: 26,
        //                 fontWeight: FontWeight.w900,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.registerMatch);
        },
        icon: Icon(Icons.add, color: context.colors.onAccent),
        label: Text(
          'REGISTRAR NOVA PARTIDA',
          style: TextStyle(
            color: context.colors.onAccent,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: context.colors.accent,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

class _SeriesCard extends StatelessWidget {
  const _SeriesCard();

  @override
  Widget build(BuildContext context) {
    final standings = const [
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
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.emoji_events, color: context.colors.accent),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'SÉRIE A',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        FullStandingsTable(standings: standings),
        const SizedBox(height: 20),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            'VISUALIZAR INFORMAÇÕES DA COMPETIÇÃO',
            maxLines: 1,
            overflow: TextOverflow.visible,
            style: TextStyle(
              color: context.colors.accent,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _RecentMatchesCard extends StatelessWidget {
  const _RecentMatchesCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'PARTIDAS RECENTES',
              style: TextStyle(
                color: context.colors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            const _MatchStatusDots(),
          ],
        ),
        const SizedBox(height: 16),
        const _MatchTile(
          label: 'SÉRIE A',
          opponent: 'vs JUVENTUS',
          score: '3 - 1',
          result: 'V',
        ),
        const SizedBox(height: 12),
        const _MatchTile(
          label: 'CHAMPIONS',
          opponent: 'vs PSG',
          score: '2 - 0',
          result: 'V',
        ),
        const SizedBox(height: 12),
        const _MatchTile(
          label: 'COPA',
          opponent: 'vs ATLETICO',
          score: '1 - 1',
          result: 'E',
        ),
      ],
    );
  }
}

class _MatchStatusDots extends StatelessWidget {
  const _MatchStatusDots();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      children: [
        CircleAvatar(radius: 4, backgroundColor: colors.green),
        const SizedBox(width: 6),
        CircleAvatar(radius: 4, backgroundColor: colors.accentLight),
        const SizedBox(width: 6),
        CircleAvatar(radius: 4, backgroundColor: colors.amber),
      ],
    );
  }
}

class _MatchTile extends StatelessWidget {
  final String label;
  final String opponent;
  final String score;
  final String result;

  const _MatchTile({
    required this.label,
    required this.opponent,
    required this.score,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.colors.border),
        boxShadow: context.colors.cardShadow,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: context.colors.accent,
                    fontSize: 10,
                    letterSpacing: 1.4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  opponent,
                  style: TextStyle(
                    color: context.colors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                score,
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: context.colors.accentBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  result,
                  style: TextStyle(
                    color: context.colors.accent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
