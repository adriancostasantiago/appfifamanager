import 'package:flutter/material.dart';

// ─── MODELOS DE JOGADOR ─────────────────────────────────────────────────────

/// Perfil completo do jogador exibido na tela de detalhes.
class PlayerProfile {
  final String name;
  final String country;
  final String position;
  final String photo;
  final int ovr;
  final String marketValue;
  final String salary;

  /// Quantos anos de contrato o jogador ainda possui (1 a 5).
  final int contractUntil;

  /// Valores de 0.0 a 1.0 para os 5 eixos do radar, na ordem:
  /// ATAQUE, TÉCNICA, FÍSICO, DEFESA, MENTAL.
  final Map<String, double> radar;

  final List<PlayerStatGroup> statGroups;
  final List<PlayerPlaystyle> playstyles;
  final PlayerProfileInfo? profile;
  final List<PlayerSpecialty> specialties;
  final List<PlayerRoleFunction> roleFunctions;

  const PlayerProfile({
    required this.name,
    required this.country,
    required this.position,
    required this.photo,
    required this.ovr,
    required this.marketValue,
    required this.salary,
    required this.contractUntil,
    required this.radar,
    required this.statGroups,
    required this.playstyles,
    this.profile,
    this.specialties = const [],
    this.roleFunctions = const [],
  });

  Color get ovrColor {
    if (ovr <= 50) {
      return const Color(0xFFE53935);
    } else if (ovr <= 60) {
      return const Color(0xFFFF9800);
    } else if (ovr <= 70) {
      return const Color.fromARGB(255, 255, 232, 29);
    } else if (ovr <= 80) {
      return const Color.fromARGB(255, 107, 168, 37);
    } else {
      return const Color.fromARGB(255, 5, 104, 46);
    }
  }
}

class PlayerStatGroup {
  final String title;
  final List<PlayerStatItem> items;

  const PlayerStatGroup({required this.title, required this.items});
}

class PlayerStatItem {
  final String label;
  final int value;

  const PlayerStatItem({required this.label, required this.value});
}

/// Estilo de jogo (playstyle) do jogador, exibido como chip.
class PlayerPlaystyle {
  final String name;
  final IconData icon;

  const PlayerPlaystyle({required this.name, required this.icon});
}

/// Informações únicas do jogador: perna boa, fintas e perna ruim.
class PlayerProfileInfo {
  final String pernaBoa;
  final int fintas;
  final int pernaRuim;

  const PlayerProfileInfo({
    required this.pernaBoa,
    required this.fintas,
    required this.pernaRuim,
  });
}

/// Uma especialidade do jogador, ex.: '#Driblador'.
class PlayerSpecialty {
  final String name;

  const PlayerSpecialty({required this.name});
}

/// Nível de destaque de uma função: 'plus_plus' (++), 'plus' (+) ou 'normal'.
enum FunctionLevel { plusPlus, plus, normal }

/// Uma função associada a uma posição, com suas sub-funções listadas.
class PlayerRoleFunction {
  final String functionName;
  final FunctionLevel level;
  final String position;
  final List<String> subFunctions;

  const PlayerRoleFunction({
    required this.functionName,
    required this.level,
    required this.position,
    required this.subFunctions,
  });
}
