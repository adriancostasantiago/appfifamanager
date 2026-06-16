import 'package:fifamanager/pages/settings/edit_club_page.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:fifamanager/core/theme/theme_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'CONFIGURAÇÕES',
          style: TextStyle(
            color: colors.accent,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          children: [
            // ── APARÊNCIA ───────────────────────────────────────────────────
            _SectionHeader(label: 'APARÊNCIA'),
            _SettingsCard(
              children: [
                _ToggleTile(
                  icon: themeController.isDark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  label: 'TEMA ESCURO',
                  subtitle: themeController.isDark ? 'Ativado' : 'Desativado',
                  value: themeController.isDark,
                  onChanged: (_) {
                    themeController.toggleTheme();
                    setState(() {});
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── PERFIL ──────────────────────────────────────────────────────
            _SectionHeader(label: 'PERFIL'),
            _SettingsCard(
              children: [
                _NavTile(
                  icon: Icons.person_outline,
                  label: 'EDITAR PERFIL',
                  subtitle: 'Nome, contato e foto',
                  onTap: () {},
                ),
                _Divider(),
                _NavTile(
                  icon: Icons.shield_outlined,
                  label: 'MEU CLUBE',
                  subtitle: 'APEX SC',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditClubPage()),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── JOGO ────────────────────────────────────────────────────────
            _SectionHeader(label: 'JOGO'),
            _SettingsCard(
              children: [
                _NavTile(
                  icon: Icons.sports_soccer_outlined,
                  label: 'TEMPORADA ATUAL',
                  subtitle: 'Temporada 2024',
                  onTap: () {},
                ),
                _Divider(),
                _NavTile(
                  icon: Icons.emoji_events_outlined,
                  label: 'LIGAS ATIVAS',
                  subtitle: 'Liga Pro · Copa Regional',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── DADOS ────────────────────────────────────────────────────────
            _SectionHeader(label: 'DADOS'),
            _SettingsCard(
              children: [
                _NavTile(
                  icon: Icons.upload_outlined,
                  label: 'EXPORTAR DADOS',
                  subtitle: 'Salvar backup',
                  onTap: () {},
                ),
                _Divider(),
                _NavTile(
                  icon: Icons.download_outlined,
                  label: 'IMPORTAR DADOS',
                  subtitle: 'Restaurar backup',
                  onTap: () {},
                ),
                _Divider(),
                _NavTile(
                  icon: Icons.delete_outline,
                  label: 'LIMPAR DADOS',
                  subtitle: 'Reiniciar temporada',
                  onTap: () {},
                  destructive: true,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ── SOBRE ────────────────────────────────────────────────────────
            _SectionHeader(label: 'SOBRE'),
            _SettingsCard(
              children: [
                _InfoTile(
                  icon: Icons.info_outline,
                  label: 'VERSÃO',
                  value: 'FCMANAGER V2.4',
                ),
              ],
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ── COMPONENTES INTERNOS ──────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Row(
        children: [
          Container(width: 3, height: 16, color: colors.accent),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: colors.muted,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
        boxShadow: colors.cardShadow,
      ),
      child: Column(children: children),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: context.colors.divider,
      height: 1,
      thickness: 1,
      indent: 54,
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: colors.accentBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: colors.accent, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: colors.muted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: colors.accent,
            activeTrackColor: colors.accent.withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;
  final bool destructive;

  const _NavTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = destructive ? colors.red : colors.textPrimary;
    final bgColor = destructive ? colors.redBg : colors.accentBg;
    final iconColor = destructive ? colors.red : colors.accent;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: colors.muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: colors.muted, size: 20),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: colors.accentBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: colors.accent, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: colors.muted,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
