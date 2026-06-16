import 'package:fifamanager/models/squad_data.dart';

class ClubData {
  final String name;
  final String league;
  final String country;
  final int ovr;
  final String? logoUrl;

  final String stadium;

  final List<PlayerData>? players;

  const ClubData({
    required this.name,
    required this.league,
    required this.country,
    required this.ovr,
    this.logoUrl,
    this.stadium = "ESTÁDIO SEM NOME",
    this.players,
  });
}
