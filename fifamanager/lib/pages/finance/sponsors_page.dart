import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';
import 'package:fifamanager/models/models.dart';
import 'package:fifamanager/core/theme/app_colors.dart';
import 'package:fifamanager/widgets/app_bottom_navigation.dart';
import 'package:fifamanager/widgets/app_drawer.dart';

const SponsorPageData sampleSponsorData = SponsorPageData(
  receitaTotal: '€77M/ano',
  receitaMensal: '€6.4M/mês',
  totalPatrocinadores: 6,
  vencendoEm6Meses: 2,
  patrocinadores: [
    SponsorData(
      name: 'Nike',
      categoria: 'MATERIAL ESPORTIVO',
      valorAnual: '€30M',
      contratoAnos: 3,
      status: SponsorStatus.ativo,
      icon: Icons.checkroom_outlined,
    ),
    SponsorData(
      name: 'Spotify',
      categoria: 'NAMING RIGHTS',
      valorAnual: '€20M',
      contratoAnos: 1,
      status: SponsorStatus.vencendo,
      icon: Icons.music_note_outlined,
    ),
    SponsorData(
      name: 'Rakuten',
      categoria: 'PRINCIPAL',
      valorAnual: '€12M',
      contratoAnos: 2,
      status: SponsorStatus.ativo,
      icon: Icons.shopping_bag_outlined,
    ),
    SponsorData(
      name: 'Stanley',
      categoria: 'BEBIDAS',
      valorAnual: '€8M',
      contratoAnos: 1,
      status: SponsorStatus.vencendo,
      icon: Icons.local_drink_outlined,
    ),
    SponsorData(
      name: 'Audi',
      categoria: 'MOBILIDADE',
      valorAnual: '€5M',
      contratoAnos: 3,
      status: SponsorStatus.ativo,
      icon: Icons.directions_car_outlined,
    ),
    SponsorData(
      name: 'Estrella Damm',
      categoria: 'BEBIDAS OFICIAIS',
      valorAnual: '€2M',
      contratoAnos: 0,
      status: SponsorStatus.expirado,
      icon: Icons.sports_bar_outlined,
    ),
  ],
  oportunidades: [
    SponsorData(
      name: 'Globo',
      categoria: 'MÍDIA',
      valorAnual: '€15M est.',
      contratoAnos: 0,
      status: SponsorStatus.ativo,
      icon: Icons.tv_outlined,
    ),
    SponsorData(
      name: 'Emirates',
      categoria: 'AVIAÇÃO',
      valorAnual: '€22M est.',
      contratoAnos: 0,
      status: SponsorStatus.ativo,
      icon: Icons.flight_outlined,
    ),
    SponsorData(
      name: 'Mastercard',
      categoria: 'FINANCEIRO',
      valorAnual: '€10M est.',
      contratoAnos: 0,
      status: SponsorStatus.ativo,
      icon: Icons.credit_card_outlined,
    ),
  ],
);

// ─── PÁGINA ──────────────────────────────────────────────────────────────────

class SponsorsPage extends StatefulWidget {
  const SponsorsPage({super.key});

  @override
  State<SponsorsPage> createState() => _SponsorsPageState();
}

class _SponsorsPageState extends State<SponsorsPage> {
  final SponsorPageData data = sampleSponsorData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'FC MANAGER',
          style: TextStyle(
            color: AppColors.accent,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ),
      drawer: const AppDrawer(activeRoute: AppRoutes.sponsors),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Resumo de receita
                    _ReceitaResumo(data: data),
                    const SizedBox(height: 24),

                    // Patrocinadores ativos
                    _SectionTitle(
                      icon: Icons.handshake_outlined,
                      title: 'PATROCINADORES ATIVOS',
                      badge: data.totalPatrocinadores.toString(),
                    ),
                    const SizedBox(height: 14),

                    if (data.vencendoEm6Meses > 0)
                      _AlertBanner(
                        message:
                            '${data.vencendoEm6Meses} contrato${data.vencendoEm6Meses > 1 ? 's' : ''} vencendo nos próximos 6 meses.',
                      ),

                    const SizedBox(height: 12),

                    ...data.patrocinadores.map(
                      (s) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _SponsorCard(sponsor: s),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Oportunidades (novos patrocinadores)
                    _SectionTitle(
                      icon: Icons.search,
                      title: 'BUSCAR NOVOS PATROCINADORES',
                      badge: data.oportunidades.length.toString(),
                    ),
                    const SizedBox(height: 14),

                    ...data.oportunidades.map(
                      (s) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _OpportunityCard(sponsor: s),
                      ),
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const AppBottomNavigation(activeRoute: AppRoutes.sponsors),
          ],
        ),
      ),
    );
  }
}

