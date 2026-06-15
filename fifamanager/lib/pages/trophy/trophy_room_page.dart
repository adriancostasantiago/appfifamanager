import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';
import 'package:fifamanager/models/models.dart';

final _trophyGroups = [
  TrophyGroupData(
    title: '3x CAMPEÃO SÉRIE A',
    subtitle: '2023-2022-2021',
    imageTrophy: Image.asset('assets/trophy-A.png', width: 48, height: 48),
    accentColor: const Color(0xFF00FF41),
    trophies: [
      TrophyData(
        year: '2023',
        competitionLabel: 'SÉRIE A',
        tier: TrophyTier.seriea,
      ),
      TrophyData(
        year: '2022',
        competitionLabel: 'SÉRIE A',
        tier: TrophyTier.seriea,
      ),
      TrophyData(
        year: '2021',
        competitionLabel: 'SÉRIE A',
        tier: TrophyTier.seriea,
      ),
      TrophyData(
        year: '2021',
        competitionLabel: 'SÉRIE A',
        tier: TrophyTier.seriea,
      ),
      TrophyData(
        year: '2021',
        competitionLabel: 'SÉRIE A',
        tier: TrophyTier.seriea,
      ),
      TrophyData(
        year: '2021',
        competitionLabel: 'SÉRIE A',
        tier: TrophyTier.seriea,
      ),
    ],
  ),
  TrophyGroupData(
    title: '2X CAMPEÃO DA COPA',
    subtitle: '2023-2022',
    imageTrophy: Image.asset('assets/trophy-CUP.png', width: 48, height: 48),
    accentColor: const Color(0xFFE0A86B),
    trophies: [
      TrophyData(year: '2023', competitionLabel: 'COPA', tier: TrophyTier.copa),
      TrophyData(year: '2022', competitionLabel: 'COPA', tier: TrophyTier.copa),
    ],
  ),
  TrophyGroupData(
    title: '1X CAMPEÃO SÉRIE B',
    subtitle: '2020',
    accentColor: const Color(0xFF7C8579),
    imageTrophy: Image.asset('assets/trophy-B.png', width: 48, height: 48),
    trophies: [
      TrophyData(
        year: '2020',
        competitionLabel: 'SÉRIE B',
        tier: TrophyTier.serieb,
      ),
    ],
  ),
];

// ─── PAGE ────────────────────────────────────────────────────────────────────

class TrophyRoomPage extends StatelessWidget {
  const TrophyRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101314),
      appBar: AppBar(
        backgroundColor: const Color(0xFF101314),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.home),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFF7C8579)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF7C8579)),
            onPressed: () {},
          ),
        ],
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
          ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0A1A0E),
              borderRadius: BorderRadius.circular(99),
              border: Border.all(
                color: const Color(0xFF00FF41).withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.military_tech, color: Color(0xFF00FF41), size: 18),
                SizedBox(width: 8),
                Text(
                  'SALA DE TROFÉUS',
                  style: TextStyle(
                    color: Color(0xFF00FF41),
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
        const Center(
          child: Text(
            '6 TÍTULOS\nCONQUISTADOS',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
              height: 1.05,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Center(
          child: Text(
            'A história gloriosa do Apex SC escrita\nnos gramados virtuais.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7C8579),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with left border accent
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
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                data.subtitle,
                style: const TextStyle(
                  color: Color(0xFF7C8579),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Trophy grid
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
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.champion),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1F2327)),
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
          // Trophy icon with glow
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
          // Year / label
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
          // Accent bar
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
