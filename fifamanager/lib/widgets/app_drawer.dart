import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:fifamanager/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  final String activeRoute;

  const AppDrawer({super.key, required this.activeRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.colors.background,
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
                          color: context.colors.accent,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: context.colors.backgroundDark,
                        child: Icon(
                          Icons.person,
                          size: 42,
                          color: context.colors.accent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'MARCUS RIVERA',
                      style: TextStyle(
                        color: context.colors.accent,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'APEX SC',
                      style: TextStyle(
                        color: context.colors.muted,
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
              ),
              _DrawerLink(
                icon: Icons.attach_money,
                label: 'FINANCEIRO',
                route: AppRoutes.finance,
                active: activeRoute == AppRoutes.finance,
              ),
              _DrawerLink(
                icon: Icons.card_giftcard,
                label: 'PATROCÍNIOS',
                route: AppRoutes.sponsors,
                active: activeRoute == AppRoutes.sponsors,
              ),
              _DrawerLink(
                icon: Icons.military_tech,
                label: 'SALA DE TROFÉUS',
                route: AppRoutes.trophies,
                active: activeRoute == AppRoutes.trophies,
              ),
              Divider(color: context.colors.border, height: 38, thickness: 1),
              _DrawerLink(
                icon: Icons.settings,
                label: 'CONFIGURAÇÕES',
                route: null,
                onTapOverride: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  );
                },
              ),
              const Spacer(),
              Text(
                'FCMANAGER V2.4',
                style: TextStyle(
                  color: context.colors.accent,
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
  final VoidCallback? onTapOverride;

  const _DrawerLink({
    required this.icon,
    required this.label,
    required this.route,
    this.active = false,
    this.onTapOverride,
  });

  @override
  Widget build(BuildContext context) {
    final itemColor = active ? context.colors.accent : context.colors.muted;

    return InkWell(
      onTap:
          onTapOverride ??
          () {
            Navigator.pop(context);
            if (route != null &&
                route != ModalRoute.of(context)?.settings.name) {
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
