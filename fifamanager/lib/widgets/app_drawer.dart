import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  final String activeRoute;

  const AppDrawer({super.key, required this.activeRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF101314),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF00FF41),
                          width: 2,
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Color(0xFF121414),
                        child: Icon(
                          Icons.person,
                          size: 42,
                          color: Color(0xFF00FF41),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'MARCUS RIVERA',
                      style: TextStyle(
                        color: Color(0xFF00FF41),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'APEX SC',
                      style: TextStyle(
                        color: Color(0xFF7C8579),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _DrawerLink(
                icon: Icons.grid_view,
                label: 'PAINEL',
                route: AppRoutes.home,
                active: activeRoute == AppRoutes.home,
              ),
              _DrawerLink(
                icon: Icons.emoji_events,
                label: 'LIGAS',
                route: AppRoutes.leagues,
                active: activeRoute == AppRoutes.leagues,
              ),
              _DrawerLink(
                icon: Icons.group,
                label: 'ELENCO',
                route: AppRoutes.squad,
                active: activeRoute == AppRoutes.squad,
              ), //TR
              _DrawerLink(
                icon: Icons.attach_money,
                label: 'FINANCEIRO',
                route: null,
              ),
              _DrawerLink(
                icon: Icons.card_giftcard,
                label: 'PATROCÍNIOS',
                route: null,
              ),
              _DrawerLink(
                icon: Icons.military_tech,
                label: 'SALA DE TROFÉUS',
                route: AppRoutes.trophies,
                active: activeRoute == AppRoutes.trophies,
              ),
              const Divider(color: Color(0xFF1F2327), height: 38, thickness: 1),
              _DrawerLink(icon: Icons.settings, label: 'SETTINGS', route: null),
              const Spacer(),
              const Text(
                'FCMANAGER V2.4',
                style: TextStyle(
                  color: Color(0xFF00FF41),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? route;
  final bool active;

  const _DrawerLink({
    required this.icon,
    required this.label,
    required this.route,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final itemColor = active
        ? const Color(0xFF00FF41)
        : const Color(0xFF7C8579);

    return InkWell(
      onTap: () {
        Navigator.pop(context);
        if (route != null && route != ModalRoute.of(context)?.settings.name) {
          Navigator.pushReplacementNamed(context, route!);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Row(
          children: [
            Icon(icon, color: itemColor, size: 20),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                color: itemColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
