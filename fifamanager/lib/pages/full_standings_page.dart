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
    return Scaffold(
      backgroundColor: const Color(0xFF101314),
      appBar: AppBar(
        backgroundColor: const Color(0xFF101314),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'TABELA COMPLETA - $seriesTitle',
          style: const TextStyle(
            color: Color(0xFF00FF41),
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
                          _buildHeader(),
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

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      child: Row(
        children: const [
          SizedBox(width: 20),
          SizedBox(
            width: 100,
            child: Text(
              'CLUBE',
              style: TextStyle(
                color: Color(0xFF7C8579),
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              'P',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF7C8579),
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              'J',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF7C8579),
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              'V',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF7C8579),
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              'E',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF7C8579),
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              'D',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF7C8579),
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              'GP',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF7C8579),
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              'GC',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF7C8579),
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              'SG',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF7C8579),
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          SizedBox(
            width: 30,
            child: Text(
              '%',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF7C8579),
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
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
    return Container(
      decoration: BoxDecoration(
        color: data.highlight
            ? const Color(0xFF0B1C10)
            : const Color(0xFF131619),
        borderRadius: BorderRadius.circular(18),
        border: data.highlight
            ? Border(left: BorderSide(color: const Color(0xFF00FF41), width: 4))
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
              color: const Color(0xFF16191D),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              data.position,
              style: TextStyle(
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
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
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
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
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w500,
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
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w500,
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
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w500,
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
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w500,
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
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w500,
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
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w500,
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
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w500,
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
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w500,
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
                color: data.highlight ? const Color(0xFF00FF41) : Colors.white,
                fontWeight: data.highlight ? FontWeight.w700 : FontWeight.w500,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
