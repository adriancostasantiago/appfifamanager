import 'dart:async';
import 'dart:math';
import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';
import 'package:fifamanager/widgets/app_brand_logo.dart';
import 'package:fifamanager/core/theme/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ringController;

  @override
  void initState() {
    super.initState();
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    Timer(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    });
  }

  @override
  void dispose() {
    _ringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _SplashBackground(),
          _SplashOverlay(),
          _SplashTexture(),
          _SplashContent(),
        ],
      ),
    );
  }
}

class _SplashBackground extends StatelessWidget {
  const _SplashBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: context.colors.backgroundDark),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            'assets/splash_bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
        ),
      ],
    );
  }
}

class _SplashOverlay extends StatelessWidget {
  const _SplashOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [context.colors.backgroundDark, Colors.transparent],
                  stops: [0.0, 0.45],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.2),
                  radius: 0.7,
                  colors: [
                    context.colors.accent.withValues(alpha: 0.14),
                    Colors.transparent,
                  ],
                  stops: const [0, 1],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashTexture extends StatelessWidget {
  const _SplashTexture();

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: CustomPaint(painter: _TexturePainter()),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Spacer(),
        _SplashLogoSection(),
        Spacer(),
        _SplashLoadingFooter(),
      ],
    );
  }
}

class _SplashLogoSection extends StatelessWidget {
  const _SplashLogoSection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _SplashRing(),
                _SplashGlowCircle(),
                const AppBrandLogo(size: 132, showLabel: false),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const _SplashTitle(),
          const SizedBox(height: 16),
          const Text(
            'SEU CLUBE',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              letterSpacing: 1.8,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'SUAS REGRAS',
            style: TextStyle(
              color: context.colors.accent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashRing extends StatefulWidget {
  const _SplashRing();

  @override
  State<_SplashRing> createState() => _SplashRingState();
}

class _SplashRingState extends State<_SplashRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: Container(
        width: 210,
        height: 210,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: context.colors.accent.withValues(alpha: 0.20),
            width: 3,
          ),
        ),
      ),
    );
  }
}

class _SplashGlowCircle extends StatelessWidget {
  const _SplashGlowCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 172,
      height: 172,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [context.colors.accentLight, context.colors.accentDark],
          center: Alignment.center,
          radius: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: context.colors.accent.withValues(alpha: 0.24),
            blurRadius: 36,
            spreadRadius: 8,
          ),
        ],
      ),
    );
  }
}

class _SplashTitle extends StatelessWidget {
  const _SplashTitle();

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'FC',
            style: TextStyle(
              color: context.colors.accent,
              fontSize: 34,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          TextSpan(
            text: 'MANAGER',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashLoadingFooter extends StatelessWidget {
  const _SplashLoadingFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: CircularProgressIndicator(
              color: context.colors.accent,
              strokeWidth: 4,
            ),
          ),
          SizedBox(height: 18),
          Text(
            'CARREGANDO...',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _TexturePainter extends CustomPainter {
  const _TexturePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.03);
    const step = 28.0;
    for (var y = 0.0; y < size.height; y += step) {
      for (var x = 0.0; x < size.width; x += step) {
        canvas.drawCircle(Offset(x + step * 0.5, y + step * 0.5), 0.6, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
