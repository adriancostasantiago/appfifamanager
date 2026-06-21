import 'player_position.dart';

class Formation {
  final String name;
  final List<PlayerPosition> positions;

  const Formation({required this.name, required this.positions});
}

class Formations {
  static Formation fourThreeThree = Formation(
    name: '4-3-3',
    positions: [
      PlayerPosition(id: '9', position: 'LW', x: 0.05, y: 0.14),
      PlayerPosition(id: '10', position: 'ST', x: 0.38, y: 0.06),
      PlayerPosition(id: '11', position: 'RW', x: 0.68, y: 0.14),

      PlayerPosition(id: '6', position: 'MC', x: 0.08, y: 0.42),
      PlayerPosition(id: '7', position: 'MC', x: 0.38, y: 0.35),
      PlayerPosition(id: '8', position: 'MC', x: 0.65, y: 0.42),

      PlayerPosition(id: '2', position: 'LB', x: 0.02, y: 0.66),
      PlayerPosition(id: '3', position: 'CB', x: 0.22, y: 0.70),
      PlayerPosition(id: '4', position: 'CB', x: 0.52, y: 0.70),
      PlayerPosition(id: '5', position: 'RB', x: 0.72, y: 0.66),

      PlayerPosition(id: '1', position: 'GK', x: 0.38, y: 0.82),
    ],
  );

  static Formation fourFourTwo = Formation(
    name: '4-4-2',
    positions: [
      PlayerPosition(id: '9', position: 'ST', x: 0.25, y: 0.10),
      PlayerPosition(id: '10', position: 'ST', x: 0.52, y: 0.10),

      PlayerPosition(id: '11', position: 'LM', x: 0.02, y: 0.32),
      PlayerPosition(id: '12', position: 'MC', x: 0.25, y: 0.35),
      PlayerPosition(id: '13', position: 'MC', x: 0.52, y: 0.35),
      PlayerPosition(id: '14', position: 'RM', x: 0.75, y: 0.32),

      PlayerPosition(id: '2', position: 'LB', x: 0.02, y: 0.66),
      PlayerPosition(id: '3', position: 'CB', x: 0.22, y: 0.70),
      PlayerPosition(id: '4', position: 'CB', x: 0.52, y: 0.70),
      PlayerPosition(id: '5', position: 'RB', x: 0.72, y: 0.66),

      PlayerPosition(id: '1', position: 'GK', x: 0.38, y: 0.82),
    ],
  );

  static Formation fourTwoThreeOne = Formation(
    name: '4-2-3-1',
    positions: [
      PlayerPosition(id: '9', position: 'ST', x: 0.38, y: 0.08),

      PlayerPosition(id: '10', position: 'LW', x: 0.05, y: 0.24),
      PlayerPosition(id: '11', position: 'CAM', x: 0.38, y: 0.20),
      PlayerPosition(id: '12', position: 'RW', x: 0.68, y: 0.24),

      PlayerPosition(id: '13', position: 'CDM', x: 0.22, y: 0.42),
      PlayerPosition(id: '14', position: 'CDM', x: 0.52, y: 0.42),

      PlayerPosition(id: '2', position: 'LB', x: 0.02, y: 0.66),
      PlayerPosition(id: '3', position: 'CB', x: 0.22, y: 0.70),
      PlayerPosition(id: '4', position: 'CB', x: 0.52, y: 0.70),
      PlayerPosition(id: '5', position: 'RB', x: 0.72, y: 0.66),

      PlayerPosition(id: '1', position: 'GK', x: 0.38, y: 0.82),
    ],
  );

  static Formation fourOneTwoOneTwo = Formation(
    name: '4-1-2-1-2',
    positions: [
      PlayerPosition(id: '9', position: 'ST', x: 0.25, y: 0.10),
      PlayerPosition(id: '10', position: 'ST', x: 0.52, y: 0.10),

      PlayerPosition(id: '11', position: 'CAM', x: 0.38, y: 0.26),

      PlayerPosition(id: '12', position: 'LM', x: 0.08, y: 0.38),
      PlayerPosition(id: '13', position: 'RM', x: 0.68, y: 0.38),

      PlayerPosition(id: '14', position: 'CDM', x: 0.38, y: 0.48),

      PlayerPosition(id: '2', position: 'LB', x: 0.02, y: 0.66),
      PlayerPosition(id: '3', position: 'CB', x: 0.22, y: 0.70),
      PlayerPosition(id: '4', position: 'CB', x: 0.52, y: 0.70),
      PlayerPosition(id: '5', position: 'RB', x: 0.72, y: 0.66),

      PlayerPosition(id: '1', position: 'GK', x: 0.38, y: 0.82),
    ],
  );

