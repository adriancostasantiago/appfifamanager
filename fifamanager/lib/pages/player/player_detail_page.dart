import 'dart:math';
import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/models/models.dart';
import 'sample_player_profile.dart';
import 'package:fifamanager/core/theme/app_colors.dart';
import 'contract_renewal_page.dart';
import 'sell_player_page.dart';
import 'loan_player_page.dart';
import 'release_player_page.dart';

enum _DetailTab { perfil, especialidades, funcoes, estilos, caracteristicas }

class PlayerDetailPage extends StatefulWidget {
  final PlayerProfile player;

  const PlayerDetailPage({super.key, this.player = samplePlayerProfile});

  @override
  State<PlayerDetailPage> createState() => _PlayerDetailPageState();
}

class _PlayerDetailPageState extends State<PlayerDetailPage> {
  _DetailTab _activeTab = _DetailTab.perfil;
  bool _tabsSticky = false;

  final _scrollController = ScrollController();
  final _keyTabs = GlobalKey();
  final _keyPerfil = GlobalKey();
  final _keyEspecialidades = GlobalKey();
  final _keyFuncoes = GlobalKey();
  final _keyEstilos = GlobalKey();
  final _keyCaracteristicas = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final ctx = _keyTabs.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null) return;
    final pos = box.localToGlobal(Offset.zero);
    final sticky = pos.dy <= 0;
    if (sticky != _tabsSticky) setState(() => _tabsSticky = sticky);
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null) return;
    // Pega a posição do widget relativa ao RenderObject do scroll
    final scrollBox =
        _scrollController.position.context.storageContext.findRenderObject()
            as RenderBox?;
    if (scrollBox == null) return;
    final pos = box.localToGlobal(Offset.zero, ancestor: scrollBox);
    const tabsHeight = 50.0;
    final destination = (_scrollController.offset + pos.dy - tabsHeight).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );
    _scrollController.animateTo(
      destination,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _onTabTap(_DetailTab tab) {
    setState(() => _activeTab = tab);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (tab) {
        case _DetailTab.perfil:
          _scrollTo(_keyPerfil);
        case _DetailTab.especialidades:
          _scrollTo(_keyEspecialidades);
        case _DetailTab.funcoes:
          _scrollTo(_keyFuncoes);
        case _DetailTab.estilos:
          _scrollTo(_keyEstilos);
        case _DetailTab.caracteristicas:
          _scrollTo(_keyCaracteristicas);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final player = widget.player;

    return Scaffold(
      backgroundColor: context.colors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            // ── Barra topo: voltar
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

            // ── Área de conteúdo (Stack para overlay das abas sticky)
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                    child: Column(
                      children: [
                        _PlayerHeader(player: player),
                        const SizedBox(height: 24),
                        _PlayerTopStats(player: player),
                        const SizedBox(height: 16),
                        _PlayerActionButtons(player: player),
                        const SizedBox(height: 20),

                        // ── Abas inline (âncora para detectar sticky)
                        SizedBox(key: _keyTabs),
                        _DetailNavTabs(active: _activeTab, onTap: _onTabTap),
                        const SizedBox(height: 20),

                        // PERFIL
                        SizedBox(key: _keyPerfil, width: double.infinity),
                        _ProfileCard(
                          info:
                              player.profile ??
                              const PlayerProfileInfo(
                                pernaBoa: 'Direita',
                                fintas: 4,
                                pernaRuim: 4,
                              ),
                        ),
                        const SizedBox(height: 16),

                        // ESPECIALIDADES
                        SizedBox(
                          key: _keyEspecialidades,
                          width: double.infinity,
                        ),
                        _SpecialtiesCard(
                          specialties: player.specialties.isNotEmpty
                              ? player.specialties
                              : const [
                                  PlayerSpecialty(name: '#Driblador'),
                                  PlayerSpecialty(name: '#Esp. em bola parada'),
                                  PlayerSpecialty(name: '#Corredor'),
                                  PlayerSpecialty(name: '#Líder'),
                                ],
                        ),
                        const SizedBox(height: 16),

                        // FUNÇÕES
                        SizedBox(key: _keyFuncoes, width: double.infinity),
                        _RoleFunctionsCard(
                          roleFunctions: player.roleFunctions.isNotEmpty
                              ? player.roleFunctions
                              : const [
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
                                ],
                        ),
                        const SizedBox(height: 16),

                        // ESTILOS DE JOGO
                        SizedBox(key: _keyEstilos, width: double.infinity),
                        _PlaystylesCard(playstyles: player.playstyles),
                        const SizedBox(height: 16),

                        // CARACTERÍSTICAS (análise técnica)
                        SizedBox(
                          key: _keyCaracteristicas,
                          width: double.infinity,
                        ),
                        _TechnicalAnalysisCard(player: player),
                      ],
                    ),
                  ),

                  // ── Abas fixas (aparecem quando scrollar além delas)
                  if (_tabsSticky)
                    Positioned(
                      top: 0,
                      left: 20,
                      right: 20,
                      child: Container(
                        color: context.colors.backgroundDark,
                        child: _DetailNavTabs(
                          active: _activeTab,
                          onTap: _onTabTap,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── ABAS DE NAVEGAÇÃO ───────────────────────────────────────────────────────

class _DetailNavTabs extends StatelessWidget {
  final _DetailTab active;
  final ValueChanged<_DetailTab> onTap;

  const _DetailNavTabs({required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.colors.border, width: 1),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _DetailTabButton(
              label: 'PERFIL',
              selected: active == _DetailTab.perfil,
              onTap: () => onTap(_DetailTab.perfil),
            ),
            const SizedBox(width: 24),
            _DetailTabButton(
              label: 'ESPECIALIDADES',
              selected: active == _DetailTab.especialidades,
              onTap: () => onTap(_DetailTab.especialidades),
            ),
            const SizedBox(width: 24),
            _DetailTabButton(
              label: 'FUNÇÕES',
              selected: active == _DetailTab.funcoes,
              onTap: () => onTap(_DetailTab.funcoes),
            ),
            const SizedBox(width: 24),
            _DetailTabButton(
              label: 'ESTILOS',
              selected: active == _DetailTab.estilos,
              onTap: () => onTap(_DetailTab.estilos),
            ),
            const SizedBox(width: 24),
            _DetailTabButton(
              label: 'CARACTERÍSTICAS',
              selected: active == _DetailTab.caracteristicas,
              onTap: () => onTap(_DetailTab.caracteristicas),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailTabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DetailTabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: selected ? context.colors.accent : AppColors.muted,
                fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
                fontSize: 11,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 2,
              width: label.length * 7.0,
              decoration: BoxDecoration(
                color: selected ? context.colors.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
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
        color: context.colors.accentStrong,
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.backgroundDark, width: 5),
        boxShadow: [
          BoxShadow(
            color: context.colors.accentStrong.withValues(alpha: 0.55),
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
        color: context.colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.subtle),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.light,
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
            title: 'CONTRATO\nRESTANTE',
            value:
                '${player.contractUntil} '
                '${player.contractUntil == 1 ? 'ANO' : 'ANOS'}',
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
        color: context.colors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.muted,
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
            color: const Color(0xFF4FC3F7),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ContractRenewalPage(
                    player: player,
                    currentSalaryK: ContractRenewalPage.parseSalaryK(
                      player.salary,
                    ),
                    currentContractYears: player.contractUntil,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _PlayerActionButton(
            icon: Icons.sell_outlined,
            label: 'VENDER',
            color: context.colors.accent,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SellPlayerPage(player: player),
                ),
              );
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LoanPlayerPage(player: player),
                ),
              );
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReleasePlayerPage(player: player),
                ),
              );
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
            color: context.colors.cardAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.4)),
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
        color: context.colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.insert_chart_outlined,
                color: context.colors.accent,
                size: 18,
              ),
              SizedBox(width: 10),
              Text(
                'CARACTERÍSTICAS',
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
        ],
      ),
    );
  }
}

