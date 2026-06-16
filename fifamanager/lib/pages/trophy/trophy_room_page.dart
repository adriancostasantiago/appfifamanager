import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';
import 'package:fifamanager/models/models.dart';
import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:fifamanager/pages/champion/champion_page.dart';

// ─── DADOS ───────────────────────────────────────────────────────────────────

const _teamName = 'Apex SC';

final _trophyGroups = [
  TrophyGroupData(
    title: '3x CAMPEÃO SÉRIE A',
    subtitle: '2023-2022-2021',
    imageTrophy: Image.asset('assets/trophy-A.png', width: 48, height: 48),
    imageURL: 'assets/trophy-A.png',
    accentColor: const Color(0xFF00FF41),
    trophies: [
      TrophyData(
        year: '2023',
        competitionLabel: 'SÉRIE A',
        tier: TrophyTier.seriea,
        jogos: 38,
        vitorias: 29,
        empates: 5,
        derrotas: 4,
        gols: 84,
        golsSofridos: 31,
      ),
      TrophyData(
        year: '2022',
        competitionLabel: 'SÉRIE A',
        tier: TrophyTier.seriea,
        jogos: 38,
        vitorias: 26,
        empates: 7,
        derrotas: 5,
        gols: 71,
        golsSofridos: 28,
      ),
      TrophyData(
        year: '2021',
        competitionLabel: 'SÉRIE A',
        tier: TrophyTier.seriea,
        jogos: 38,
        vitorias: 24,
        empates: 8,
        derrotas: 6,
        gols: 68,
        golsSofridos: 33,
      ),
    ],
  ),
  TrophyGroupData(
    title: '2X CAMPEÃO DA COPA',
    subtitle: '2023-2022',
    imageTrophy: Image.asset('assets/trophy-CUP.png', width: 48, height: 48),
    imageURL: 'assets/trophy-CUP.png',
    accentColor: const Color(0xFFE0A86B),
    trophies: [
      TrophyData(
        year: '2023',
        competitionLabel: 'COPA',
        tier: TrophyTier.copa,
        jogos: 7,
        vitorias: 6,
        empates: 1,
        derrotas: 0,
        gols: 18,
        golsSofridos: 5,
      ),
      TrophyData(
        year: '2022',
        competitionLabel: 'COPA',
        tier: TrophyTier.copa,
        jogos: 7,
        vitorias: 5,
        empates: 1,
        derrotas: 1,
        gols: 14,
        golsSofridos: 6,
      ),
    ],
  ),
  TrophyGroupData(
    title: '1X CAMPEÃO SÉRIE B',
    subtitle: '2020',
    accentColor: const Color(0xFF7C8579),
    imageTrophy: Image.asset('assets/trophy-B.png', width: 48, height: 48),
    imageURL: 'assets/trophy-B.png',
    trophies: [
      TrophyData(
        year: '2020',
        competitionLabel: 'SÉRIE B',
        tier: TrophyTier.serieb,
        jogos: 38,
        vitorias: 22,
        empates: 9,
        derrotas: 7,
        gols: 59,
        golsSofridos: 36,
      ),
    ],
  ),
];

// ─── PAGE ────────────────────────────────────────────────────────────────────

class TrophyRoomPage extends StatelessWidget {
  const TrophyRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.home),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share_outlined, color: colors.muted),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: colors.muted),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HallOfFameHeader(),
              const SizedBox(height: 32),
              ..._trophyGroups.map(
                (group) => Padding(
                  padding: const EdgeInsets.only(bottom: 36),
                  child: _TrophyGroup(data: group),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── HEADER ──────────────────────────────────────────────────────────────────

class _HallOfFameHeader extends StatelessWidget {
  const _HallOfFameHeader();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: colors.accentBg,
              borderRadius: BorderRadius.circular(99),
              border: Border.all(color: colors.accent.withValues(alpha: 0.35)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.military_tech, color: colors.accent, size: 18),
                const SizedBox(width: 8),
                Text(
                  'SALA DE TROFÉUS',
                  style: TextStyle(
                    color: colors.accent,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            '6 TÍTULOS\nCONQUISTADOS',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 38,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
              height: 1.05,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'A história gloriosa do Apex SC escrita\nnos gramados virtuais.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.muted,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── TROPHY GROUP ─────────────────────────────────────────────────────────────

class _TrophyGroup extends StatelessWidget {
  final TrophyGroupData data;

  const _TrophyGroup({required this.data});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 14),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: data.accentColor, width: 4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                data.subtitle,
                style: TextStyle(
                  color: colors.muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildGrid(context, data),
      ],
    );
  }

  Widget _buildGrid(BuildContext context, TrophyGroupData group) {
    return SizedBox(
      height: 290,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: group.trophies.map((trophy) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (_, _, _) => ChampionPage(
                      teamName: _teamName,
                      jogos: trophy.jogos,
                      vitorias: trophy.vitorias,
                      gols: trophy.gols,
                      year: trophy.year,
                      competitionLabel: trophy.competitionLabel,
                      imageTrophy: group.imageURL,
                    ),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                ),
                child: SizedBox(
                  width: 120,
                  child: _TrophyCard(
                    trophy: trophy,
                    accentColor: group.accentColor,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// ─── TROPHY CARD ─────────────────────────────────────────────────────────────

class _TrophyCard extends StatelessWidget {
  final TrophyData trophy;
  final Color accentColor;

  const _TrophyCard({required this.trophy, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.06),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/trophy-${trophy.tier == TrophyTier.seriea
                ? 'A'
                : trophy.tier == TrophyTier.copa
                ? 'CUP'
                : 'B'}.png',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 14),
          Text(
            trophy.year,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 28,
            height: 2,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
