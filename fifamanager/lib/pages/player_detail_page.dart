import 'dart:math';
import 'package:flutter/material.dart';

// ─── PALETA (mesma da squad page) ──────────────────────────────────────────

const _kBackground = Color(0xFF101314);
const _kCard = Color(0xFF16191D);
const _kCardAlt = Color(0xFF1A1E22);
const _kBorder = Color(0xFF1F2327);
const _kAccent = Color(0xFF00FF41);
const _kAccentStrong = Color(0xFF1FE35B);
const _kMuted = Color(0xFF7C8579);
const _kSubtle = Color(0xFF9AA39C);
const _kLight = Color(0xFFD7E2D1);

// ─── MODELOS ────────────────────────────────────────────────────────────────

/// Perfil completo do jogador exibido na tela de detalhes.
class PlayerProfile {
  final String name;
  final String country;
  final String position;
  final String photo;
  final int ovr;
  final String marketValue;
  final String salary;
  final String contractUntil;

  /// Valores de 0.0 a 1.0 para os 5 eixos do radar, na ordem:
  /// ATAQUE, TÉCNICA, FÍSICO, DEFESA, MENTAL.
  final Map<String, double> radar;

  final List<PlayerStatGroup> statGroups;
  final List<PlayerPlaystyle> playstyles;

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
  });
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

/// Estilo de jogo (playstyle) do jogador, exibido como um chip em uma
/// lista horizontal com scroll.
class PlayerPlaystyle {
  final String name;
  final IconData icon;

  const PlayerPlaystyle({required this.name, required this.icon});
}

// ─── DADOS DE EXEMPLO ───────────────────────────────────────────────────────

const PlayerProfile samplePlayerProfile = PlayerProfile(
  name: 'P. González',
  country: 'ESPANHA',
  position: 'MC',
  photo: '',
  ovr: 87,
  marketValue: '€120M',
  salary: '€250K',
  contractUntil: '2028',
  radar: const {
    'ATAQUE': 0.40,
    'TÉCNICA': 0.58,
    'FÍSICO': 0.62,
    'DEFESA': 0.35,
    'MENTAL': 0.72,
  },
  statGroups: const [
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
  playstyles: const [
    PlayerPlaystyle(name: 'Passe guiado +', icon: Icons.sports_soccer),
    PlayerPlaystyle(name: 'Sai que é sua', icon: Icons.bolt),
    PlayerPlaystyle(name: 'Visão de jogo +', icon: Icons.visibility_outlined),
    PlayerPlaystyle(name: 'Carrinho', icon: Icons.shield_outlined),
  ],
);

// ─── PÁGINA ─────────────────────────────────────────────────────────────────

class PlayerDetailPage extends StatelessWidget {
  final PlayerProfile player;

  const PlayerDetailPage({super.key, this.player = samplePlayerProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
                child: Column(
                  children: [
                    _PlayerHeader(player: player),
                    const SizedBox(height: 16),
                    _PlayerActionButtons(player: player),
                    const SizedBox(height: 24),
                    _PlayerTopStats(player: player),
                    const SizedBox(height: 24),
                    _TechnicalAnalysisCard(player: player),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── CABEÇALHO (FOTO, NOME, CHIPS, COND/MORAL) ─────────────────────────────

class _PlayerHeader extends StatelessWidget {
  final PlayerProfile player;

  const _PlayerHeader({required this.player});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF20262A), Color(0xFF0B0D0E)],
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  size: 150,
                  color: Color(0xFF2A2F33),
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              right: 16,
              child: _OvrBadge(ovr: player.ovr),
            ),
          ],
        ),

        const SizedBox(height: 32),

        Text(
          player.name.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 14),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _InfoChip(icon: Icons.public, label: player.country),
            const SizedBox(width: 10),
            _InfoChip(icon: Icons.directions_run, label: player.position),
          ],
        ),
      ],
    );
  }
}

class _OvrBadge extends StatelessWidget {
  final int ovr;

