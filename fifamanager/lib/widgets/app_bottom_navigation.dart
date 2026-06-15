import 'package:flutter/material.dart';
import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:fifamanager/routes/app_routes.dart';

class AppBottomNavigation extends StatelessWidget {
  final String activeRoute;

  const AppBottomNavigation({super.key, required this.activeRoute});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Container(
      decoration: BoxDecoration(
        color: c.card,
        border: Border(top: BorderSide(color: c.border, width: 1)),
        boxShadow: c.cardShadow,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavigationLink(
            icon: Icons.dashboard,
            label: 'PAINEL',
            active: activeRoute == AppRoutes.home,
            onTap: () {
              if (activeRoute != AppRoutes.home) {
                Navigator.pushReplacementNamed(context, AppRoutes.home);
              }
            },
          ),
          _NavigationLink(
            icon: Icons.emoji_events,
            label: 'LIGAS',
            active: activeRoute == AppRoutes.leagues,
            onTap: () {
              if (activeRoute != AppRoutes.leagues) {
                Navigator.pushReplacementNamed(context, AppRoutes.leagues);
              }
            },
          ),
          _NavigationLink(
            icon: Icons.group,
            label: 'ELENCO',
            active: activeRoute == AppRoutes.squad,
            onTap: () {
              if (activeRoute != AppRoutes.squad) {
                Navigator.pushReplacementNamed(context, AppRoutes.squad);
              }
            },
          ),
          _NavigationLink(
            icon: Icons.attach_money,
            label: 'FINANCEIRO',
            active: activeRoute == AppRoutes.finance,
            onTap: () {
              if (activeRoute != AppRoutes.finance) {
                Navigator.pushReplacementNamed(context, AppRoutes.finance);
              }
            },
          ),
          _NavigationLink(
            icon: Icons.card_giftcard,
            label: 'PATROCÍNIOS',
            active: activeRoute == AppRoutes.sponsors,
            onTap: () {
              if (activeRoute != AppRoutes.sponsors) {
                Navigator.pushReplacementNamed(context, AppRoutes.sponsors);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _NavigationLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavigationLink({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final color = active ? c.accent : c.muted;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (active)
            Container(
              width: 4,
              height: 4,
              margin: const EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: c.accent,
                shape: BoxShape.circle,
              ),
            )
          else
            const SizedBox(height: 8),
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
