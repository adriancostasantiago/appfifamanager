import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/models/models.dart';

enum LoanPaymentMethod { avista, parcelado }

// ─── PÁGINA ──────────────────────────────────────────────────────────────────

class LoanPlayerPage extends StatefulWidget {
  final PlayerProfile player;

  const LoanPlayerPage({super.key, required this.player});

  @override
  State<LoanPlayerPage> createState() => _LoanPlayerPageState();
}

class _LoanPlayerPageState extends State<LoanPlayerPage> {
  final _taxaController = TextEditingController();
  final _clubController = TextEditingController();
  final _entradaController = TextEditingController();
  final _opcaoCompraController = TextEditingController();

  LoanPaymentMethod _paymentMethod = LoanPaymentMethod.avista;
  int _installments = 3;
  int _duracaoMeses = 6;

  int get _currentContractYears => widget.player.contractUntil.clamp(1, 5);
  bool _opcaoCompra = false;

  String get _taxaValue => _taxaController.text.trim();

  double get _parsedTaxa {
    final raw = _taxaValue.replaceAll('.', '').replaceAll(',', '.');
    return double.tryParse(raw) ?? 0;
  }

  double get _parsedEntrada {
    final raw = _entradaController.text
        .trim()
        .replaceAll('.', '')
        .replaceAll(',', '.');
    return double.tryParse(raw) ?? 0;
  }

  double get _valorParcelado => _parsedTaxa - _parsedEntrada;
  double get _valorParcela =>
      _installments > 0 ? _valorParcelado / _installments : 0;

  String _fmt(double v) {
    if (v <= 0) return '—';
    if (v >= 1_000_000) return '€${(v / 1_000_000).toStringAsFixed(2)}M';
    if (v >= 1_000) return '€${(v / 1_000).toStringAsFixed(0)}K';
    return '€${v.toStringAsFixed(0)}';
  }

  double get _marketValueNum {
    final raw = widget.player.marketValue
        .replaceAll('€', '')
        .replaceAll('M', '')
        .replaceAll(',', '.');
    return double.tryParse(raw) ?? 0;
  }

  double get _taxaPct =>
      _marketValueNum > 0 ? _parsedTaxa / (_marketValueNum * 1_000_000) : 0;

  Color _taxaPctColor(BuildContext context) {
    if (_taxaPct >= 0.1) return context.colors.orange;
    if (_taxaPct >= 0.05) return context.colors.orange;
    return context.colors.red;
  }

  String get _taxaPctLabel {
    if (_taxaPct >= 0.1) return 'TAXA BOA';
    if (_taxaPct >= 0.05) return 'TAXA RAZOÁVEL';
    return 'TAXA BAIXA';
  }

