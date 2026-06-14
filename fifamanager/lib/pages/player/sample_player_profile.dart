import 'package:flutter/material.dart';
import 'package:fifamanager/models/models.dart';

/// Dados mockados de exemplo para [PlayerProfile].
///
/// Usado como valor padrão em [PlayerDetailPage] e para preencher
/// radar/estatísticas/playstyles em [_buildProfile] (squad_page) enquanto
/// esses dados não vierem de uma API/Firebase.
const PlayerProfile samplePlayerProfile = PlayerProfile(
  name: 'P. González',
  country: 'ESPANHA',
  position: 'MC',
  photo: '',
  ovr: 87,
  marketValue: '€120M',
  salary: '€250K',
  contractUntil: 3,
  radar: {
    'ATAQUE': 0.40,
    'TÉCNICA': 0.58,
    'FÍSICO': 0.62,
    'DEFESA': 0.35,
    'MENTAL': 0.72,
  },
  statGroups: [
    PlayerStatGroup(
      title: 'OFENSIVO',
      items: [
        PlayerStatItem(label: 'Cruzamento', value: 18),
        PlayerStatItem(label: 'Finalização', value: 14),
        PlayerStatItem(label: 'Cabeceio', value: 11),
        PlayerStatItem(label: 'Passe curto', value: 62),
      ],
    ),
    PlayerStatGroup(
      title: 'HABILIDADE',
      items: [
        PlayerStatItem(label: 'Dribles', value: 21),
        PlayerStatItem(label: 'Curva', value: 18),
        PlayerStatItem(label: 'Lançamento', value: 63),
        PlayerStatItem(label: 'Controle', value: 30),
      ],
    ),
    PlayerStatGroup(
      title: 'MOBILIDADE',
      items: [
        PlayerStatItem(label: 'Aceleração', value: 41),
        PlayerStatItem(label: 'Pique', value: 48),
        PlayerStatItem(label: 'Reação', value: 82),
        PlayerStatItem(label: 'Equilíbrio', value: 43),
      ],
    ),
    PlayerStatGroup(
      title: 'POTÊNCIA',
      items: [
        PlayerStatItem(label: 'F. Chute', value: 65),
        PlayerStatItem(label: 'Impulsão', value: 68),
        PlayerStatItem(label: 'Fôlego', value: 35),
        PlayerStatItem(label: 'Força', value: 75),
      ],
    ),
    PlayerStatGroup(
      title: 'CEREBRAL',
      items: [
        PlayerStatItem(label: 'Visão', value: 70),
        PlayerStatItem(label: 'Compostura', value: 70),
        PlayerStatItem(label: 'Combativ.', value: 43),
      ],
    ),
    PlayerStatGroup(
      title: 'GOLEIRO',
      items: [
        PlayerStatItem(label: 'Reflexos GL', value: 82),
        PlayerStatItem(label: 'Manejo GL', value: 82),
        PlayerStatItem(label: 'Posic. GL', value: 83),
      ],
    ),
  ],
  playstyles: [
    PlayerPlaystyle(name: 'Passe guiado +', icon: Icons.sports_soccer),
    PlayerPlaystyle(name: 'Sai que é sua', icon: Icons.bolt),
    PlayerPlaystyle(name: 'Visão de jogo +', icon: Icons.visibility_outlined),
    PlayerPlaystyle(name: 'Carrinho', icon: Icons.shield_outlined),
  ],
  profile: PlayerProfileInfo(pernaBoa: 'Direita', fintas: 4, pernaRuim: 4),
  specialties: [
    PlayerSpecialty(name: '#Driblador'),
    PlayerSpecialty(name: '#Esp. em bola parada'),
    PlayerSpecialty(name: '#Corredor'),
    PlayerSpecialty(name: '#Líder'),
  ],
  roleFunctions: [
    PlayerRoleFunction(
      functionName: 'Atacante sombra',
      level: FunctionLevel.plusPlus,
      position: 'MEI',
      subFunctions: ['Ataque'],
    ),
    PlayerRoleFunction(
      functionName: 'Falso 9',
      level: FunctionLevel.plusPlus,
      position: 'ATA',
      subFunctions: ['Armação', 'Ataque'],
    ),
    PlayerRoleFunction(
      functionName: 'Corta pra dentro',
      level: FunctionLevel.plus,
      position: 'PD',
      subFunctions: ['Ataque', 'Equilibrado', 'Deslocamento'],
    ),
    PlayerRoleFunction(
      functionName: 'Meia clássico',
      level: FunctionLevel.plus,
      position: 'MC',
      subFunctions: ['Armação', 'Equilíbrio'],
    ),
    PlayerRoleFunction(
      functionName: 'Volante',
      level: FunctionLevel.normal,
      position: 'VOL',
      subFunctions: ['Defesa', 'Desarme'],
    ),
    PlayerRoleFunction(
      functionName: 'Meia ofensivo',
      level: FunctionLevel.plusPlus,
      position: 'MAO',
      subFunctions: ['Ataque', 'Armação', 'Finalização'],
    ),
  ],
);
