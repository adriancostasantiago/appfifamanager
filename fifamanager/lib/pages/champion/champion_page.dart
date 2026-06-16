import 'dart:ui';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';
import 'package:fifamanager/core/theme/app_theme.dart';

class ChampionPage extends StatefulWidget {
  final String teamName;
  final int jogos;
  final int vitorias;
  final int gols;
  final String year;
  final String competitionLabel;
  final String imageTrophy;

  const ChampionPage({
    super.key,
    required this.teamName,
    required this.jogos,
    required this.vitorias,
    required this.gols,
    this.year = '',
    this.competitionLabel = '',
    required this.imageTrophy,
  });

  @override
  State<ChampionPage> createState() => _ChampionPageState();
}

class _ChampionPageState extends State<ChampionPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(
      duration: const Duration(days: 365),
    )..play();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // O colors.accent da tela usa a cor do grupo de troféu (passada pela TrophyRoomPage).
    // Fallback para colors.colors.accent (verde do tema) caso não seja informada.
    // final colors.accent = widget.colors.accentColor;

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          //----------------------------------------------------------
          // Glow de fundo — usa colors.accent do troféu
          //----------------------------------------------------------
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.7,
                  colors: [
                    colors.accent.withValues(alpha: 0.13),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          //----------------------------------------------------------
          // Confetti Esquerda
          //----------------------------------------------------------
          Align(
            alignment: Alignment.topLeft,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 1.0,
              emissionFrequency: 0.02,
              numberOfParticles: 4,
              gravity: 0.15,
              shouldLoop: true,
              maxBlastForce: 10,
              minBlastForce: 5,
              colors: const [
                Color.fromARGB(255, 224, 38, 32),
                Color.fromARGB(255, 48, 59, 216),
                Color.fromARGB(255, 214, 132, 8),
                Color.fromARGB(255, 224, 9, 243),
                Color.fromARGB(255, 16, 209, 41),
                Color.fromARGB(255, 222, 228, 223),
                Color.fromARGB(255, 206, 238, 26),
              ],
            ),
          ),

          //----------------------------------------------------------
          // Confetti Direita
          //----------------------------------------------------------
          Align(
            alignment: Alignment.topRight,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 2.2,
              emissionFrequency: 0.02,
              numberOfParticles: 4,
              gravity: 0.15,
              shouldLoop: true,
              maxBlastForce: 10,
              minBlastForce: 5,
              colors: const [
                Color.fromARGB(255, 224, 38, 32),
                Color.fromARGB(255, 48, 59, 216),
                Color.fromARGB(255, 214, 132, 8),
                Color.fromARGB(255, 224, 9, 243),
                Color.fromARGB(255, 16, 209, 41),
                Color.fromARGB(255, 222, 228, 223),
                Color.fromARGB(255, 206, 238, 26),
              ],
            ),
          ),

          //----------------------------------------------------------
          // Botão voltar
          //----------------------------------------------------------
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: colors.card,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: colors.accent),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.home),
                ),
              ),
            ),
          ),

          //----------------------------------------------------------
          // Conteúdo Principal
          //----------------------------------------------------------
          Center(
            child: SingleChildScrollView(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //--------------------------------------------------
                        // Badge da competição
                        //--------------------------------------------------
                        if (widget.competitionLabel.isNotEmpty ||
                            widget.year.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: colors.accent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(99),
                              border: Border.all(
                                color: colors.accent.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Text(
                              [
                                if (widget.competitionLabel.isNotEmpty)
                                  widget.competitionLabel,
                                if (widget.year.isNotEmpty) widget.year,
                              ].join(' • '),
                              style: TextStyle(
                                color: colors.accent,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],

                        //--------------------------------------------------
                        // TROFÉU
                        //--------------------------------------------------
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: colors.accent.withValues(alpha: 0.35),
                                blurRadius: 80,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            widget.imageTrophy,
                            height: MediaQuery.of(context).size.height * 0.38,
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(height: 15),

                        //--------------------------------------------------
                        // Título
                        //--------------------------------------------------
                        Text(
                          'PARABÉNS AO CAMPEÃO!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),

                        const SizedBox(height: 8),

                        //--------------------------------------------------
                        // Nome do Time
                        //--------------------------------------------------
                        Text(
                          widget.teamName.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.accent,
                            fontSize: 62,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                color: colors.accent.withValues(alpha: 0.67),
                                blurRadius: 15,
                              ),
                              Shadow(
                                color: colors.accent.withValues(alpha: 0.40),
                                blurRadius: 35,
                              ),
                              Shadow(
                                color: colors.accent.withValues(alpha: 0.20),
                                blurRadius: 60,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 15),

                        //--------------------------------------------------
                        // CARD ESTATÍSTICAS
                        //--------------------------------------------------
                        Container(
                          width: 340,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: colors.card,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: colors.border),
                                  boxShadow: colors.cardShadow,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'RESUMO DA TEMPORADA',
                                      style: TextStyle(
                                        color: colors.muted,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: _StatItem(
                                            value: widget.jogos.toString(),
                                            label: 'JOGOS',
                                            valueColor: colors.textPrimary,
                                            labelColor: colors.muted,
                                          ),
                                        ),
                                        Expanded(
                                          child: _StatItem(
                                            value: widget.vitorias.toString(),
                                            label: 'VITÓRIAS',
                                            // destaque com colors.accent do grupo
                                            valueColor: colors.accent,
                                            labelColor: colors.muted,
                                          ),
                                        ),
                                        Expanded(
                                          child: _StatItem(
                                            value: widget.gols.toString(),
                                            label: 'GOLS',
                                            valueColor: colors.textPrimary,
                                            labelColor: colors.muted,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          //----------------------------------------------------------
          // Botão Inferior
          //----------------------------------------------------------
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: SafeArea(
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.accent,
                    foregroundColor: colors.onAccent,
                    elevation: 20,
                    shadowColor: colors.accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AppRoutes.home),
                  child: Text(
                    'VOLTAR AO PAINEL',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── STAT ITEM ───────────────────────────────────────────────────────────────

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;
  final Color labelColor;

  const _StatItem({
    required this.value,
    required this.label,
    required this.valueColor,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