  static Formation threeFiveTwo = Formation(
    name: '3-5-2',
    positions: [
      PlayerPosition(id: '9', position: 'ST', x: 0.25, y: 0.10),
      PlayerPosition(id: '10', position: 'ST', x: 0.52, y: 0.10),

      PlayerPosition(id: '11', position: 'LM', x: 0.02, y: 0.30),
      PlayerPosition(id: '12', position: 'MC', x: 0.22, y: 0.35),
      PlayerPosition(id: '13', position: 'CAM', x: 0.38, y: 0.28),
      PlayerPosition(id: '14', position: 'MC', x: 0.52, y: 0.35),
      PlayerPosition(id: '15', position: 'RM', x: 0.75, y: 0.30),

      PlayerPosition(id: '3', position: 'CB', x: 0.12, y: 0.66),
      PlayerPosition(id: '4', position: 'CB', x: 0.38, y: 0.58),
      PlayerPosition(id: '5', position: 'CB', x: 0.64, y: 0.66),

      PlayerPosition(id: '1', position: 'GK', x: 0.38, y: 0.82),
    ],
  );
  static Formation fourFiveOne = Formation(
    name: '4-5-1',
    positions: [
      PlayerPosition(id: '9', position: 'ST', x: 0.38, y: 0.08),

      PlayerPosition(id: '10', position: 'LM', x: 0.02, y: 0.28),
      PlayerPosition(id: '11', position: 'MC', x: 0.22, y: 0.34),
      PlayerPosition(id: '12', position: 'MC', x: 0.38, y: 0.30),
      PlayerPosition(id: '13', position: 'MC', x: 0.54, y: 0.34),
      PlayerPosition(id: '14', position: 'RM', x: 0.75, y: 0.28),

      PlayerPosition(id: '2', position: 'LB', x: 0.02, y: 0.66),
      PlayerPosition(id: '3', position: 'CB', x: 0.22, y: 0.70),
      PlayerPosition(id: '4', position: 'CB', x: 0.52, y: 0.70),
      PlayerPosition(id: '5', position: 'RB', x: 0.72, y: 0.66),

      PlayerPosition(id: '1', position: 'GK', x: 0.38, y: 0.82),
    ],
  );

  static Formation threeFourThree = Formation(
    name: '3-4-3',
    positions: [
      PlayerPosition(id: '9', position: 'LW', x: 0.05, y: 0.12),
      PlayerPosition(id: '10', position: 'ST', x: 0.38, y: 0.08),
      PlayerPosition(id: '11', position: 'RW', x: 0.68, y: 0.12),

      PlayerPosition(id: '12', position: 'LM', x: 0.02, y: 0.35),
      PlayerPosition(id: '13', position: 'MC', x: 0.25, y: 0.38),
      PlayerPosition(id: '14', position: 'MC', x: 0.52, y: 0.38),
      PlayerPosition(id: '15', position: 'RM', x: 0.75, y: 0.35),

      PlayerPosition(id: '3', position: 'CB', x: 0.12, y: 0.66),
      PlayerPosition(id: '4', position: 'CB', x: 0.38, y: 0.58),
      PlayerPosition(id: '5', position: 'CB', x: 0.64, y: 0.66),

      PlayerPosition(id: '1', position: 'GK', x: 0.38, y: 0.82),
    ],
  );

  static Formation fiveThreeTwo = Formation(
    name: '5-3-2',
    positions: [
      PlayerPosition(id: '9', position: 'ST', x: 0.25, y: 0.10),
      PlayerPosition(id: '10', position: 'ST', x: 0.52, y: 0.10),

      PlayerPosition(id: '11', position: 'MC', x: 0.15, y: 0.35),
      PlayerPosition(id: '12', position: 'MC', x: 0.38, y: 0.30),
      PlayerPosition(id: '13', position: 'MC', x: 0.60, y: 0.35),

      PlayerPosition(id: '2', position: 'LWB', x: 0.00, y: 0.55),
      PlayerPosition(id: '3', position: 'CB', x: 0.16, y: 0.70),
      PlayerPosition(id: '4', position: 'CB', x: 0.38, y: 0.58),
      PlayerPosition(id: '5', position: 'CB', x: 0.60, y: 0.70),
      PlayerPosition(id: '6', position: 'RWB', x: 0.78, y: 0.55),

      PlayerPosition(id: '1', position: 'GK', x: 0.38, y: 0.82),
    ],
  );

