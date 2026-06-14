import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';
import 'package:fifamanager/models/models.dart';
import 'package:fifamanager/core/theme/app_colors.dart';
import 'package:fifamanager/widgets/app_bottom_navigation.dart';
import 'package:fifamanager/widgets/app_drawer.dart';
import '../finance/sponsors_page.dart';

final FinanceData sampleFinanceData = FinanceData(
  orcamentoTotal: '€250M',
  orcamentoGasto: '€163M',
  orcamentoPercent: 0.65,

  receitaTotal: '€520M',
  despesaTotal: '€431M',
  saldo: '+€89M',
  saldoPositivo: true,

  folhaSalarial: '€4.1M/sem',
  folhaMensal: '€17.8M/mês',

  valorMercadoElenco: '€982M',
  valorMercadoMedia: '€35.1M',

  patrocinioReceita: '€77M/ano',
  patrocinioTotal: 6,
  patrocinioVencendo: 2,

  receitas: const [
    FinanceItem(
      label: 'Bilheteria',
      value: '€48M',
      icon: Icons.stadium_outlined,
    ),
    FinanceItem(
      label: 'TV & Direitos',
      value: '€210M',
      icon: Icons.tv_outlined,
    ),
    FinanceItem(
      label: 'Transferências',
      value: '€185M',
      icon: Icons.swap_horiz,
    ),
    FinanceItem(
      label: 'Patrocínios',
      value: '€77M',
      icon: Icons.handshake_outlined,
    ),
  ],
  despesas: const [
    FinanceItem(
      label: 'Folha salarial',
      value: '€213M',
      icon: Icons.payments_outlined,
    ),
    FinanceItem(
      label: 'Compras',
      value: '€163M',
      icon: Icons.shopping_cart_outlined,
    ),
    FinanceItem(
      label: 'Infraestrutura',
      value: '€32M',
      icon: Icons.business_outlined,
    ),
    FinanceItem(label: 'Outros', value: '€23M', icon: Icons.more_horiz),
  ],
  transferencias: const [
    TransferItem(
      player: 'Raphinha',
      tipo: 'COMPRA',
      valor: '€58M',
      data: 'Jul 2024',
      entrada: false,
    ),
    TransferItem(
      player: 'Dani Olmo',
      tipo: 'COMPRA',
      valor: '€55M',
      data: 'Jul 2024',
      entrada: false,
    ),
    TransferItem(
      player: 'Ansu Fati',
      tipo: 'VENDA',
      valor: '€20M',
      data: 'Jan 2024',
      entrada: true,
    ),
    TransferItem(
      player: 'Memphis Depay',
      tipo: 'VENDA',
      valor: '€8M',
      data: 'Jun 2023',
      entrada: true,
    ),
    TransferItem(
      player: 'Vitor Roque',
      tipo: 'EMPRÉSTIMO',
      valor: '€6M',
      data: 'Jan 2024',
      entrada: true,
    ),
    TransferItem(
      player: 'Ferran Torres',
      tipo: 'EMPRÉSTIMO',
      valor: '€4M',
      data: 'Ago 2024',
      entrada: true,
    ),
  ],
);

// ─── PÁGINA ──────────────────────────────────────────────────────────────────

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  final FinanceData data = sampleFinanceData;

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
      drawer: const AppDrawer(activeRoute: AppRoutes.finance),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Orçamento da temporada
                    _SectionTitle(
                      icon: Icons.account_balance_outlined,
                      title: 'ORÇAMENTO DA TEMPORADA',
                    ),
                    const SizedBox(height: 14),
                    _OrcamentoCard(data: data),

                    const SizedBox(height: 24),

                    // Balanço geral
                    _SectionTitle(
                      icon: Icons.bar_chart,
                      title: 'BALANÇO GERAL',
                    ),
                    const SizedBox(height: 14),
                    _BalancoCard(data: data),

                    const SizedBox(height: 24),

                    // Receitas e Despesas
                    _SectionTitle(
                      icon: Icons.swap_vert,
                      title: 'RECEITAS & DESPESAS',
                    ),
                    const SizedBox(height: 14),
                    _ReceitasDespesasCard(data: data),

                    const SizedBox(height: 24),

                    // Folha salarial
                    _SectionTitle(
                      icon: Icons.payments_outlined,
                      title: 'FOLHA SALARIAL',
                    ),
                    const SizedBox(height: 14),
                    _FolhaCard(data: data),

                    const SizedBox(height: 24),

                    // Valor de mercado
                    _SectionTitle(
                      icon: Icons.trending_up,
                      title: 'VALOR DE MERCADO DO ELENCO',
                    ),
                    const SizedBox(height: 14),
                    _ValorMercadoCard(data: data),

                    const SizedBox(height: 24),

                    // Patrocínios (atalho)
                    _SectionTitle(
                      icon: Icons.handshake_outlined,
                      title: 'PATROCÍNIOS',
                    ),
                    const SizedBox(height: 14),
                    _PatrocinioCard(data: data),

                    const SizedBox(height: 24),

                    // Histórico de transferências
                    _SectionTitle(
                      icon: Icons.history,
                      title: 'HISTÓRICO DE TRANSFERÊNCIAS',
                    ),
                    const SizedBox(height: 14),
                    _TransferenciasCard(transferencias: data.transferencias),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const AppBottomNavigation(activeRoute: AppRoutes.finance),
          ],
        ),
      ),
    );
  }
}

