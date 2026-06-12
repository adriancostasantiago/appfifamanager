import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';

class AppBottomNavigation extends StatelessWidget {
  final String activeRoute;

  const AppBottomNavigation({super.key, required this.activeRoute});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF101314),
        border: Border(top: BorderSide(color: Color(0xFF1F2327), width: 1)),
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
            active: false,
            onTap: () {},
          ),
          _NavigationLink(
            icon: Icons.card_giftcard,
            label: 'PATROCÍNIOS',
            active: false,
            onTap: () {},
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
    final color = active ? const Color(0xFF00FF41) : const Color(0xFF7C8579);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