  const _OvrBadge({required this.ovr});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 78,
      height: 78,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _kAccentStrong,
        shape: BoxShape.circle,
        border: Border.all(color: _kBackground, width: 5),
        boxShadow: [
          BoxShadow(
            color: _kAccentStrong.withOpacity(0.55),
            blurRadius: 18,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'OVR',
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          Text(
            ovr.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: _kSubtle),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: _kLight,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── CARDS DE VALOR / SALÁRIO / CONTRATO ────────────────────────────────────

class _PlayerTopStats extends StatelessWidget {
  final PlayerProfile player;

  const _PlayerTopStats({required this.player});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TopStatCard(
            title: 'VALOR\nMERCADO',
            value: player.marketValue,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TopStatCard(title: 'SALÁRIO\nSEMANAL', value: player.salary),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TopStatCard(
            title: 'FIM\nCONTRATO',
            value: player.contractUntil,
            highlighted: true,
          ),
        ),
      ],
    );
  }
}

class _TopStatCard extends StatelessWidget {
  final String title;
  final String value;
  final bool highlighted;

  const _TopStatCard({
    required this.title,
    required this.value,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _kMuted,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          if (highlighted) ...[
            const SizedBox(height: 8),
            Container(height: 2, width: 36, color: Colors.white),
          ],
        ],
      ),
    );
  }
}

// ─── AÇÕES DO JOGADOR (RENOVAR / VENDER / EMPRESTAR / DISPENSAR) ───────────

class _PlayerActionButtons extends StatelessWidget {
  final PlayerProfile player;