// ─── COMPONENTES COMUNS ───────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionTitle({required this.icon, required this.title});

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
      ],
    );
  }
}

Widget _card({required Widget child}) => Container(
  width: double.infinity,
  padding: const EdgeInsets.all(18),
  decoration: BoxDecoration(
    color: AppColors.card,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: AppColors.border),
  ),
  child: child,
);

// ─── ORÇAMENTO ────────────────────────────────────────────────────────────────

class _OrcamentoCard extends StatelessWidget {
  final FinanceData data;

  const _OrcamentoCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TOTAL DISPONÍVEL',
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.orcamentoTotal,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'GASTO',
                    style: TextStyle(
                      color: AppColors.muted,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.orcamentoGasto,
                    style: const TextStyle(
                      color: AppColors.orange,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: data.orcamentoPercent,
              minHeight: 10,
              backgroundColor: AppColors.cardAlt,
              valueColor: AlwaysStoppedAnimation<Color>(
                data.orcamentoPercent > 0.85 ? AppColors.red : AppColors.orange,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(data.orcamentoPercent * 100).toStringAsFixed(0)}% UTILIZADO',
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${((1 - data.orcamentoPercent) * 100).toStringAsFixed(0)}% DISPONÍVEL',
                style: const TextStyle(
                  color: AppColors.accent,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── BALANÇO ─────────────────────────────────────────────────────────────────

class _BalancoCard extends StatelessWidget {
  final FinanceData data;

  const _BalancoCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return _card(
      child: Row(
        children: [
          Expanded(
            child: _BalancoItem(
              label: 'RECEITA TOTAL',
              value: data.receitaTotal,
              color: AppColors.accent,
              icon: Icons.arrow_downward,
            ),
          ),
          Container(
            width: 1,
            height: 60,
            color: AppColors.border,
            margin: const EdgeInsets.symmetric(horizontal: 14),
          ),
          Expanded(
            child: _BalancoItem(
              label: 'DESPESA TOTAL',
              value: data.despesaTotal,
              color: AppColors.red,
              icon: Icons.arrow_upward,
            ),
          ),
          Container(
            width: 1,
            height: 60,
            color: AppColors.border,
            margin: const EdgeInsets.symmetric(horizontal: 14),
          ),
          Expanded(
            child: _BalancoItem(
              label: 'SALDO',
              value: data.saldo,
              color: data.saldoPositivo ? AppColors.accent : AppColors.red,
              icon: data.saldoPositivo
                  ? Icons.trending_up
                  : Icons.trending_down,
              large: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _BalancoItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;
  final bool large;

  const _BalancoItem({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 12),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 8,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: large ? 18 : 15,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

// ─── RECEITAS & DESPESAS ──────────────────────────────────────────────────────

class _ReceitasDespesasCard extends StatelessWidget {
  final FinanceData data;

  const _ReceitasDespesasCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return _card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.arrow_downward, color: AppColors.accent, size: 13),
                    SizedBox(width: 5),
                    Text(
                      'RECEITAS',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...data.receitas.map(
                  (item) => _FinanceLineItem(item: item, color: AppColors.accent),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: AppColors.border,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.arrow_upward, color: AppColors.red, size: 13),
                    SizedBox(width: 5),
                    Text(
                      'DESPESAS',
                      style: TextStyle(
                        color: AppColors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...data.despesas.map(
                  (item) => _FinanceLineItem(item: item, color: AppColors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FinanceLineItem extends StatelessWidget {
  final FinanceItem item;
  final Color color;

  const _FinanceLineItem({required this.item, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon, size: 13, color: color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              item.label,
              style: const TextStyle(
                color: AppColors.subtle,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            item.value,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── FOLHA SALARIAL ───────────────────────────────────────────────────────────

class _FolhaCard extends StatelessWidget {
  final FinanceData data;

  const _FolhaCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return _card(
      child: Row(
        children: [
          Expanded(
            child: _StatBox(
              label: 'TOTAL SEMANAL',
              value: data.folhaSalarial,
              icon: Icons.calendar_view_week_outlined,
              color: AppColors.orange,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatBox(
              label: 'TOTAL MENSAL',
              value: data.folhaMensal,
              icon: Icons.calendar_month_outlined,
              color: AppColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── VALOR DE MERCADO ─────────────────────────────────────────────────────────

class _ValorMercadoCard extends StatelessWidget {
  final FinanceData data;

  const _ValorMercadoCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return _card(
      child: Row(
        children: [
          Expanded(
            child: _StatBox(
              label: 'VALOR TOTAL',
              value: data.valorMercadoElenco,
              icon: Icons.account_balance_wallet_outlined,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatBox(
              label: 'MÉDIA POR JOGADOR',
              value: data.valorMercadoMedia,
              icon: Icons.person_outline,
              color: AppColors.subtle,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatBox({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
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
              Icon(icon, color: color, size: 13),
              const SizedBox(width: 6),
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
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── TRANSFERÊNCIAS ───────────────────────────────────────────────────────────

class _TransferenciasCard extends StatelessWidget {
  final List<TransferItem> transferencias;

  const _TransferenciasCard({required this.transferencias});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Cabeçalho
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.cardAlt,
            child: const Row(
              children: [
                Expanded(flex: 4, child: Text('JOGADOR', style: _headerStyle)),
                Expanded(
                  flex: 2,
                  child: Text(
                    'TIPO',
                    textAlign: TextAlign.center,
                    style: _headerStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'VALOR',
                    textAlign: TextAlign.right,
                    style: _headerStyle,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'DATA',
                    textAlign: TextAlign.right,
                    style: _headerStyle,
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < transferencias.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: AppColors.border),
            _TransferRow(item: transferencias[i]),
          ],
        ],
      ),
    );
  }
}

const _headerStyle = TextStyle(
  color: AppColors.muted,
  fontSize: 10,
  fontWeight: FontWeight.w800,
  letterSpacing: 0.8,
);

class _TransferRow extends StatelessWidget {
  final TransferItem item;

  const _TransferRow({required this.item});

  Color get _tipoColor {
    switch (item.tipo) {
      case 'COMPRA':
        return AppColors.red;
      case 'VENDA':
        return AppColors.accent;
      default:
        return AppColors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Icon(
                  item.entrada ? Icons.arrow_downward : Icons.arrow_upward,
                  size: 13,
                  color: item.entrada ? AppColors.accent : AppColors.red,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.player,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: _tipoColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _tipoColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  item.tipo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _tipoColor,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              item.valor,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: item.entrada ? AppColors.accent : AppColors.red,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              item.data,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── CARD DE PATROCÍNIOS (ATALHO) ────────────────────────────────────────────

class _PatrocinioCard extends StatelessWidget {
  final FinanceData data;

  const _PatrocinioCard({required this.data});

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
                child: _StatBox(
                  label: 'RECEITA ANUAL',
                  value: data.patrocinioReceita,
                  icon: Icons.monetization_on_outlined,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatBox(
                  label: 'PATROCINADORES',
                  value: data.patrocinioTotal.toString(),
                  icon: Icons.groups_outlined,
                  color: AppColors.light,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatBox(
                  label: 'VENCENDO',
                  value: data.patrocinioVencendo.toString(),
                  icon: Icons.schedule_outlined,
                  color: data.patrocinioVencendo > 0 ? AppColors.orange : AppColors.subtle,
                ),
              ),
            ],
          ),

          if (data.patrocinioVencendo > 0) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.orange.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.orange.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.schedule_outlined,
                    color: AppColors.orange,
                    size: 14,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${data.patrocinioVencendo} contrato${data.patrocinioVencendo > 1 ? 's' : ''} '
                      'vencendo em breve. Considere renovar.',
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
            ),
          ],

          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 4),

          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SponsorsPage()),
                );
              },
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'VER MAIS INFORMAÇÕES',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward_ios, color: AppColors.accent, size: 11),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
