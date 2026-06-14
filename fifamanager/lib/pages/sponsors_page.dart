import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';
import 'package:fifamanager/widgets/app_bottom_navigation.dart';
import 'package:fifamanager/widgets/app_drawer.dart';

// ─── PALETA ──────────────────────────────────────────────────────────────────

const _kBackground = Color(0xFF101314);
const _kCard = Color(0xFF16191D);
const _kCardAlt = Color(0xFF1A1E22);
const _kBorder = Color(0xFF1F2327);
const _kAccent = Color(0xFF00FF41);
const _kMuted = Color(0xFF7C8579);
const _kSubtle = Color(0xFF9AA39C);
const _kLight = Color(0xFFD7E2D1);
const _kRed = Color(0xFFE53935);
const _kOrange = Color(0xFFFFB74D);
const _kBlue = Color(0xFF4FC3F7);

// ─── MODELOS ─────────────────────────────────────────────────────────────────

enum SponsorStatus { ativo, vencendo, expirado }

class SponsorData {
  final String name;
  final String categoria;
  final String valorAnual;
  final int contratoAnos;           // anos restantes
  final SponsorStatus status;
  final IconData icon;

  const SponsorData({
    required this.name,
    required this.categoria,
    required this.valorAnual,
    required this.contratoAnos,
    required this.status,
    required this.icon,
  });
}

class SponsorPageData {
  final String receitaTotal;
  final String receitaMensal;
  final int totalPatrocinadores;
  final int vencendoEm6Meses;
  final List<SponsorData> patrocinadores;
  final List<SponsorData> oportunidades;

  const SponsorPageData({
    required this.receitaTotal,
    required this.receitaMensal,
    required this.totalPatrocinadores,
    required this.vencendoEm6Meses,
    required this.patrocinadores,
    required this.oportunidades,
  });
}

// ─── DADOS MOCKADOS ───────────────────────────────────────────────────────────

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
      backgroundColor: _kBackground,
      appBar: AppBar(
        backgroundColor: _kBackground,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'FC MANAGER',
          style: TextStyle(
            color: _kAccent,
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
        color: _kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _ResumoBox(
                  label: 'RECEITA ANUAL',
                  value: data.receitaTotal,
                  color: _kAccent,
                  icon: Icons.monetization_on_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ResumoBox(
                  label: 'RECEITA MENSAL',
                  value: data.receitaMensal,
                  color: _kBlue,
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
                  color: _kLight,
                  icon: Icons.groups_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ResumoBox(
                  label: 'VENCENDO EM BREVE',
                  value: data.vencendoEm6Meses.toString(),
                  color: data.vencendoEm6Meses > 0 ? _kOrange : _kSubtle,
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

  const _ResumoBox({required this.label, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCardAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: _kMuted, size: 12),
              const SizedBox(width: 5),
              Expanded(
                child: Text(label,
                    style: const TextStyle(
                        color: _kMuted, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.6)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 17, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
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
        Container(width: 4, height: 22, color: _kAccent),
        const SizedBox(width: 12),
        Icon(icon, color: _kAccent, size: 16),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: _kLight,
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
              color: _kCardAlt,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _kBorder),
            ),
            child: Text(badge!,
                style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w700)),
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
        color: _kOrange.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kOrange.withOpacity(0.35)),
      ),
      child: Row(
        children: [
          const Icon(Icons.schedule_outlined, color: _kOrange, size: 16),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                  color: _kOrange, fontSize: 11, fontWeight: FontWeight.w700, height: 1.4),
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
        return _kAccent;
      case SponsorStatus.vencendo:
        return _kOrange;
      case SponsorStatus.expirado:
        return _kRed;
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
        color: _kCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: color.withOpacity(0.3)),
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
                          color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 3),
                    Text(sponsor.categoria,
                        style: const TextStyle(
                            color: _kMuted, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(sponsor.valorAnual,
                      style: const TextStyle(
                          color: _kAccent, fontSize: 16, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: color.withOpacity(0.4)),
                    ),
                    child: Text(_statusLabel,
                        style: TextStyle(
                            color: color, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                  ),
                ],
              ),
            ],
          ),

          if (sponsor.status != SponsorStatus.expirado) ...[
            const SizedBox(height: 14),
            const Divider(height: 1, color: _kBorder),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.event_note_outlined, size: 13, color: _kMuted),
                const SizedBox(width: 6),
                Text(
                  '${sponsor.contratoAnos} ${sponsor.contratoAnos == 1 ? 'ano restante' : 'anos restantes'}',
                  style: const TextStyle(color: _kSubtle, fontSize: 11, fontWeight: FontWeight.w700),
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
            const Divider(height: 1, color: _kBorder),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.warning_amber_outlined, size: 13, color: _kRed),
                const SizedBox(width: 6),
                const Text('Contrato expirado',
                    style: TextStyle(color: _kRed, fontSize: 11, fontWeight: FontWeight.w700)),
                const Spacer(),
                _ActionButton(
                  label: 'NEGOCIAR',
                  icon: Icons.handshake_outlined,
                  color: _kBlue,
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
        color: _kCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _kCardAlt,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kBorder),
            ),
            child: Icon(sponsor.icon, color: _kSubtle, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sponsor.name,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900)),
                const SizedBox(height: 3),
                Text(sponsor.categoria,
                    style: const TextStyle(
                        color: _kMuted, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(sponsor.valorAnual,
                  style: const TextStyle(
                      color: _kBlue, fontSize: 13, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
              const SizedBox(height: 6),
              _ActionButton(
                label: 'CONTATAR',
                icon: Icons.send_outlined,
                color: _kBlue,
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
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withOpacity(0.4)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 12, color: color),
              const SizedBox(width: 5),
              Text(label,
                  style: TextStyle(
                      color: color, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.4)),
            ],
          ),
        ),
      ),
    );
  }
}