  String _formatNumber(int v) {
    final s = v.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  @override
  void initState() {
    super.initState();
    final base = (_marketValueNum * 1_000_000 * 0.05).toInt();
    _taxaController.text = _formatNumber(base);
    // Pré-seleciona o máximo permitido (igual ao contrato atual)
    _duracaoMeses = _currentContractYears.clamp(1, 5);
  }

  @override
  void dispose() {
    _taxaController.dispose();
    _clubController.dispose();
    _entradaController.dispose();
    _opcaoCompraController.dispose();
    super.dispose();
  }

  String get _infoMessage {
    final remaining = _currentContractYears - _duracaoMeses;
    if (remaining == 0) {
      return 'Duração máxima — empréstimo cobre todo o contrato restante.';
    }
    final yearWord = remaining == 1 ? 'ano' : 'anos';
    return 'Empréstimo de $_duracaoMeses ${_duracaoMeses == 1 ? 'ano' : 'anos'} — '
        '$remaining $yearWord de contrato restantes após o empréstimo.';
  }

  void _confirmLoan() {
    showDialog(
      context: context,
      builder: (ctx) => _ConfirmLoanDialog(
        player: widget.player,
        taxa: _taxaValue,
        club: _clubController.text.trim().isEmpty
            ? 'Clube desconhecido'
            : _clubController.text.trim(),
        duracao: _duracaoMeses,
        payment: _paymentMethod,
        installments: _installments,
        opcaoCompra: _opcaoCompra,
        valorOpcao: _opcaoCompraController.text.trim(),
        onConfirm: () {
          Navigator.of(ctx).pop();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: context.colors.card,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: context.colors.orange, width: 1),
              ),
              content: Row(
                children: [
                  Icon(Icons.swap_horiz, color: context.colors.orange),
                  const SizedBox(width: 12),
                  Text(
                    '${widget.player.name} emprestado com sucesso!',
                    style: TextStyle(
                      color: context.colors.textPrimary,
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
            _LoanAppBar(playerName: player.name),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PlayerMiniCard(player: player),
                    const SizedBox(height: 20),

                    // Painel de negociação
                    _LoanNegotiationPanel(controller: _clubController),
                    const SizedBox(height: 20),

                    // Duração do empréstimo
                    _LoanDurationCard(
                      currentYears: _currentContractYears,
                      selectedYears: _duracaoMeses,
                      onSelect: (v) => setState(() => _duracaoMeses = v),
                      infoMessage: _infoMessage,
                    ),
                    const SizedBox(height: 16),

                    // Taxa de empréstimo
                    _LoanTaxaCard(
                      controller: _taxaController,
                      pct: _taxaPct,
                      pctColor: _taxaPctColor(context),
                      pctLabel: _taxaPctLabel,
                      marketValue: player.marketValue,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 16),

                    // Forma de pagamento da taxa
                    _LoanPaymentMethodCard(
                      selected: _paymentMethod,
                      installments: _installments,
                      entradaController: _entradaController,
                      onMethodChanged: (m) =>
                          setState(() => _paymentMethod = m),
                      onInstallmentsChanged: (v) =>
                          setState(() => _installments = v),
                      onEntradaChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 16),

                    // Opção de compra
                    _OpcaoCompraCard(
                      enabled: _opcaoCompra,
                      controller: _opcaoCompraController,
                      onToggle: (v) => setState(() => _opcaoCompra = v),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 20),

                    // Resumo financeiro
                    _LoanFinancialSummary(
                      taxa: _taxaValue,
                      duracao: _duracaoMeses,
                      payment: _paymentMethod,
                      installments: _installments,
                      entrada: _parsedEntrada,
                      valorParcela: _valorParcela,
                      fmtFn: _fmt,
                      opcaoCompra: _opcaoCompra,
                      valorOpcao: _opcaoCompraController.text.trim(),
                    ),
                    const SizedBox(height: 8),

                    const _LegalNotice(),
                    const SizedBox(height: 24),

                    _ConfirmButton(onTap: _confirmLoan),

                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        'AO CONFIRMAR, O JOGADOR SERÁ CEDIDO AO CLUBE\nDE DESTINO PELO PERÍODO ACORDADO.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.colors.muted,
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

class _LoanAppBar extends StatelessWidget {
  final String playerName;

  const _LoanAppBar({required this.playerName});

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
            child: Icon(
              Icons.arrow_back,
              color: context.colors.orange,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            'EMPRESTAR JOGADOR',
            style: TextStyle(
              color: context.colors.orange,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              fontStyle: FontStyle.italic,
            ),
          ),
          const Spacer(),
          Icon(Icons.info_outline, color: context.colors.muted, size: 20),
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
        border: Border.all(color: context.colors.border),
        boxShadow: [
          BoxShadow(
            color: context.colors.orange.withValues(alpha: 0.04),
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
                child: Icon(
                  Icons.person,
                  size: 44,
                  color: context.colors.border,
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
                  style: TextStyle(
                    color: context.colors.textPrimary,
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
              Text(
                'VALOR\nMERCADO',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: context.colors.muted,
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 4),
              Text(
                player.marketValue,
                style: TextStyle(
                  color: context.colors.textPrimary,
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
          Icon(icon, size: 11, color: context.colors.subtle),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: context.colors.subtle,
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

// ─── PAINEL DE NEGOCIAÇÃO ────────────────────────────────────────────────────

class _LoanNegotiationPanel extends StatelessWidget {
  final TextEditingController controller;

  const _LoanNegotiationPanel({required this.controller});

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
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: context.colors.cardAlt,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: context.colors.border),
                      ),
                      child: Icon(
                        Icons.shield,
                        color: context.colors.orange,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'SEU CLUBE',
                      style: TextStyle(
                        color: context.colors.muted,
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      children: List.generate(
                        12,
                        (i) => Expanded(
                          child: Container(
                            height: 1.5,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            color: i.isEven
                                ? context.colors.orange.withValues(alpha: 0.5)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.cardAlt,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: context.colors.border),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.swap_horiz,
                            color: context.colors.orange,
                            size: 10,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'EMPRÉSTIMO',
                            style: TextStyle(
                              color: context.colors.orange,
                              fontSize: 7,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: context.colors.cardAlt,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: context.colors.orange.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: context.colors.orange.withValues(
                              alpha: 0.08,
                            ),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.shield_outlined,
                        color: context.colors.orange,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      controller.text.trim().isEmpty
                          ? 'DESTINO'
                          : controller.text.trim().toUpperCase(),
                      style: TextStyle(
                        color: context.colors.orange,
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Divider(color: context.colors.border, height: 1),
          const SizedBox(height: 16),
          _LoanTextField(
            controller: controller,
            label: 'CLUBE DE DESTINO',
            icon: Icons.sports_soccer,
            hint: 'Ex.: Sporting CP',
          ),
        ],
      ),
    );
  }
}

// ─── DURAÇÃO DO EMPRÉSTIMO ────────────────────────────────────────────────────

class _LoanDurationCard extends StatelessWidget {
  final int currentYears;
  final int selectedYears;
  final ValueChanged<int> onSelect;
  final String infoMessage;

  const _LoanDurationCard({
    required this.currentYears,
    required this.selectedYears,
    required this.onSelect,
    required this.infoMessage,
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
            children: [
              Icon(
                Icons.calendar_today,
                color: context.colors.orange,
                size: 18,
              ),
              SizedBox(width: 10),
              Text(
                'DURAÇÃO DO EMPRÉSTIMO',
                style: TextStyle(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 1.0,
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
                      child: _LoanYearButton(
                        years: year,
                        selected: year == selectedYears,
                        isCurrent: year == currentYears, // max allowed
                        disabled: year > currentYears,
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
                color: context.colors.subtle,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'O EMPRÉSTIMO NÃO PODE EXCEDER O CONTRATO ATUAL DO JOGADOR',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.colors.muted,
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

class _LoanYearButton extends StatelessWidget {
  final int years;
  final bool selected;
  final bool isCurrent;
  final bool disabled;
  final VoidCallback onTap;

  const _LoanYearButton({
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
      contentColor = context.colors.muted.withValues(alpha: 0.35);
    } else if (selected) {
      contentColor = context.colors.orange;
    } else {
      contentColor = context.colors.textPrimary;
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
                    ? context.colors.orange.withValues(alpha: 0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected ? context.colors.orange : Colors.transparent,
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
                      color: disabled
                          ? contentColor
                          : (selected
                                ? context.colors.orange
                                : context.colors.muted),
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    years == 1 ? 'ANO' : 'ANOS',
                    style: TextStyle(
                      color: disabled
                          ? contentColor
                          : (selected
                                ? context.colors.orange
                                : context.colors.muted),
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
                color: context.colors.orange,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'MÁX.',
                style: TextStyle(
                  color: context.colors.onAccent,
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

// ─── CARD TAXA DO EMPRÉSTIMO ──────────────────────────────────────────────────

class _LoanTaxaCard extends StatelessWidget {
  final TextEditingController controller;
  final double pct;
  final Color pctColor;
  final String pctLabel;
  final String marketValue;
  final ValueChanged<String> onChanged;

  const _LoanTaxaCard({
    required this.controller,
    required this.pct,
    required this.pctColor,
    required this.pctLabel,
    required this.marketValue,
    required this.onChanged,
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
          Row(
            children: [
              Icon(
                Icons.payments_outlined,
                color: context.colors.orange,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'TAXA DO EMPRÉSTIMO (€)',
                style: TextStyle(
                  color: context.colors.muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: pctColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: pctColor.withValues(alpha: 0.3)),
                ),
                child: Text(
                  pctLabel,
                  style: TextStyle(
                    color: pctColor,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: context.colors.cardAlt,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: context.colors.border),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    '€',
                    style: TextStyle(
                      color: context.colors.orange,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: context.colors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      hintText: '0',
                      hintStyle: TextStyle(color: context.colors.muted),
                      suffixText: 'EUR',
                      suffixStyle: TextStyle(
                        color: context.colors.muted,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct.clamp(0.0, 1.0),
              minHeight: 4,
              backgroundColor: context.colors.cardAlt,
              valueColor: AlwaysStoppedAnimation<Color>(pctColor),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Valor de mercado: $marketValue',
                style: TextStyle(
                  color: context.colors.muted,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${(pct * 100).toStringAsFixed(1)}% do VM',
                style: TextStyle(
                  color: pctColor,
                  fontSize: 9,
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

// ─── FORMA DE PAGAMENTO DA TAXA ───────────────────────────────────────────────

class _LoanPaymentMethodCard extends StatelessWidget {
  final LoanPaymentMethod selected;
  final int installments;
  final TextEditingController entradaController;
  final ValueChanged<LoanPaymentMethod> onMethodChanged;
  final ValueChanged<int> onInstallmentsChanged;
  final ValueChanged<String> onEntradaChanged;

  const _LoanPaymentMethodCard({
    required this.selected,
    required this.installments,
    required this.entradaController,
    required this.onMethodChanged,
    required this.onInstallmentsChanged,
    required this.onEntradaChanged,
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
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                color: context.colors.orange,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'FORMA DE PAGAMENTO DA TAXA',
                style: TextStyle(
                  color: context.colors.muted,
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
                child: _PaymentOption(
                  icon: Icons.paid_outlined,
                  label: 'À VISTA',
                  selected: selected == LoanPaymentMethod.avista,
                  onTap: () => onMethodChanged(LoanPaymentMethod.avista),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PaymentOption(
                  icon: Icons.calendar_month_outlined,
                  label: 'PARCELADO',
                  selected: selected == LoanPaymentMethod.parcelado,
                  onTap: () => onMethodChanged(LoanPaymentMethod.parcelado),
                ),
              ),
            ],
          ),
          if (selected == LoanPaymentMethod.parcelado) ...[
            const SizedBox(height: 16),
            Divider(color: context.colors.border, height: 1),
            const SizedBox(height: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.arrow_downward,
                      color: context.colors.orange,
                      size: 13,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'VALOR DE ENTRADA',
                      style: TextStyle(
                        color: context.colors.orange,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: context.colors.cardAlt,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.colors.orange.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 14),
                        child: Text(
                          '€',
                          style: TextStyle(
                            color: context.colors.orange,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: entradaController,
                          onChanged: onEntradaChanged,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: context.colors.orange,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 14,
                            ),
                            hintText: '0',
                            hintStyle: TextStyle(color: context.colors.muted),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'NÚMERO DE PARCELAS',
              style: TextStyle(
                color: context.colors.muted,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [2, 3, 4, 5].map((n) {
                final sel = n == installments;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onInstallmentsChanged(n),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: sel
                            ? context.colors.orange.withValues(alpha: 0.12)
                            : context.colors.cardAlt,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: sel
                              ? context.colors.orange.withValues(alpha: 0.7)
                              : context.colors.border,
                          width: sel ? 1.5 : 1,
                        ),
                      ),
                      child: Text(
                        '${n}x',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: sel
                              ? context.colors.orange
                              : context.colors.subtle,
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: selected
              ? context.colors.orange.withValues(alpha: 0.08)
              : context.colors.cardAlt,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? context.colors.orange.withValues(alpha: 0.6)
                : context.colors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: selected ? context.colors.orange : context.colors.subtle,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? context.colors.orange : context.colors.subtle,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.4,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── OPÇÃO DE COMPRA ──────────────────────────────────────────────────────────

class _OpcaoCompraCard extends StatelessWidget {
  final bool enabled;
  final TextEditingController controller;
  final ValueChanged<bool> onToggle;
  final ValueChanged<String> onChanged;

  const _OpcaoCompraCard({
    required this.enabled,
    required this.controller,
    required this.onToggle,
    required this.onChanged,
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
          Row(
            children: [
              Icon(
                Icons.add_shopping_cart_outlined,
                color: context.colors.orange,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'OPÇÃO DE COMPRA',
                style: TextStyle(
                  color: context.colors.muted,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
              const Spacer(),
              Switch(
                value: enabled,
                onChanged: onToggle,
                activeThumbColor: context.colors.orange,
                inactiveTrackColor: context.colors.border,
              ),
            ],
          ),
          if (enabled) ...[
            const SizedBox(height: 14),
            Divider(color: context.colors.border, height: 1),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                color: context.colors.cardAlt,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: context.colors.border),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      '€',
                      style: TextStyle(
                        color: context.colors.orange,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: onChanged,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: context.colors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        hintText: '0',
                        hintStyle: TextStyle(color: context.colors.muted),
                        suffixText: 'EUR',
                        suffixStyle: TextStyle(
                          color: context.colors.muted,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Valor pelo qual o clube poderá adquirir o jogador definitivamente.',
              style: TextStyle(
                color: context.colors.muted,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── RESUMO FINANCEIRO ────────────────────────────────────────────────────────

class _LoanFinancialSummary extends StatelessWidget {
  final String taxa;
  final int duracao;
  final LoanPaymentMethod payment;
  final int installments;
  final double entrada;
  final double valorParcela;
  final String Function(double) fmtFn;
  final bool opcaoCompra;
  final String valorOpcao;

  const _LoanFinancialSummary({
    required this.taxa,
    required this.duracao,
    required this.payment,
    required this.installments,
    required this.entrada,
    required this.valorParcela,
    required this.fmtFn,
    required this.opcaoCompra,
    required this.valorOpcao,
  });

  @override
  Widget build(BuildContext context) {
    final display = taxa.isEmpty ? '—' : '€$taxa';

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
            label: 'Duração',
            value: '$duracao ${duracao == 1 ? 'ano' : 'anos'}',
            valueColor: context.colors.subtle,
          ),
          const SizedBox(height: 10),
          if (payment == LoanPaymentMethod.avista) ...[
            _SummaryRow(
              label: 'Taxa do Empréstimo',
              value: display,
              valueColor: context.colors.textPrimary,
            ),
          ] else ...[
            _SummaryRow(
              label: 'Valor de Entrada',
              value: entrada > 0 ? fmtFn(entrada) : '—',
              valueColor: context.colors.orange,
            ),
            const SizedBox(height: 10),
            _SummaryRow(
              label: 'Valor Parcelado',
              value: entrada > 0 && valorParcela > 0
                  ? '${installments}x ${fmtFn(valorParcela)}'
                  : '—',
              valueColor: context.colors.orange,
            ),
          ],
          if (opcaoCompra && valorOpcao.isNotEmpty) ...[
            const SizedBox(height: 10),
            _SummaryRow(
              label: 'Opção de Compra',
              value: '€$valorOpcao',
              valueColor: context.colors.subtle,
            ),
          ],
          const SizedBox(height: 10),
          Divider(color: context.colors.border, height: 1),
          const SizedBox(height: 10),
          _SummaryRow(
            label: 'TAXA TOTAL DO EMPRÉSTIMO',
            value: display,
            labelBold: true,
            valueColor: context.colors.orange,
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
            color: labelBold
                ? context.colors.textPrimary
                : context.colors.subtle,
            fontSize: 11,
            fontWeight: labelBold ? FontWeight.w900 : FontWeight.w600,
            letterSpacing: labelBold ? 0.6 : 0,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: valueLarge ? 22 : 13,
            fontWeight: FontWeight.w900,
            fontStyle: valueLarge ? FontStyle.italic : FontStyle.normal,
          ),
        ),
      ],
    );
  }
}

// ─── AVISO LEGAL ─────────────────────────────────────────────────────────────

class _LegalNotice extends StatelessWidget {
  const _LegalNotice();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'CONFIRME TODOS OS TERMOS DO EMPRÉSTIMO ANTES DE PROSSEGUIR',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: context.colors.muted,
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          height: 1.6,
        ),
      ),
    );
  }
}

// ─── BOTÃO CONFIRMAR ─────────────────────────────────────────────────────────

class _ConfirmButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ConfirmButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: context.colors.orange,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.swap_horiz, color: context.colors.onAccent, size: 22),
            SizedBox(width: 12),
            Text(
              'CONFIRMAR EMPRÉSTIMO',
              style: TextStyle(
                color: context.colors.onAccent,
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

class _ConfirmLoanDialog extends StatelessWidget {
  final PlayerProfile player;
  final String taxa;
  final String club;
  final int duracao;
  final LoanPaymentMethod payment;
  final int installments;
  final bool opcaoCompra;
  final String valorOpcao;
  final VoidCallback onConfirm;

  const _ConfirmLoanDialog({
    required this.player,
    required this.taxa,
    required this.club,
    required this.duracao,
    required this.payment,
    required this.installments,
    required this.opcaoCompra,
    required this.valorOpcao,
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
                color: context.colors.orange.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colors.orange.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.swap_horiz,
                color: context.colors.orange,
                size: 28,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'CONFIRMAR EMPRÉSTIMO?',
              style: TextStyle(
                color: context.colors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${player.name} será emprestado para $club por $duracao ${duracao == 1 ? 'ano' : 'anos'}.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.colors.subtle,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            if (taxa.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'Taxa: €$taxa${payment == LoanPaymentMethod.parcelado ? ' em ${installments}x' : ' à vista'}.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.colors.muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            if (opcaoCompra && valorOpcao.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'Opção de compra: €$valorOpcao.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.colors.muted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
                      child: Text(
                        'CANCELAR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.colors.subtle,
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
                        color: context.colors.orange,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: context.colors.orange.withValues(alpha: 0.3),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Text(
                        'CONFIRMAR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: context.colors.onAccent,
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

// ─── CAMPO DE TEXTO PADRÃO ────────────────────────────────────────────────────

class _LoanTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String hint;

  const _LoanTextField({
    required this.controller,
    required this.label,
    required this.icon,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: context.colors.orange, size: 14),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: context.colors.muted,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: context.colors.cardAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.colors.border),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              color: context.colors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              hintText: hint,
              hintStyle: TextStyle(color: context.colors.muted, fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}
