import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/models/models.dart';
import 'package:fifamanager/core/theme/app_colors.dart';

class ReleasePlayerPage extends StatefulWidget {
  final PlayerProfile player;

  const ReleasePlayerPage({super.key, required this.player});

  @override
  State<ReleasePlayerPage> createState() => _ReleasePlayerPageState();
}

class _ReleasePlayerPageState extends State<ReleasePlayerPage> {
  String _motivoSelecionado = '';
  bool _confirmChecked = false;

  final List<_Motivo> _motivos = const [
    _Motivo(label: 'Desempenho insatisfatório', icon: Icons.trending_down),
    _Motivo(label: 'Excesso de elenco', icon: Icons.group_outlined),
    _Motivo(
      label: 'Problemas disciplinares',
      icon: Icons.warning_amber_outlined,
    ),
    _Motivo(label: 'Redução de custos', icon: Icons.savings_outlined),
    _Motivo(label: 'Aposentadoria', icon: Icons.elderly_outlined),
    _Motivo(label: 'Rescisão mútua', icon: Icons.handshake_outlined),
    _Motivo(label: 'Outro', icon: Icons.more_horiz),
  ];

  /// Custo estimado de rescisão: salário semanal × semanas restantes do contrato.
  /// contractUntil agora é int com os anos restantes (1–5).
  String get _custoRescisao {
    final salaryRaw = widget.player.salary
        .replaceAll('€', '')
        .replaceAll('/sem', '')
        .trim();

    double salario;
    if (salaryRaw.endsWith('M')) {
      salario =
          (double.tryParse(salaryRaw.replaceAll('M', '')) ?? 0) * 1_000_000;
    } else if (salaryRaw.endsWith('K')) {
      salario = (double.tryParse(salaryRaw.replaceAll('K', '')) ?? 0) * 1_000;
    } else {
      salario = double.tryParse(salaryRaw) ?? 0;
    }

    final semanasRestantes = (widget.player.contractUntil * 52).clamp(0, 260);
    final custo = salario * semanasRestantes;

    if (custo <= 0) return '—';
    if (custo >= 1_000_000) {
      return '€${(custo / 1_000_000).toStringAsFixed(1)}M';
    }
    if (custo >= 1_000) return '€${(custo / 1_000).toStringAsFixed(0)}K';
    return '€${custo.toStringAsFixed(0)}';
  }

  bool get _canConfirm => _motivoSelecionado.isNotEmpty && _confirmChecked;

