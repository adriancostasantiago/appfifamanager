import 'package:flutter/material.dart';
import 'package:fifamanager/core/theme/app_theme.dart';

// ─── COLUMN SIZING ───────────────────────────────────────────────────────────
// Usamos flex em vez de larguras fixas para evitar overflow por arredondamento.
// positionFlex : espaço do badge de posição
// clubFlex     : espaço do nome do clube
// statFlex     : espaço de cada coluna de stats (9 colunas)
const int _posFlex = 3;
const int _clubFlex = 8;
const int _statFlex = 3; // cada uma das 9 colunas de stats
const double _minTableWidth = 360;

// ─── DATA MODELS ─────────────────────────────────────────────────────────────

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

// ─── FULL STANDINGS TABLE ────────────────────────────────────────────────────

class FullStandingsTable extends StatelessWidget {
  final List<FullStandingRowData> standings;

  const FullStandingsTable({super.key, required this.standings});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
        boxShadow: colors.cardShadow,
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      // LayoutBuilder: se a tela for maior que o mínimo, ocupa tudo.
      // Se for menor, usa o mínimo e o scroll horizontal aparece.
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Se a tela for maior que o mínimo, ocupa tudo.
          // Se for menor, usa o mínimo e o scroll horizontal aparece.
          final tableWidth = constraints.maxWidth.clamp(
            _minTableWidth,
            double.infinity,
          );

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: tableWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
        },
      ),
    );
  }
}

class _FullStandingsHeader extends StatelessWidget {
  const _FullStandingsHeader();

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      color: context.colors.muted,
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
    );

    return Row(
      children: [
        Expanded(flex: _posFlex, child: const SizedBox()),
        Expanded(
          flex: _clubFlex,
          child: Text('CLUBE', style: style),
        ),
        for (final label in ['P', 'J', 'V', 'E', 'D', 'GP', 'GC', 'SG', '%'])
          Expanded(
            flex: _statFlex,
            child: Text(label, textAlign: TextAlign.center, style: style),
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
    final colors = context.colors;
    final isHighlight = data.highlight;
    final textColor = isHighlight ? colors.accent : colors.textPrimary;
    final statStyle = TextStyle(
      color: textColor,
      fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w500,
      fontSize: 12,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isHighlight ? colors.accentBg : colors.cardDark,
        borderRadius: BorderRadius.circular(18),
        border: isHighlight
            ? Border(left: BorderSide(color: colors.accent, width: 4))
            : null,
      ),
      child: Row(
        children: [
          // Position badge
          Expanded(
            flex: _posFlex,
            child: Center(
              child: Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.card,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  data.position,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ),
          // Club name
          Expanded(
            flex: _clubFlex,
            child: Text(
              data.club,
              style: TextStyle(
                color: textColor,
                fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w600,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Stat columns
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
            Expanded(
              flex: _statFlex,
              child: Text(value, textAlign: TextAlign.center, style: statStyle),
            ),
        ],
      ),
    );
  }
}

// ─── SIMPLE STANDINGS TABLE ──────────────────────────────────────────────────

class StandingsTable extends StatelessWidget {
  final List<StandingRowData> standings;

  const StandingsTable({super.key, required this.standings});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
        boxShadow: colors.cardShadow,
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
    final headerStyle = TextStyle(
      color: context.colors.muted,
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.2,
    );
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text('CLUBE', style: headerStyle),
        ),
        Expanded(
          child: Text('J', textAlign: TextAlign.center, style: headerStyle),
        ),
        Expanded(
          child: Text('SG', textAlign: TextAlign.center, style: headerStyle),
        ),
        Expanded(
          child: Text('PTS', textAlign: TextAlign.center, style: headerStyle),
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
    final colors = context.colors;
    final textColor = data.highlight ? colors.accent : colors.textPrimary;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: data.highlight ? colors.accentBg : colors.cardDark,
        borderRadius: BorderRadius.circular(18),
        border: data.highlight
            ? Border(left: BorderSide(color: colors.accent, width: 4))
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
                    color: colors.card,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    data.position,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    data.club,
                    style: TextStyle(
                      color: textColor,
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
                color: textColor,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              data.diff,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              data.points,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
