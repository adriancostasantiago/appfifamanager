import 'package:flutter/material.dart';

class StandingRowData {
  final String position;
  final String club;
  final String played;
  final String diff;
  final String points;
  final bool highlight;

  const StandingRowData({
    required this.position,
    required this.club,
    required this.played,
    required this.diff,
    required this.points,
    this.highlight = false,
  });
}

class FullStandingRowData {
  final String position;
  final String club;
  final String points;
  final String played;
  final String victories;
  final String draws;
  final String defeats;
  final String goalsFor;
  final String goalsAgainst;
  final String goalDiff;
  final String percent;
  final bool highlight;

  const FullStandingRowData({
    required this.position,
    required this.club,
    required this.points,
    required this.played,
    required this.victories,
    required this.draws,
    required this.defeats,
    required this.goalsFor,
    required this.goalsAgainst,
    required this.goalDiff,
    required this.percent,
    this.highlight = false,
  });
}

class FullStandingsTable extends StatelessWidget {
  final List<FullStandingRowData> standings;

  const FullStandingsTable({super.key, required this.standings});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 410,
        decoration: BoxDecoration(
          color: const Color(0xFF16191D),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFF1F2327)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        child: Column(
          children: [
            const _FullStandingsHeader(),
            const SizedBox(height: 8),
            ...standings.map((standing) {
              final index = standings.indexOf(standing);
              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == standings.length - 1 ? 0 : 6,
                ),
                child: _FullStandingRow(data: standing),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _FullStandingsHeader extends StatelessWidget {
  const _FullStandingsHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SizedBox(width: 16),
        SizedBox(
          width: 100,
          child: Text(
            'CLUBE',
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(
          width: 28,
          child: Text(
            'P',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(
          width: 28,
          child: Text(
            'J',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(
          width: 28,
          child: Text(
            'V',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(
          width: 28,
          child: Text(
            'E',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(
          width: 28,
          child: Text(
            'D',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(
          width: 28,
          child: Text(
            'GP',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(
          width: 28,
          child: Text(
            'GC',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(
          width: 28,
          child: Text(
            'SG',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(
          width: 28,
          child: Text(
            '%',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}

class _FullStandingRow extends StatelessWidget {
  final FullStandingRowData data;

  const _FullStandingRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: data.highlight
            ? const Color(0xFF0B1C10)
            : const Color(0xFF131619),
        borderRadius: BorderRadius.circular(18),
        border: data.highlight
            ? Border(left: BorderSide(color: const Color(0xFF00FF41), width: 4))
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF16191D),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              data.position,
              style: TextStyle(
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 2),
          SizedBox(
            width: 80,
            child: Text(
              data.club,
              style: TextStyle(
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w600,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          for (final value in [
            data.points,
            data.played,
            data.victories,
            data.draws,
            data.defeats,
            data.goalsFor,
            data.goalsAgainst,
            data.goalDiff,
            data.percent,
          ])
            SizedBox(
              width: 28,
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: data.highlight
                      ? const Color(0xFF00FF41)
                      : Colors.white,
                  fontWeight: data.highlight
                      ? FontWeight.w700
                      : FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class StandingsTable extends StatelessWidget {
  final List<StandingRowData> standings;

  const StandingsTable({super.key, required this.standings});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          const _StandingsHeader(),
          const SizedBox(height: 12),
          ...standings.map((standing) {
            final index = standings.indexOf(standing);
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == standings.length - 1 ? 0 : 10,
              ),
              child: _StandingRow(data: standing),
            );
          }),
        ],
      ),
    );
  }
}

class _StandingsHeader extends StatelessWidget {
  const _StandingsHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          flex: 4,
          child: Text(
            'CLUBE',
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'J',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'SG',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'PTS',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

class _StandingRow extends StatelessWidget {
  final StandingRowData data;

  const _StandingRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: data.highlight
            ? const Color(0xFF0B1C10)
            : const Color(0xFF131619),
        borderRadius: BorderRadius.circular(18),
        border: data.highlight
            ? Border(left: BorderSide(color: const Color(0xFF00FF41), width: 4))
            : null,
        boxShadow: data.highlight
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 16,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF16191D),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    data.position,
                    style: TextStyle(
                      color: data.highlight
                          ? const Color(0xFF00FF41)
                          : Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    data.club,
                    style: TextStyle(
                      color: data.highlight
                          ? const Color(0xFF00FF41)
                          : Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: data.highlight ? 0.8 : 0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              data.played,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              data.diff,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              data.points,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
