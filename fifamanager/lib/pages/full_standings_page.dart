import 'package:flutter/material.dart';
import 'package:fifamanager/widgets/standings_table.dart';

const _fullStandingsA = [
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
  FullStandingRowData(
    position: '7',
    club: 'CORINTHIANS',
    points: '61',
    played: '38',
    victories: '17',
    draws: '10',
    defeats: '11',
    goalsFor: '65',
    goalsAgainst: '57',
    goalDiff: '+8',
    percent: '53%',
  ),
  FullStandingRowData(
    position: '8',
    club: 'SÃO PAULO',
    points: '59',
    played: '38',
    victories: '16',
    draws: '11',
    defeats: '11',
    goalsFor: '62',
    goalsAgainst: '57',
    goalDiff: '+5',
    percent: '52%',
  ),
  FullStandingRowData(
    position: '9',
    club: 'VITÓRIA',
    points: '55',
    played: '38',
    victories: '14',
    draws: '13',
    defeats: '11',
    goalsFor: '55',
    goalsAgainst: '53',
    goalDiff: '+2',
    percent: '48%',
  ),
  FullStandingRowData(
    position: '10',
    club: 'CRUZEIRO',
    points: '52',
    played: '38',
    victories: '14',
    draws: '10',
    defeats: '14',
    goalsFor: '60',
    goalsAgainst: '61',
    goalDiff: '-1',
    percent: '45%',
  ),
  FullStandingRowData(
    position: '11',
    club: 'SANTOS',
    points: '50',
    played: '38',
    victories: '13',
    draws: '11',
    defeats: '14',
    goalsFor: '54',
    goalsAgainst: '57',
    goalDiff: '-3',
    percent: '43%',
  ),
  FullStandingRowData(
    position: '12',
    club: 'ATLÉTICO-PR',
    points: '48',
    played: '38',
    victories: '12',
    draws: '12',
    defeats: '14',
    goalsFor: '58',
    goalsAgainst: '63',
    goalDiff: '-5',
    percent: '42%',
  ),
  FullStandingRowData(
    position: '13',
    club: 'FLUMINENSE',
    points: '46',
    played: '38',
    victories: '12',
    draws: '10',
    defeats: '16',
    goalsFor: '56',
    goalsAgainst: '64',
    goalDiff: '-8',
    percent: '40%',
  ),
  FullStandingRowData(
    position: '14',
    club: 'FORTALEZA',
    points: '44',
    played: '38',
    victories: '11',
    draws: '11',
    defeats: '16',
    goalsFor: '52',
    goalsAgainst: '62',
    goalDiff: '-10',
    percent: '38%',
  ),
  FullStandingRowData(
    position: '15',
    club: 'BAHIA',
    points: '42',
    played: '38',
    victories: '11',
    draws: '9',
    defeats: '18',
    goalsFor: '50',
    goalsAgainst: '62',
    goalDiff: '-12',
    percent: '37%',
  ),
  FullStandingRowData(
    position: '16',
    club: 'MOZÃO FC',
    points: '39',
    played: '38',
    victories: '10',
    draws: '9',
    defeats: '19',
    goalsFor: '49',
    goalsAgainst: '64',
    goalDiff: '-15',
    percent: '34%',
  ),
  FullStandingRowData(
    position: '17',
    club: 'CUIABÁ',
    points: '35',
    played: '38',
    victories: '9',
    draws: '8',
    defeats: '21',
    goalsFor: '50',
    goalsAgainst: '68',
    goalDiff: '-18',
    percent: '31%',
  ),
  FullStandingRowData(
    position: '18',
    club: 'AMÉRICA-MG',
    points: '31',
    played: '38',
    victories: '8',
    draws: '7',
    defeats: '23',
    goalsFor: '47',
    goalsAgainst: '69',
    goalDiff: '-22',
    percent: '27%',
  ),
  FullStandingRowData(
    position: '19',
    club: 'CEARÁ',
    points: '28',
    played: '38',
    victories: '6',
    draws: '10',
    defeats: '22',
    goalsFor: '48',
    goalsAgainst: '73',
    goalDiff: '-25',
    percent: '24%',
  ),
  FullStandingRowData(
    position: '20',
    club: 'ATLÉTICO-GO',
    points: '24',
    played: '38',
    victories: '5',
    draws: '9',
    defeats: '24',
    goalsFor: '44',
    goalsAgainst: '74',
    goalDiff: '-30',
    percent: '21%',
  ),
];

const _fullStandingsB = [
  FullStandingRowData(
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