// ─── RESUMO DE RECEITA ────────────────────────────────────────────────────────

class _ReceitaResumo extends StatelessWidget {
  final SponsorPageData data;

  const _ReceitaResumo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _ResumoBox(
                  label: 'RECEITA ANUAL',
                  value: data.receitaTotal,
                  color: AppColors.accent,
                  icon: Icons.monetization_on_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ResumoBox(
                  label: 'RECEITA MENSAL',
                  value: data.receitaMensal,
                  color: AppColors.blue,
                  icon: Icons.calendar_month_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ResumoBox(
                  label: 'PATROCINADORES',
                  value: data.totalPatrocinadores.toString(),
                  color: AppColors.light,
                  icon: Icons.groups_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ResumoBox(
                  label: 'VENCENDO EM BREVE',
                  value: data.vencendoEm6Meses.toString(),
                  color: data.vencendoEm6Meses > 0 ? AppColors.orange : AppColors.subtle,
                  icon: Icons.schedule_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResumoBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _ResumoBox({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.muted, size: 12),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 17,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── SECTION TITLE ────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? badge;

  const _SectionTitle({required this.icon, required this.title, this.badge});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 4, height: 22, color: AppColors.accent),
        const SizedBox(width: 12),
        Icon(icon, color: AppColors.accent, size: 16),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.light,
            fontWeight: FontWeight.w900,
            fontSize: 13,
            letterSpacing: 1.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        if (badge != null) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.cardAlt,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              badge!,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ─── ALERTA ───────────────────────────────────────────────────────────────────

class _AlertBanner extends StatelessWidget {
  final String message;

  const _AlertBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.orange.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.orange.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          const Icon(Icons.schedule_outlined, color: AppColors.orange, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.orange,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── CARD DO PATROCINADOR ─────────────────────────────────────────────────────

class _SponsorCard extends StatelessWidget {
  final SponsorData sponsor;

  const _SponsorCard({required this.sponsor});

  Color get _statusColor {
    switch (sponsor.status) {
      case SponsorStatus.ativo:
        return AppColors.accent;
      case SponsorStatus.vencendo:
        return AppColors.orange;
      case SponsorStatus.expirado:
        return AppColors.red;
    }
  }

  String get _statusLabel {
    switch (sponsor.status) {
      case SponsorStatus.ativo:
        return 'ATIVO';
      case SponsorStatus.vencendo:
        return 'VENCENDO';
      case SponsorStatus.expirado:
        return 'EXPIRADO';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: color.withValues(alpha: .3)),
                ),
                child: Icon(sponsor.icon, color: color, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sponsor.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      sponsor.categoria,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    sponsor.valorAnual,
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: color.withValues(alpha: .4)),
                    ),
                    child: Text(
                      _statusLabel,
                      style: TextStyle(
                        color: color,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          if (sponsor.status != SponsorStatus.expirado) ...[
            const SizedBox(height: 14),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.event_note_outlined, size: 13, color: AppColors.muted),
                const SizedBox(width: 6),
                Text(
                  '${sponsor.contratoAnos} ${sponsor.contratoAnos == 1 ? 'ano restante' : 'anos restantes'}',
                  style: const TextStyle(
                    color: AppColors.subtle,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                _ActionButton(
                  label: 'RENOVAR',
                  icon: Icons.autorenew,
                  color: color,
                  onTap: () {
                    // TODO: navegar para tela de renovação de patrocínio
                  },
                ),
              ],
            ),
          ] else ...[
            const SizedBox(height: 14),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.warning_amber_outlined, size: 13, color: AppColors.red),
                const SizedBox(width: 6),
                const Text(
                  'Contrato expirado',
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                _ActionButton(
                  label: 'NEGOCIAR',
                  icon: Icons.handshake_outlined,
                  color: AppColors.blue,
                  onTap: () {
                    // TODO: navegar para tela de nova negociação
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ─── CARD DE OPORTUNIDADE ─────────────────────────────────────────────────────

class _OpportunityCard extends StatelessWidget {
  final SponsorData sponsor;

  const _OpportunityCard({required this.sponsor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.cardAlt,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(sponsor.icon, color: AppColors.subtle, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sponsor.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  sponsor.categoria,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                sponsor.valorAnual,
                style: const TextStyle(
                  color: AppColors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 6),
              _ActionButton(
                label: 'CONTATAR',
                icon: Icons.send_outlined,
                color: AppColors.blue,
                onTap: () {
                  // TODO: navegar para tela de proposta de patrocínio
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── BOTÃO DE AÇÃO ────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: color.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withValues(alpha: .4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: color),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
