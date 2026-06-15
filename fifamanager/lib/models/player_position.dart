import 'squad_data.dart';

class PlayerPosition {
  final String id;
  final String position;

  double x;
  double y;

  PlayerData? player;
  bool showDelete;

  PlayerPosition({
    required this.id,
    required this.position,
    required this.x,
    required this.y,
    this.player,
    this.showDelete = false,
  });
}
