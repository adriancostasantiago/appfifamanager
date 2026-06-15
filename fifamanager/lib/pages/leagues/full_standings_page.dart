import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/widgets/standings_table.dart';

class FullStandingsPage extends StatelessWidget {
  final String seriesTitle;
  final List<FullStandingRowData> standings;

  const FullStandingsPage({
    super.key,
    required this.seriesTitle,
    required this.standings,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: colors.textPrimary),
        title: Text(
          'TABELA COMPLETA - $seriesTitle',
          style: TextStyle(
            color: colors.accent,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 420,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeader(context),
                          const SizedBox(height: 8),
                          ...standings.map(
                            (standing) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: _FullStandingRow(data: standing),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colors = context.colors;
    final headerStyle = TextStyle(
      color: colors.muted,
      fontSize: 8,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
    );
    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.border),
        boxShadow: colors.cardShadow,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: Row(
        children: [
          const SizedBox(width: 20),
          SizedBox(width: 100, child: Text('CLUBE', style: headerStyle)),
          SizedBox(
            width: 30,
            child: Text('P', textAlign: TextAlign.center, style: headerStyle),
          ),
          SizedBox(
            width: 30,
            child: Text('J', textAlign: TextAlign.center, style: headerStyle),
          ),
          SizedBox(
            width: 30,
            child: Text('V', textAlign: TextAlign.center, style: headerStyle),
          ),
          SizedBox(
            width: 30,
            child: Text('E', textAlign: TextAlign.center, style: headerStyle),
          ),
          SizedBox(
            width: 30,
            child: Text('D', textAlign: TextAlign.center, style: headerStyle),
          ),
          SizedBox(
            width: 30,
            child: Text('GP', textAlign: TextAlign.center, style: headerStyle),
          ),
          SizedBox(
            width: 30,
            child: Text('GC', textAlign: TextAlign.center, style: headerStyle),
          ),
          SizedBox(
            width: 30,
            child: Text('SG', textAlign: TextAlign.center, style: headerStyle),
          ),
          SizedBox(
            width: 30,
            child: Text('%', textAlign: TextAlign.center, style: headerStyle),
          ),
        ],
      ),
    );
  }
}

class _FullStandingRow extends StatelessWidget {
  final FullStandingRowData data;

  const _FullStandingRow({required this.data});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textColor = data.highlight ? colors.accent : colors.textPrimary;
    final normalWeight = data.highlight ? FontWeight.w700 : FontWeight.w500;
    return Container(
      decoration: BoxDecoration(
        color: data.highlight ? colors.accentBg : colors.cardDark,
        borderRadius: BorderRadius.circular(18),
        border: data.highlight
            ? Border(left: BorderSide(color: colors.accent, width: 4))
            : null,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 15,
            height: 15,
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
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 100,
            child: Text(
              data.club,
              style: TextStyle(
                color: textColor,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w600,
                fontSize: 10,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              data.points,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: normalWeight,
                fontSize: 10,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              data.played,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: normalWeight,
                fontSize: 10,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              data.victories,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: normalWeight,
                fontSize: 10,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              data.draws,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: normalWeight,
                fontSize: 10,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              data.defeats,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: normalWeight,
                fontSize: 10,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              data.goalsFor,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: normalWeight,
                fontSize: 10,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              data.goalsAgainst,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: normalWeight,
                fontSize: 10,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              data.goalDiff,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: normalWeight,
                fontSize: 10,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              data.percent,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: normalWeight,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