  const _PlayerActionButtons({required this.player});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PlayerActionButton(
            icon: Icons.autorenew,
            label: 'RENOVAR',
            color: _kAccent,
            onTap: () {
              // TODO: implementar lógica de renovação de contrato
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _PlayerActionButton(
            icon: Icons.sell_outlined,
            label: 'VENDER',
            color: const Color(0xFF4FC3F7),
            onTap: () {
              // TODO: implementar lógica de venda do jogador
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _PlayerActionButton(
            icon: Icons.swap_horiz,
            label: 'EMPRESTAR',
            color: const Color(0xFFFFB74D),
            onTap: () {
              // TODO: implementar lógica de empréstimo do jogador
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _PlayerActionButton(
            icon: Icons.person_remove_outlined,
            label: 'DISPENSAR',
            color: const Color(0xFFE53935),
            onTap: () {
              // TODO: implementar lógica de dispensa do jogador
            },
          ),
        ),
      ],
    );
  }
}

class _PlayerActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _PlayerActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          decoration: BoxDecoration(
            color: _kCardAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.4)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── CARD DE ANÁLISE TÉCNICA (RADAR + ESTATÍSTICAS + PLAYSTYLES) ───────────

class _TechnicalAnalysisCard extends StatelessWidget {
  final PlayerProfile player;

  const _TechnicalAnalysisCard({required this.player});

  @override
  Widget build(BuildContext context) {
    final groups = player.statGroups;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.insert_chart_outlined, color: _kAccent, size: 18),
              SizedBox(width: 10),
              Text(
                'ANÁLISE TÉCNICA AVANÇADA',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          _RadarChart(values: player.radar),

          const SizedBox(height: 8),

          for (int i = 0; i < groups.length; i += 2)
            Padding(
              padding: EdgeInsets.only(
                bottom: i + 2 < groups.length ? 24 : 0,
                top: i == 0 ? 12 : 24,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _StatGroupSection(group: groups[i])),
                  const SizedBox(width: 20),
                  Expanded(
                    child: i + 1 < groups.length
                        ? _StatGroupSection(group: groups[i + 1])
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 28),

          const Text(
            'ESTILOS DE JOGO',
            style: TextStyle(
              color: _kLight,
              fontWeight: FontWeight.w900,
              fontSize: 12,
              letterSpacing: 1.0,
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: player.playstyles.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) =>
                  _PlaystyleChip(playstyle: player.playstyles[index]),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── GRÁFICO RADAR ──────────────────────────────────────────────────────────

class _RadarChart extends StatelessWidget {
  /// Mapa eixo → valor de 0.0 a 1.0. A ordem das chaves define a ordem
  /// dos eixos no pentágono, começando no topo e seguindo no sentido
  /// horário.
  final Map<String, double> values;

  const _RadarChart({required this.values});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 260, maxHeight: 260),
        child: AspectRatio(
          aspectRatio: 1,
          child: CustomPaint(
            painter: _RadarChartPainter(
              labels: values.keys.toList(),
              values: values.values.toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final List<String> labels;
  final List<double> values;

  _RadarChartPainter({required this.labels, required this.values});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, (size.height / 2));
    final radius = (size.shortestSide / 2) - 28;
    final sides = labels.length;
    final angleStep = (2 * pi) / sides;
    const startAngle = -pi / 2;

    final gridPaint = Paint()
      ..color = const Color(0xFF2A2F33)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Anéis concêntricos
    for (int ring = 1; ring <= 4; ring++) {
      final r = radius * ring / 4;
      final path = Path();
      for (int i = 0; i < sides; i++) {
        final angle = startAngle + angleStep * i;
        final point = Offset(
          center.dx + r * cos(angle),
          center.dy + r * sin(angle),
        );
        if (i == 0) {
          path.moveTo(point.dx, point.dy);
        } else {
          path.lineTo(point.dx, point.dy);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }

    // Eixos
    for (int i = 0; i < sides; i++) {
      final angle = startAngle + angleStep * i;
      final point = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawLine(center, point, gridPaint);
    }

    // Polígono de dados
    final dataPath = Path();
    for (int i = 0; i < sides; i++) {
      final angle = startAngle + angleStep * i;
      final r = radius * values[i].clamp(0.0, 1.0);
      final point = Offset(
        center.dx + r * cos(angle),
        center.dy + r * sin(angle),
      );
      if (i == 0) {
        dataPath.moveTo(point.dx, point.dy);
      } else {
        dataPath.lineTo(point.dx, point.dy);
      }
    }
    dataPath.close();

    final glowPaint = Paint()
      ..color = _kAccent.withOpacity(0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawPath(dataPath, glowPaint);

    final fillPaint = Paint()
      ..color = _kAccent.withOpacity(0.16)
      ..style = PaintingStyle.fill;
    canvas.drawPath(dataPath, fillPaint);

    final strokePaint = Paint()
      ..color = _kAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawPath(dataPath, strokePaint);

    // Rótulos
    for (int i = 0; i < sides; i++) {
      final angle = startAngle + angleStep * i;
      final labelRadius = radius + 20;
      final point = Offset(
        center.dx + labelRadius * cos(angle),
        center.dy + labelRadius * sin(angle),
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            color: _kSubtle,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final offset = Offset(
        point.dx - textPainter.width / 2,
        point.dy - textPainter.height / 2,
      );
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant _RadarChartPainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.labels != labels;
  }
}

// ─── GRUPOS DE ESTATÍSTICAS ─────────────────────────────────────────────────

class _StatGroupSection extends StatelessWidget {
  final PlayerStatGroup group;

  const _StatGroupSection({required this.group});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 3, height: 14, color: _kAccent),
            const SizedBox(width: 8),
            Text(
              group.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (final item in group.items)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item.label,
                    style: const TextStyle(
                      color: _kSubtle,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _StatBadge(value: item.value),
              ],
            ),
          ),
      ],
    );
  }
}

class _StatBadge extends StatelessWidget {
  final int value;

  const _StatBadge({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _statColor(value),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        value.toString(),
        style: TextStyle(
          color: _statTextColor(value),
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

/// Cor de fundo do badge de acordo com a faixa do valor.
Color _statColor(int value) {
  if (value >= 75) return const Color(0xFF1FE35B); // Verde
  if (value >= 60) return const Color(0xFF5E6F5C); // Verde acinzentado
  return const Color(0xFFDB7A85); // Vermelho rosado
}

/// Cor do texto do badge de acordo com a faixa do valor.
Color _statTextColor(int value) {
  if (value >= 75) return Colors.black;
  return Colors.white;
}

// ─── PLAYSTYLES ─────────────────────────────────────────────────────────────

/// Chip compacto representando um estilo de jogo, em estilo neutro.
class _PlaystyleChip extends StatelessWidget {
  final PlayerPlaystyle playstyle;

  const _PlaystyleChip({required this.playstyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _kCardAlt,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(playstyle.icon, size: 14, color: _kSubtle),
          const SizedBox(width: 8),
          Text(
            playstyle.name,
            style: const TextStyle(
              color: _kLight,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
