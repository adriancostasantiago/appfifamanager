import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/models/models.dart';
import 'package:fifamanager/core/theme/app_colors.dart';

class ContractRenewalPage extends StatefulWidget {
  final PlayerProfile player;

  /// Salário semanal atual do jogador, em milhares de euros (ex: 200 = $200K).
  final double currentSalaryK;

  /// Quantos anos de contrato o jogador ainda possui (vínculo atual),
  /// de 1 a 5.
  final int currentContractYears;

  const ContractRenewalPage({
    super.key,
    required this.player,
    required this.currentSalaryK,
    this.currentContractYears = 2,
  });

  /// Extrai o valor numérico (em milhares de $) de uma string de salário,
  /// ex: '$250K/sem' ou '$250K' → 250.
  static double parseSalaryK(String? salary) {
    if (salary == null || salary.isEmpty) return 0;
    final match = RegExp(r'([\d.,]+)').firstMatch(salary);
    if (match == null) return 0;
    return double.tryParse(match.group(1)!.replaceAll(',', '.')) ?? 0;
  }

  @override
  State<ContractRenewalPage> createState() => _ContractRenewalPageState();
}

class _ContractRenewalPageState extends State<ContractRenewalPage> {
  late int _selectedYears;

  int get _currentYears => widget.currentContractYears.clamp(1, 5);

  @override
  void initState() {
    super.initState();
    _selectedYears = (_currentYears + 1).clamp(1, 5);
  }

  /// Percentual de impacto no salário com base nos anos adicionados ao
  /// vínculo atual.
  double get _impactPercentage {
    final added = _selectedYears - _currentYears;
    if (added <= 0) return 0;
    if (added == 1) return 25;
    if (added == 2) return 50;
    return 87;
  }

  double get _newSalaryK =>
      widget.currentSalaryK * (1 + _impactPercentage / 100);

  double get _totalInvestmentM => (_newSalaryK * 52 * _selectedYears) / 1000;

  int get _addedYears => (_selectedYears - _currentYears).clamp(0, 99);

  void _selectYears(int years) {
    if (years < _currentYears) return;
    setState(() => _selectedYears = years);
  }