// ─── ESTILOS DE JOGO ────────────────────────────────────────────────────────

class _PlaystylesCard extends StatelessWidget {
  final List<PlayerPlaystyle> playstyles;

  const _PlaystylesCard({required this.playstyles});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.bolt, color: context.colors.accent, size: 18),
              SizedBox(width: 10),
              Text(
                'ESTILOS DE JOGO',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: playstyles.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) =>
                  _PlaystyleChip(playstyle: playstyles[index]),
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
      ..color = Color(0xFF00FF41).withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawPath(dataPath, glowPaint);

    final fillPaint = Paint()
      ..color = Color(0xFF00FF41).withValues(alpha: 0.16)
      ..style = PaintingStyle.fill;
    canvas.drawPath(dataPath, fillPaint);

    final strokePaint = Paint()
      ..color = Color(0xFF00FF41)
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
            color: AppColors.subtle,
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
            Container(width: 3, height: 14, color: context.colors.accent),
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
                      color: AppColors.subtle,
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

// ─── PERFIL (PERNA BOA / FINTAS / PERNA RUIM) ──────────────────────────────

class _ProfileCard extends StatelessWidget {
  final PlayerProfileInfo info;

  const _ProfileCard({required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star_outline, color: context.colors.accent, size: 18),
              SizedBox(width: 10),
              Text(
                'PERFIL',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              _ProfileItem(
                label: 'Perna boa',
                child: Text(
                  info.pernaBoa,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              _ProfileItem(
                label: 'Fintas',
                child: _StarRow(count: info.fintas),
              ),
              const SizedBox(height: 8),
              _ProfileItem(
                label: 'Perna ruim',
                child: _StarRow(count: info.pernaRuim),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  final String label;
  final Widget child;

  const _ProfileItem({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: context.colors.cardAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class _StarRow extends StatelessWidget {
  final int count;
  final int max;

  const _StarRow({required this.count}) : max = 5;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(max, (i) {
        final filled = i < count;
        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(
            filled ? Icons.star : Icons.star_border,
            size: 14,
            color: filled ? const Color(0xFFF5C518) : AppColors.muted,
          ),
        );
      }),
    );
  }
}

// ─── ESPECIALIDADES ─────────────────────────────────────────────────────────

class _SpecialtiesCard extends StatelessWidget {
  final List<PlayerSpecialty> specialties;

  const _SpecialtiesCard({required this.specialties});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.workspace_premium_outlined,
                color: context.colors.accent,
                size: 18,
              ),
              SizedBox(width: 10),
              Text(
                'ESPECIALIDADES',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 120,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: specialties
                    .map((s) => _SpecialtyRow(specialty: s))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecialtyRow extends StatelessWidget {
  final PlayerSpecialty specialty;

  const _SpecialtyRow({required this.specialty});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(width: 3, height: 14, color: context.colors.accent),
          const SizedBox(width: 10),
          Text(
            specialty.name,
            style: const TextStyle(
              color: AppColors.light,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── FUNÇÕES POR POSIÇÃO ────────────────────────────────────────────────────

class _RoleFunctionsCard extends StatelessWidget {
  final List<PlayerRoleFunction> roleFunctions;

  const _RoleFunctionsCard({required this.roleFunctions});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.grid_view_outlined,
                color: context.colors.accent,
                size: 18,
              ),
              SizedBox(width: 10),
              Text(
                'FUNÇÕES',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: roleFunctions
                    .map((rf) => _RoleFunctionColumn(role: rf))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleFunctionColumn extends StatelessWidget {
  final PlayerRoleFunction role;

  const _RoleFunctionColumn({required this.role});

  String get _levelSuffix {
    switch (role.level) {
      case FunctionLevel.plusPlus:
        return ' ++';
      case FunctionLevel.plus:
        return ' +';
      case FunctionLevel.normal:
        return '';
    }
  }

  Color get _levelColor {
    switch (role.level) {
      case FunctionLevel.plusPlus:
        return Colors.white;
      case FunctionLevel.plus:
        return Colors.white;
      case FunctionLevel.normal:
        return AppColors.subtle;
    }
  }

  // Color get _suffixColor {
  //   switch (role.level) {
  //     case FunctionLevel.plusPlus:
  //       return context.colors.accent;
  //     case FunctionLevel.plus:
  //       return context.colors.accent;
  //     case FunctionLevel.normal:
  //       return AppColors.muted;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final suffixColor = switch (role.level) {
      FunctionLevel.plusPlus => context.colors.accent,
      FunctionLevel.plus => context.colors.accent,
      FunctionLevel.normal => AppColors.muted,
    };

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nome da função com nível em destaque
            RichText(
              softWrap: false,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: role.functionName,
                    style: TextStyle(
                      color: _levelColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                  if (role.level != FunctionLevel.normal)
                    TextSpan(
                      text: _levelSuffix,
                      style: TextStyle(
                        color: suffixColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 6),

            // Badge da posição
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF1F6B3A),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                role.position,
                softWrap: false,
                style: TextStyle(
                  color: context.colors.accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.6,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Sub-funções
            for (final sub in role.subFunctions)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  sub,
                  softWrap: false,
                  style: const TextStyle(
                    color: AppColors.subtle,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
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
        color: context.colors.cardAlt,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.colors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(playstyle.icon, size: 14, color: AppColors.subtle),
          const SizedBox(width: 8),
          Text(
            playstyle.name,
            style: const TextStyle(
              color: AppColors.light,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
