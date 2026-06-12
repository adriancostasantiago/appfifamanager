// champion_screen.dart

import 'dart:ui';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';

class ChampionScreen extends StatefulWidget {
  final String teamName;
  final int jogos;
  final int vitorias;
  final int gols;

  const ChampionScreen({
    super.key,
    required this.teamName,
    required this.jogos,
    required this.vitorias,
    required this.gols,
  });

  @override
  State<ChampionScreen> createState() => _ChampionScreenState();
}

class _ChampionScreenState extends State<ChampionScreen>
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
    return Scaffold(
      backgroundColor: const Color(0xFF121414),
      body: Stack(
        children: [
          //----------------------------------------------------------
          // Glow de fundo
          //----------------------------------------------------------
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.7,
                  colors: [Color(0x2200FF41), Colors.transparent],
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
                Color(0xFF72FF70),
                Color(0xFF00FF41),
                Colors.white,
                Colors.amber,
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
                Color(0xFF72FF70),
                Color(0xFF00FF41),
                Colors.white,
                Colors.amber,
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
                backgroundColor: Colors.white.withValues(alpha: 0.05),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF72FF70)),
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
                        // TROFÉU
                        //--------------------------------------------------
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF00FF41,
                                ).withValues(alpha: 0.35),
                                blurRadius: 80,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/trophy.png',
                            height: MediaQuery.of(context).size.height * 0.38,
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(height: 15),

                        //--------------------------------------------------
                        // Título
                        //--------------------------------------------------
                        const Text(
                          'PARABÉNS AO CAMPEÃO!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
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
                          style: const TextStyle(
                            color: Color(0xFF72FF70),
                            fontSize: 62,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(color: Color(0xAA00FF41), blurRadius: 15),
                              Shadow(color: Color(0x6600FF41), blurRadius: 35),
                              Shadow(color: Color(0x3300FF41), blurRadius: 60),
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
                                  color: Colors.white.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.08),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'RESUMO DA TEMPORADA',
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.7,
                                        ),
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
                                          ),
                                        ),
                                        Expanded(
                                          child: _StatItem(
                                            value: widget.vitorias.toString(),
                                            label: 'VITÓRIAS',
                                            valueColor: const Color(0xFF72FF70),
                                          ),
                                        ),
                                        Expanded(
                                          child: _StatItem(
                                            value: widget.gols.toString(),
                                            label: 'GOLS',
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
                    backgroundColor: const Color(0xFF00FF41),
                    foregroundColor: const Color(0xFF003907),
                    elevation: 20,
                    shadowColor: const Color(0xFF00FF41),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.home);
                  },
                  child: const Text(
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

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color? valueColor;

  const _StatItem({required this.value, required this.label, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