  String get _infoMessage {
    if (_addedYears > 0) {
      final yearWord = _addedYears == 1 ? 'ano' : 'anos';
      return 'Ao selecionar $_selectedYears ${_selectedYears == 1 ? 'ano' : 'anos'}, '
          'você adiciona +$_addedYears $yearWord ao vínculo atual com '
          'reajuste automático.';
    }
    return 'Vínculo atual mantido. Selecione ${_currentYears + 1} ou mais '
        'anos para renovação.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.backgroundDark,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _RenewalAppBar(playerName: widget.player.name),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
                    child: Column(
                      children: [
                        _PlayerMiniCard(player: widget.player),
                        const SizedBox(height: 20),
                        _DurationCard(
                          currentYears: _currentYears,
                          selectedYears: _selectedYears,
                          onSelect: _selectYears,
                          infoMessage: _infoMessage,
                          infoActive: _addedYears > 0,
                        ),
                        const SizedBox(height: 20),
                        _ProposalCard(
                          currentSalaryK: widget.currentSalaryK,
                          newSalaryK: _newSalaryK,
                          percentage: _impactPercentage,
                          totalInvestmentM: _totalInvestmentM,
                          addedYears: _addedYears,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _ConfirmButton(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Vínculo de ${widget.player.name} renovado por '
                      '$_selectedYears ${_selectedYears == 1 ? 'ano' : 'anos'}.',
                    ),
                    backgroundColor: context.colors.cardAlt,
                  ),
                );
                // TODO: implementar lógica real de confirmação do vínculo.
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ─── APP BAR ────────────────────────────────────────────────────────────────

class _RenewalAppBar extends StatelessWidget {
  final String playerName;

  const _RenewalAppBar({required this.playerName});

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
            onTap: () => Navigator.of(context).maybePop(),
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xFF4FC3F7),
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'RENOVAR CONTRATO',
            style: TextStyle(
              color: Color(0xFF4FC3F7),
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

// ─── CARD: DURAÇÃO DO CONTRATO ──────────────────────────────────────────────

class _DurationCard extends StatelessWidget {
  final int currentYears;
  final int selectedYears;
  final ValueChanged<int> onSelect;
  final String infoMessage;
  final bool infoActive;

  const _DurationCard({
    required this.currentYears,
    required this.selectedYears,
    required this.onSelect,
    required this.infoMessage,
    required this.infoActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: Color(0xFF4FC3F7),
                size: 18,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'DURAÇÃO DO CONTRATO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    letterSpacing: 1.0,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: context.colors.cardAlt,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                for (int year = 1; year <= 5; year++)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: year == 1 ? 0 : 4),
                      child: _YearButton(
                        years: year,
                        selected: year == selectedYears,
                        isCurrent: year == currentYears,
                        disabled: year < currentYears,
                        onTap: () => onSelect(year),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: context.colors.cardAlt,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.colors.border),
            ),
            child: Text(
              infoMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.subtle,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'CONTRATOS DIMINUEM 1 ANO POR TEMPORADA',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _YearButton extends StatelessWidget {
  final int years;
  final bool selected;
  final bool isCurrent;
  final bool disabled;
  final VoidCallback onTap;

  const _YearButton({
    required this.years,
    required this.selected,
    required this.isCurrent,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color contentColor;
    if (disabled) {
      contentColor = AppColors.muted.withValues(alpha: 0.35);
    } else if (selected) {
      contentColor = Color(0xFF4FC3F7);
    } else {
      contentColor = Colors.white;
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: disabled ? null : onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              height: 72,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: selected
                    ? Color(0xFF4FC3F7).withValues(alpha: 0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected ? Color(0xFF4FC3F7) : Colors.transparent,
                  width: selected ? 1.5 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    years.toString(),
                    style: TextStyle(
                      color: disabled ? contentColor : AppColors.muted,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    years == 1 ? 'ANO' : 'ANOS',
                    style: TextStyle(
                      color: disabled ? contentColor : AppColors.muted,
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isCurrent)
          Positioned(
            top: -14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'VÍNCULO ATUAL',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 6,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ─── CARD: PROPOSTA CALCULADA ───────────────────────────────────────────────

class _ProposalCard extends StatelessWidget {
  final double currentSalaryK;
  final double newSalaryK;
  final double percentage;
  final double totalInvestmentM;
  final int addedYears;

  const _ProposalCard({
    required this.currentSalaryK,
    required this.newSalaryK,
    required this.percentage,
    required this.totalInvestmentM,
    required this.addedYears,
  });

  @override
  Widget build(BuildContext context) {
    final hasImpact = percentage > 0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colors.card,
          border: Border.all(color: context.colors.border),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4, color: Color(0xFF4FC3F7)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.analytics_outlined,
                            color: Color(0xFF4FC3F7),
                            size: 18,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'PROPOSTA CALCULADA',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              fontSize: 13,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _ProposalBox(
                              label: 'SALÁRIO ATUAL',
                              value: '${currentSalaryK.toStringAsFixed(0)}K',
                              caption: 'BASE DE CONTRATO',
                              valueColor: AppColors.subtle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _ProposalBox(
                              label: 'NOVO SALÁRIO',
                              value: '${newSalaryK.toStringAsFixed(0)}K',
                              caption:
                                  '+${percentage.toStringAsFixed(0)}% IMPACTO',
                              valueColor: hasImpact
                                  ? Color(0xFF4FC3F7)
                                  : AppColors.light,
                              highlighted: true,
                              showNewBadge: true,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [
                          Expanded(
                            child: _SummaryItem(
                              label: 'INVESTIMENTO TOTAL',
                              value:
                                  '${totalInvestmentM.toStringAsFixed(1)}M no período',
                              alignEnd: false,
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 32,
                            color: context.colors.border,
                          ),
                          Expanded(
                            child: _SummaryItem(
                              label: 'VÍNCULO ESTENDIDO',
                              value: addedYears == 0
                                  ? '+0 Temporadas'
                                  : '+$addedYears ${addedYears == 1 ? 'Temporada' : 'Temporadas'}',
                              alignEnd: true,
                              valueColor: hasImpact
                                  ? Color(0xFF4FC3F7)
                                  : AppColors.light,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProposalBox extends StatelessWidget {
  final String label;
  final String value;
  final String caption;
  final Color valueColor;
  final bool highlighted;
  final bool showNewBadge;

  const _ProposalBox({
    required this.label,
    required this.value,
    required this.caption,
    required this.valueColor,
    this.highlighted = false,
    this.showNewBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: highlighted
            ? Color(0xFF4FC3F7).withValues(alpha: 0.06)
            : context.colors.cardAlt,

        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: highlighted
              ? Color(0xFF4FC3F7).withValues(alpha: 0.25)
              : context.colors.border,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (showNewBadge)
            Positioned(
              top: -14,
              right: -14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: const BoxDecoration(
                  color: Color(0xFF4FC3F7),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: const Text(
                  'NOVO',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    color: valueColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  caption,
                  style: TextStyle(
                    color: AppColors.muted.withValues(alpha: 0.7),
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
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

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final bool alignEnd;
  final Color valueColor;

  const _SummaryItem({
    required this.label,
    required this.value,
    required this.alignEnd,
    this.valueColor = AppColors.light,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: alignEnd ? 12 : 0,
        right: alignEnd ? 0 : 12,
      ),
      child: Column(
        crossAxisAlignment: alignEnd
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.muted,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── BOTÃO DE CONFIRMAÇÃO (FIXO NA BASE) ────────────────────────────────────

class _ConfirmButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ConfirmButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.colors.backgroundDark.withValues(alpha: 0),
              context.colors.backgroundDark,
            ],
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: Color(0xFF4FC3F7),
                borderRadius: BorderRadius.circular(16),
                // boxShadow: [
                //   BoxShadow(
                //     color: Color(0xFF4FC3F7).withValues(alpha:0.4),
                //     blurRadius: 24,
                //     spreadRadius: 1,
                //   ),
                // ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'CONFIRMAR VÍNCULO',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontSize: 16,
                      letterSpacing: 1.0,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.verified_user, color: Colors.black, size: 20),
                ],
              ),
            ),
          ),
        ),
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
        border: Border.all(color: context.colors.border),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4FC3F7).withValues(alpha: 0.04),
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
                  border: Border.all(color: context.colors.border, width: 2),
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
                    //   BoxShadow(
                    //     color: player.ovrColor.withValues(alpha: 0.5),
                    //     blurRadius: 8,
                    //   ),
                    // ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'OVR',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        player.ovr.toString(),
                        style: const TextStyle(
                          color: Colors.black,
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