  void _confirmRelease() {
    if (!_canConfirm) return;
    showDialog(
      context: context,
      builder: (ctx) => _ConfirmReleaseDialog(
        player: widget.player,
        motivo: _motivoSelecionado,
        custoRescisao: _custoRescisao,
        onConfirm: () {
          Navigator.of(ctx).pop();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: context.colors.card,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE53935), width: 1),
              ),
              content: Row(
                children: [
                  const Icon(
                    Icons.person_remove_outlined,
                    color: Color(0xFFE53935),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${widget.player.name} foi dispensado.',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final player = widget.player;

    return Scaffold(
      backgroundColor: context.colors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            _ReleaseAppBar(playerName: player.name),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PlayerMiniCard(player: player),
                    const SizedBox(height: 20),

                    // Aviso de ação irreversível
                    _WarningBanner(),
                    const SizedBox(height: 20),

                    // Impacto financeiro
                    _FinancialImpactCard(
                      salary: player.salary,
                      contractUntil: player.contractUntil,
                      custoRescisao: _custoRescisao,
                      marketValue: player.marketValue,
                    ),
                    const SizedBox(height: 16),

                    // Motivo da dispensa
                    _MotivoCard(
                      motivos: _motivos,
                      selected: _motivoSelecionado,
                      onSelected: (m) => setState(() => _motivoSelecionado = m),
                    ),
                    const SizedBox(height: 16),

                    // Resumo
                    _ReleaseSummary(
                      player: player,
                      motivo: _motivoSelecionado,
                      custoRescisao: _custoRescisao,
                    ),
                    const SizedBox(height: 16),

                    // Checkbox de confirmação
                    _ConfirmCheckbox(
                      checked: _confirmChecked,
                      onChanged: (v) =>
                          setState(() => _confirmChecked = v ?? false),
                      playerName: player.name,
                    ),
                    const SizedBox(height: 24),

                    // Botão confirmar
                    _ConfirmButton(
                      onTap: _confirmRelease,
                      enabled: _canConfirm,
                    ),

                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        'ESTA AÇÃO É PERMANENTE E NÃO PODE SER DESFEITA.\nO JOGADOR SERÁ REMOVIDO DO ELENCO IMEDIATAMENTE.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.muted,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── APP BAR ─────────────────────────────────────────────────────────────────

class _ReleaseAppBar extends StatelessWidget {
  final String playerName;

  const _ReleaseAppBar({required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.colors.backgroundDark,
        border: Border(bottom: BorderSide(color: context.colors.border)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFFE53935),
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'DISPENSAR JOGADOR',
            style: TextStyle(
              color: Color(0xFFE53935),
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              fontStyle: FontStyle.italic,
            ),
          ),
          const Spacer(),
          const Icon(Icons.info_outline, color: AppColors.muted, size: 20),
        ],
      ),
    );
  }
}

// ─── MINI CARD DO JOGADOR ─────────────────────────────────────────────────────

class _PlayerMiniCard extends StatelessWidget {
  final PlayerProfile player;

  const _PlayerMiniCard({required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE53935).withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE53935).withValues(alpha: 0.04),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.cardAlt,
                  border: Border.all(
                    color: const Color(0xFFE53935).withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.person,
                  size: 44,
                  color: Color(0xFF2A2F33),
                ),
              ),
              Positioned(
                bottom: -4,
                right: -4,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: player.ovrColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.colors.backgroundDark,
                      width: 2,
                    ),
                    // boxShadow: [
                    //   BoxShadow(color: player.ovrColor, blurRadius: 8),
                    // ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'OVR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        player.ovr.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _MiniChip(
                      icon: Icons.directions_run,
                      label: player.position,
                    ),
                    const SizedBox(width: 8),
                    _MiniChip(icon: Icons.public, label: player.country),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'VALOR\nMERCADO',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                player.marketValue,
                style: const TextStyle(
                  color: AppColors.light,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MiniChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: context.colors.cardAlt,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: AppColors.subtle),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.subtle,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── BANNER DE AVISO ─────────────────────────────────────────────────────────

class _WarningBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE53935).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE53935).withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE53935).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Color(0xFFE53935),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AÇÃO IRREVERSÍVEL',
                  style: TextStyle(
                    color: Color(0xFFE53935),
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Ao dispensar o jogador, ele será removido permanentemente do elenco e não poderá ser recuperado.',
                  style: TextStyle(
                    color: AppColors.light,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── IMPACTO FINANCEIRO ───────────────────────────────────────────────────────

class _FinancialImpactCard extends StatelessWidget {
  final String salary;
  final int contractUntil;
  final String custoRescisao;
  final String marketValue;

  const _FinancialImpactCard({
    required this.salary,
    required this.contractUntil,
    required this.custoRescisao,
    required this.marketValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.account_balance_outlined,
                color: Color(0xFFE53935),
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'IMPACTO FINANCEIRO',
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ImpactTile(
                  label: 'SALÁRIO SEMANAL',
                  value: salary,
                  icon: Icons.payments_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ImpactTile(
                  label: 'CONTRATO RESTANTE',
                  value:
                      '$contractUntil ${contractUntil == 1 ? 'ANO' : 'ANOS'}',
                  icon: Icons.event_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _ImpactTile(
                  label: 'VALOR DE MERCADO',
                  value: marketValue,
                  icon: Icons.trending_up,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ImpactTile(
                  label: 'CUSTO RESCISÃO EST.',
                  value: custoRescisao,
                  icon: Icons.money_off_outlined,
                  valueColor: const Color(0xFFE53935),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImpactTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color valueColor;

  const _ImpactTile({
    required this.label,
    required this.value,
    required this.icon,
    this.valueColor = AppColors.light,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colors.cardAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.muted, size: 11),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.muted,
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── MOTIVO DA DISPENSA ───────────────────────────────────────────────────────

class _Motivo {
  final String label;
  final IconData icon;
  const _Motivo({required this.label, required this.icon});
}

class _MotivoCard extends StatelessWidget {
  final List<_Motivo> motivos;
  final String selected;
  final ValueChanged<String> onSelected;

  const _MotivoCard({
    required this.motivos,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.list_alt_outlined, color: Color(0xFFE53935), size: 16),
              SizedBox(width: 8),
              Text(
                'MOTIVO DA DISPENSA',
                style: TextStyle(
                  color: AppColors.muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...motivos.map(
            (m) => GestureDetector(
              onTap: () => onSelected(m.label),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: selected == m.label
                      ? const Color(0xFFE53935).withValues(alpha: 0.1)
                      : context.colors.cardAlt,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: selected == m.label
                        ? const Color(0xFFE53935).withValues(alpha: 0.6)
                        : context.colors.border,
                    width: selected == m.label ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      m.icon,
                      size: 16,
                      color: selected == m.label
                          ? const Color(0xFFE53935)
                          : AppColors.subtle,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      m.label,
                      style: TextStyle(
                        color: selected == m.label
                            ? const Color(0xFFE53935)
                            : AppColors.subtle,
                        fontSize: 13,
                        fontWeight: selected == m.label
                            ? FontWeight.w800
                            : FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    if (selected == m.label)
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFFE53935),
                        size: 16,
                      ),
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

// ─── RESUMO ───────────────────────────────────────────────────────────────────

class _ReleaseSummary extends StatelessWidget {
  final PlayerProfile player;
  final String motivo;
  final String custoRescisao;

  const _ReleaseSummary({
    required this.player,
    required this.motivo,
    required this.custoRescisao,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        children: [
          _SummaryRow(
            label: 'Jogador',
            value: player.name,
            valueColor: AppColors.light,
          ),
          const SizedBox(height: 10),
          _SummaryRow(
            label: 'Posição',
            value: player.position,
            valueColor: AppColors.subtle,
          ),
          const SizedBox(height: 10),
          _SummaryRow(
            label: 'Motivo',
            value: motivo.isEmpty ? '—' : motivo,
            valueColor: motivo.isEmpty ? AppColors.muted : AppColors.subtle,
          ),
          const SizedBox(height: 10),
          Divider(color: context.colors.border, height: 1),
          const SizedBox(height: 10),
          _SummaryRow(
            label: 'CUSTO ESTIMADO',
            value: custoRescisao,
            labelBold: true,
            valueColor: const Color(0xFFE53935),
            valueLarge: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final bool labelBold;
  final bool valueLarge;

  const _SummaryRow({
    required this.label,
    required this.value,
    required this.valueColor,
    this.labelBold = false,
    this.valueLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: labelBold ? Colors.white : AppColors.subtle,
            fontSize: 11,
            fontWeight: labelBold ? FontWeight.w900 : FontWeight.w600,
            letterSpacing: labelBold ? 0.6 : 0,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: valueColor,
              fontSize: valueLarge ? 22 : 13,
              fontWeight: FontWeight.w900,
              fontStyle: valueLarge ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── CHECKBOX DE CONFIRMAÇÃO ──────────────────────────────────────────────────

class _ConfirmCheckbox extends StatelessWidget {
  final bool checked;
  final ValueChanged<bool?> onChanged;
  final String playerName;

  const _ConfirmCheckbox({
    required this.checked,
    required this.onChanged,
    required this.playerName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!checked),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: checked
              ? const Color(0xFFE53935).withValues(alpha: 0.08)
              : context.colors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: checked
                ? const Color(0xFFE53935).withValues(alpha: 0.5)
                : context.colors.border,
            width: checked ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: checked
                    ? const Color(0xFFE53935)
                    : context.colors.cardAlt,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: checked
                      ? const Color(0xFFE53935)
                      : context.colors.border,
                  width: 1.5,
                ),
              ),
              child: checked
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Confirmo que desejo dispensar $playerName permanentemente do elenco.',
                style: TextStyle(
                  color: checked ? AppColors.light : AppColors.subtle,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── BOTÃO CONFIRMAR ─────────────────────────────────────────────────────────

class _ConfirmButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool enabled;

  const _ConfirmButton({required this.onTap, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFFE53935) : context.colors.cardAlt,
          borderRadius: BorderRadius.circular(18),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: const Color(0xFFE53935).withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_remove_outlined,
              color: enabled ? Colors.white : AppColors.muted,
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              'DISPENSAR JOGADOR',
              style: TextStyle(
                color: enabled ? Colors.white : AppColors.muted,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── DIALOG DE CONFIRMAÇÃO ────────────────────────────────────────────────────

class _ConfirmReleaseDialog extends StatelessWidget {
  final PlayerProfile player;
  final String motivo;
  final String custoRescisao;
  final VoidCallback onConfirm;

  const _ConfirmReleaseDialog({
    required this.player,
    required this.motivo,
    required this.custoRescisao,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.colors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: context.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFE53935).withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFE53935).withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.person_remove_outlined,
                color: Color(0xFFE53935),
                size: 28,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'DISPENSAR JOGADOR?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${player.name} será removido permanentemente do elenco.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.subtle,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: context.colors.cardAlt,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.colors.border),
              ),
              child: Column(
                children: [
                  _DialogRow(label: 'Motivo', value: motivo),
                  const SizedBox(height: 6),
                  _DialogRow(
                    label: 'Custo estimado',
                    value: custoRescisao,
                    valueColor: const Color(0xFFE53935),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: context.colors.cardAlt,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: context.colors.border),
                      ),
                      child: const Text(
                        'CANCELAR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.subtle,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE53935),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFFE53935,
                            ).withValues(alpha: 0.4),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: const Text(
                        'CONFIRMAR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _DialogRow({
    required this.label,
    required this.value,
    this.valueColor = AppColors.light,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.muted,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