  static Formation fiveTwoOneTwo = Formation(
    name: '5-2-1-2',
    positions: [
      PlayerPosition(id: '9', position: 'ST', x: 0.25, y: 0.10),
      PlayerPosition(id: '10', position: 'ST', x: 0.52, y: 0.10),

      PlayerPosition(id: '11', position: 'CAM', x: 0.38, y: 0.26),

      PlayerPosition(id: '12', position: 'MC', x: 0.25, y: 0.42),
      PlayerPosition(id: '13', position: 'MC', x: 0.52, y: 0.42),

      PlayerPosition(id: '2', position: 'LWB', x: 0.00, y: 0.55),
      PlayerPosition(id: '3', position: 'CB', x: 0.16, y: 0.70),
      PlayerPosition(id: '4', position: 'CB', x: 0.38, y: 0.58),
      PlayerPosition(id: '5', position: 'CB', x: 0.60, y: 0.70),
      PlayerPosition(id: '6', position: 'RWB', x: 0.78, y: 0.55),

      PlayerPosition(id: '1', position: 'GK', x: 0.38, y: 0.82),
    ],
  );

  static Formation fourThreeTwoOne = Formation(
    name: '4-3-2-1',
    positions: [
      PlayerPosition(id: '9', position: 'ST', x: 0.38, y: 0.08),

      PlayerPosition(id: '10', position: 'CF', x: 0.20, y: 0.20),
      PlayerPosition(id: '11', position: 'CF', x: 0.56, y: 0.20),

      PlayerPosition(id: '12', position: 'MC', x: 0.12, y: 0.38),
      PlayerPosition(id: '13', position: 'MC', x: 0.38, y: 0.32),
      PlayerPosition(id: '14', position: 'MC', x: 0.62, y: 0.38),

      PlayerPosition(id: '2', position: 'LB', x: 0.02, y: 0.66),
      PlayerPosition(id: '3', position: 'CB', x: 0.22, y: 0.70),
      PlayerPosition(id: '4', position: 'CB', x: 0.52, y: 0.70),
      PlayerPosition(id: '5', position: 'RB', x: 0.72, y: 0.66),

      PlayerPosition(id: '1', position: 'GK', x: 0.38, y: 0.82),
    ],
  );

  static Formation fourTwoTwoTwo = Formation(
    name: '4-2-2-2',
    positions: [
      PlayerPosition(id: '9', position: 'ST', x: 0.25, y: 0.10),
      PlayerPosition(id: '10', position: 'ST', x: 0.52, y: 0.10),

      PlayerPosition(id: '11', position: 'CAM', x: 0.15, y: 0.28),
      PlayerPosition(id: '12', position: 'CAM', x: 0.60, y: 0.28),

      PlayerPosition(id: '13', position: 'CDM', x: 0.25, y: 0.46),
      PlayerPosition(id: '14', position: 'CDM', x: 0.52, y: 0.46),

      PlayerPosition(id: '2', position: 'LB', x: 0.02, y: 0.66),
      PlayerPosition(id: '3', position: 'CB', x: 0.22, y: 0.70),
      PlayerPosition(id: '4', position: 'CB', x: 0.52, y: 0.70),
      PlayerPosition(id: '5', position: 'RB', x: 0.72, y: 0.66),

      PlayerPosition(id: '1', position: 'GK', x: 0.38, y: 0.82),
    ],
  );

  static Formation fourOneFourOne = Formation(
    name: '4-1-4-1',
    positions: [
      PlayerPosition(id: '9', position: 'ST', x: 0.38, y: 0.08),

      PlayerPosition(id: '10', position: 'LM', x: 0.02, y: 0.28),
      PlayerPosition(id: '11', position: 'MC', x: 0.22, y: 0.32),
      PlayerPosition(id: '12', position: 'MC', x: 0.52, y: 0.32),
      PlayerPosition(id: '13', position: 'RM', x: 0.75, y: 0.28),

      PlayerPosition(id: '14', position: 'CDM', x: 0.38, y: 0.48),

      PlayerPosition(id: '2', position: 'LB', x: 0.02, y: 0.66),
      PlayerPosition(id: '3', position: 'CB', x: 0.22, y: 0.70),
      PlayerPosition(id: '4', position: 'CB', x: 0.52, y: 0.70),
      PlayerPosition(id: '5', position: 'RB', x: 0.72, y: 0.66),

      PlayerPosition(id: '1', position: 'GK', x: 0.38, y: 0.82),
    ],
  );

  static List<Formation> all = [
    fourThreeThree,
    fourFourTwo,
    fourTwoThreeOne,
    fourOneTwoOneTwo,
    threeFiveTwo,
    fourFiveOne,
    threeFourThree,
    fiveThreeTwo,
    fiveTwoOneTwo,
    fourThreeTwoOne,
    fourTwoTwoTwo,
    fourOneFourOne,
  ];
}
