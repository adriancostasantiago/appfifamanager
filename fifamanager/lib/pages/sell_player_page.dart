import 'package:flutter/material.dart';
import 'player_detail_page.dart';

// ─── PALETA (mesma do projeto) ───────────────────────────────────────────────

const _kBackground = Color(0xFF101314);
const _kCard = Color(0xFF16191D);
const _kCardAlt = Color(0xFF1A1E22);
const _kBorder = Color(0xFF1F2327);
const _kAccent = Color(0xFF00FF41);
const _kAccentStr = Color(0xFF1FE35B);
const _kBlue = Color(0xFF4FC3F7);
const _kMuted = Color(0xFF7C8579);
const _kSubtle = Color(0xFF9AA39C);
const _kLight = Color(0xFFD7E2D1);

// ─── MODELOS LOCAIS ──────────────────────────────────────────────────────────

enum PaymentMethod { avista, parcelado }

// ─── PÁGINA ─────────────────────────────────────────────────────────────────

class SellPlayerPage extends StatefulWidget {
  final PlayerProfile player;

  const SellPlayerPage({super.key, required this.player});

  @override
  State<SellPlayerPage> createState() => _SellPlayerPageState();
}

class _SellPlayerPageState extends State<SellPlayerPage> {
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _clubController = TextEditingController();
  final TextEditingController _entradaController = TextEditingController();
  PaymentMethod _paymentMethod = PaymentMethod.avista;
  int _installments = 3;

  // Extrai número de um valor como "€120M" → 120
  double get _marketValueNum {
    final raw = widget.player.marketValue
        .replaceAll('€', '')
        .replaceAll('M', '')
        .replaceAll(',', '.');
    return double.tryParse(raw) ?? 0;
  }

  String get _transferValue => _valueController.text.trim();

  double get _parsedValue {
    final raw = _transferValue.replaceAll('.', '').replaceAll(',', '.');
    return double.tryParse(raw) ?? 0;
  }

  double get _parsedEntrada {
    final raw = _entradaController.text
        .trim()
        .replaceAll('.', '')
        .replaceAll(',', '.');
    return double.tryParse(raw) ?? 0;
  }

  double get _valorParcelado => _parsedValue - _parsedEntrada;

  double get _valorParcela =>
      _installments > 0 ? _valorParcelado / _installments : 0;

  String _fmt(double v) {
    if (v <= 0) return '—';
    if (v >= 1000000) return '€${(v / 1000000).toStringAsFixed(2)}M';
    if (v >= 1000) return '€${(v / 1000).toStringAsFixed(0)}K';
    return '€${v.toStringAsFixed(0)}';
  }

  /// Percentual em relação ao valor de mercado (0.0–1.5+)
  double get _valuePct => _marketValueNum > 0
      ? _parsedValue /
            (_marketValueNum * 1_000_000) // valor em mercado está em M
      : 0;

  Color get _valuePctColor {
    if (_valuePct >= 1.0) return _kAccent;
    if (_valuePct >= 0.8) return _kAccent;
    return const Color(0xFFE53935);
  }

  String get _valuePctLabel {
    if (_valuePct >= 1.1) return 'ÓTIMO NEGÓCIO';
    if (_valuePct >= 1.0) return 'VALOR JUSTO';
    if (_valuePct >= 0.8) return 'ABAIXO DO MERCADO';
    return 'PREJUÍZO';
  }

  @override
  void initState() {
    super.initState();
    // Pré-preenche com o valor de mercado
    final base = (_marketValueNum * 1_000_000).toInt();
    _valueController.text = _formatNumber(base);
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
  void dispose() {
    _valueController.dispose();
    _clubController.dispose();
    _entradaController.dispose();
    super.dispose();
  }

  void _confirmSale() {
    showDialog(
      context: context,
      builder: (ctx) => _ConfirmSaleDialog(
        player: widget.player,
        value: _transferValue,
        club: _clubController.text.trim().isEmpty
            ? 'Clube desconhecido'
            : _clubController.text.trim(),
        payment: _paymentMethod,
        installments: _installments,
        onConfirm: () {
          Navigator.of(ctx).pop();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: _kCard,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: _kAccent, width: 1),
              ),
              content: Row(
                children: [
                  const Icon(Icons.check_circle_outline, color: _kAccent),
                  const SizedBox(width: 12),
                  Text(
                    '${widget.player.name} vendido com sucesso!',
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
      backgroundColor: _kBackground,
      body: SafeArea(
        child: Column(
          children: [
            // ── AppBar
            _SellAppBar(playerName: player.name),

            // ── Conteúdo com scroll
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mini card do jogador
                    _PlayerMiniCard(player: player),
                    const SizedBox(height: 20),

                    // Painel de negociação (clube comprador)
                    _NegotiationPanel(controller: _clubController),
                    const SizedBox(height: 20),

                    // Valor da transferência
                    _TransferValueCard(
                      controller: _valueController,
                      pct: _valuePct,
                      pctColor: _valuePctColor,
                      pctLabel: _valuePctLabel,
                      marketValue: widget.player.marketValue,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 16),

                    // Forma de pagamento
                    _PaymentMethodCard(
                      selected: _paymentMethod,
                      installments: _installments,
                      entradaController: _entradaController,
                      onMethodChanged: (m) =>
                          setState(() => _paymentMethod = m),
                      onInstallmentsChanged: (v) =>
                          setState(() => _installments = v),
                      onEntradaChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 20),

                    // Resumo financeiro
                    _FinancialSummary(
                      value: _transferValue,
                      payment: _paymentMethod,
                      installments: _installments,
                      entrada: _parsedEntrada,
                      valorParcela: _valorParcela,
                      fmtFn: _fmt,
                    ),
                    const SizedBox(height: 8),

                    // Aviso
                    const _LegalNotice(),
                    const SizedBox(height: 24),

                    // Botão confirmar
                    _ConfirmButton(onTap: _confirmSale),

                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        'AO CONFIRMAR, O CONTRATO SERÁ ASSINADO E O JOGADOR\nLEIXARÁ O CLUBE IMEDIATAMENTE.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _kMuted,
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

class _SellAppBar extends StatelessWidget {
  final String playerName;

  const _SellAppBar({required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: _kBackground,
        border: Border(bottom: BorderSide(color: _kBorder)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back, color: _kAccent, size: 22),
          ),
          // const SizedBox(width: 16),
          // const Text(
          //   'FINALIZAR VENDA',
          //   style: TextStyle(
          //     color: _kAccent,
          //     fontSize: 16,
          //     fontWeight: FontWeight.w900,
          //     letterSpacing: 1.2,
          //     fontStyle: FontStyle.italic,
          //   ),
          // ),
          const Spacer(),
          const Icon(Icons.info_outline, color: _kMuted, size: 20),
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
        color: _kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kBorder),
        boxShadow: [
          BoxShadow(
            color: _kAccent.withValues(alpha: 0.04),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _kCardAlt,
                  border: Border.all(color: _kBorder, width: 2),
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
                    color: _kAccentStr,
                    shape: BoxShape.circle,
                    border: Border.all(color: _kBackground, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: _kAccentStr.withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ],
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

          // Info
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

          // Valor de mercado
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'VALOR\nMERCADO',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: _kMuted,
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
                  color: _kLight,
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
        color: _kCardAlt,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: _kSubtle),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: _kSubtle,
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

class _NegotiationPanel extends StatelessWidget {
  final TextEditingController controller;

  const _NegotiationPanel({required this.controller});

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
          // Clubes lado a lado
          Row(
            children: [
              // Seu clube
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: _kCardAlt,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: _kBorder),
                      ),
                      child: const Icon(
                        Icons.shield,
                        color: _kAccent,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'SEU CLUBE',
                      style: TextStyle(
                        color: _kMuted,
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),

              // Linha animada + badge
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
                                ? _kAccent.withValues(alpha: 0.5)
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
                        color: _kCardAlt,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _kBorder),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.handshake_outlined,
                            color: _kAccent,
                            size: 10,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'ACORDO VERBAL',
                            style: TextStyle(
                              color: _kAccent,
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

              // Clube comprador
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: _kCardAlt,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _kAccent.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _kAccent.withValues(alpha: 0.08),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.shield_outlined,
                        color: _kAccent,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      controller.text.trim().isEmpty
                          ? 'COMPRADOR'
                          : controller.text.trim().toUpperCase(),
                      style: const TextStyle(
                        color: _kAccent,
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
          const Divider(color: _kBorder, height: 1),
          const SizedBox(height: 16),

          // Campo: nome do clube comprador
          _SellTextField(
            controller: controller,
            label: 'CLUBE COMPRADOR',
            icon: Icons.sports_soccer,
            hint: 'Ex.: Manchester City',
          ),
        ],
      ),
    );
  }
}

// ─── CARD VALOR DA TRANSFERÊNCIA ────────────────────────────────────────────

class _TransferValueCard extends StatelessWidget {
  final TextEditingController controller;
  final double pct;
  final Color pctColor;
  final String pctLabel;
  final String marketValue;
  final ValueChanged<String> onChanged;

  const _TransferValueCard({
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
        color: _kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.payments_outlined, color: _kAccent, size: 16),
              const SizedBox(width: 8),
              const Text(
                'VALOR DA TRANSFERÊNCIA (€)',
                style: TextStyle(
                  color: _kMuted,
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

          // Input principal
          Container(
            decoration: BoxDecoration(
              color: _kCardAlt,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _kBorder),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    '€',
                    style: TextStyle(
                      color: _kAccent,
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
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      hintText: '0',
                      hintStyle: TextStyle(color: _kMuted),
                      suffixText: 'EUR',
                      suffixStyle: TextStyle(
                        color: _kMuted,
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

          // Barra de indicador de valor
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct.clamp(0.0, 1.5) / 1.5,
              minHeight: 4,
              backgroundColor: _kCardAlt,
              valueColor: AlwaysStoppedAnimation<Color>(pctColor),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Valor de mercado: $marketValue',
                style: const TextStyle(
                  color: _kMuted,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${(pct * 100).toStringAsFixed(0)}% do VM',
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

// ─── FORMA DE PAGAMENTO ──────────────────────────────────────────────────────

class _PaymentMethodCard extends StatelessWidget {
  final PaymentMethod selected;
  final int installments;
  final TextEditingController entradaController;
  final ValueChanged<PaymentMethod> onMethodChanged;
  final ValueChanged<int> onInstallmentsChanged;
  final ValueChanged<String> onEntradaChanged;

  const _PaymentMethodCard({
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
        color: _kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                color: _kAccent,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'FORMA DE PAGAMENTO',
                style: TextStyle(
                  color: _kMuted,
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
                  selected: selected == PaymentMethod.avista,
                  onTap: () => onMethodChanged(PaymentMethod.avista),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PaymentOption(
                  icon: Icons.calendar_month_outlined,
                  label: 'PARCELADO',
                  selected: selected == PaymentMethod.parcelado,
                  onTap: () => onMethodChanged(PaymentMethod.parcelado),
                ),
              ),
            ],
          ),

          // Parcelas (só aparece quando parcelado)
          if (selected == PaymentMethod.parcelado) ...[
            const SizedBox(height: 16),
            const Divider(color: _kBorder, height: 1),
            const SizedBox(height: 14),

            // Campo valor de entrada
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.arrow_downward, color: _kAccent, size: 13),
                    SizedBox(width: 6),
                    Text(
                      'VALOR DE ENTRADA',
                      style: TextStyle(
                        color: _kAccent,
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
                    color: _kCardAlt,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _kAccent.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 14),
                        child: Text(
                          '€',
                          style: TextStyle(
                            color: _kAccent,
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
                          style: const TextStyle(
                            color: _kAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 14,
                            ),
                            hintText: '0',
                            hintStyle: TextStyle(color: _kMuted),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              'NÚMERO DE PARCELAS',
              style: TextStyle(
                color: _kMuted,
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
                            ? _kAccent.withValues(alpha: 0.12)
                            : _kCardAlt,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: sel
                              ? _kAccent.withValues(alpha: 0.7)
                              : _kBorder,
                          width: sel ? 1.5 : 1,
                        ),
                      ),
                      child: Text(
                        '${n}x',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: sel ? _kAccent : _kSubtle,
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
          color: selected ? _kAccent.withValues(alpha: 0.08) : _kCardAlt,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? _kAccent.withValues(alpha: 0.6) : _kBorder,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: selected ? _kAccent : _kSubtle),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? _kAccent : _kSubtle,
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

// ─── RESUMO FINANCEIRO ───────────────────────────────────────────────────────

class _FinancialSummary extends StatelessWidget {
  final String value;
  final PaymentMethod payment;
  final int installments;
  final double entrada;
  final double valorParcela;
  final String Function(double) fmtFn;

  const _FinancialSummary({
    required this.value,
    required this.payment,
    required this.installments,
    required this.entrada,
    required this.valorParcela,
    required this.fmtFn,
  });

  @override
  Widget build(BuildContext context) {
    final display = value.isEmpty ? '—' : '€$value';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _kBorder),
      ),
      child: Column(
        children: [
          if (payment == PaymentMethod.avista) ...[
            _SummaryRow(
              label: 'Valor da Transferência',
              value: display,
              valueColor: _kLight,
            ),
            const SizedBox(height: 10),
            const Divider(color: _kBorder, height: 1),
            const SizedBox(height: 10),
            _SummaryRow(
              label: 'VALOR DA TRANSFERÊNCIA',
              value: display,
              labelBold: true,
              valueColor: _kAccent,
              valueLarge: true,
            ),
          ] else ...[
            _SummaryRow(
              label: 'Valor de Entrada',
              value: entrada > 0 ? fmtFn(entrada) : '—',
              valueColor: _kAccent,
            ),
            const SizedBox(height: 10),
            _SummaryRow(
              label: 'Valor Parcelado',
              value: entrada > 0 && valorParcela > 0
                  ? '${installments}x ${fmtFn(valorParcela)}'
                  : '—',
              valueColor: _kAccent,
            ),
            const SizedBox(height: 10),
            const Divider(color: _kBorder, height: 1),
            const SizedBox(height: 10),
            _SummaryRow(
              label: 'VALOR DA TRANSFERÊNCIA',
              value: display,
              labelBold: true,
              valueColor: _kAccent,
              valueLarge: true,
            ),
          ],
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
            color: labelBold ? Colors.white : _kSubtle,
            fontSize: labelBold ? 11 : 11,
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
    return const Center(
      child: Text(
        'CONFIRME TODOS OS TERMOS FINANCEIROS ANTES DE PROSSEGUIR',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _kMuted,
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
          color: _kAccent,
          borderRadius: BorderRadius.circular(18),
          // boxShadow: [
          //   BoxShadow(
          //     color: _kAccent.withValues(alpha: 0.35),
          //     blurRadius: 24,
          //     spreadRadius: 2,
          //     offset: const Offset(0, 6),
          //   ),
          // ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.handshake_outlined, color: Colors.black, size: 22),
            SizedBox(width: 12),
            Text(
              'CONCLUIR TRANSFERÊNCIA',
              style: TextStyle(
                color: Colors.black,
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

// ─── CAMPO DE TEXTO PADRÃO ───────────────────────────────────────────────────

class _SellTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String hint;

  const _SellTextField({
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
            Icon(icon, color: _kAccent, size: 14),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: _kMuted,
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
            color: _kCardAlt,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _kBorder),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              hintText: hint,
              hintStyle: const TextStyle(color: _kMuted, fontSize: 13),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── DIALOG DE CONFIRMAÇÃO ───────────────────────────────────────────────────

class _ConfirmSaleDialog extends StatelessWidget {
  final PlayerProfile player;
  final String value;
  final String club;
  final PaymentMethod payment;
  final int installments;
  final VoidCallback onConfirm;

  const _ConfirmSaleDialog({
    required this.player,
    required this.value,
    required this.club,
    required this.payment,
    required this.installments,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: _kCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: _kBorder),
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
                color: _kAccent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: _kAccent.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.handshake_outlined,
                color: _kAccent,
                size: 28,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'CONFIRMAR VENDA?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${player.name} será transferido para $club por €$value.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _kSubtle,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            if (payment == PaymentMethod.parcelado) ...[
              const SizedBox(height: 4),
              Text(
                'Pagamento em ${installments}x parcelas.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: _kMuted,
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
                        color: _kCardAlt,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _kBorder),
                      ),
                      child: const Text(
                        'CANCELAR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _kSubtle,
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
                        color: _kAccent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: _kAccent.withValues(alpha: 0.3),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: const Text(
                        'CONFIRMAR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
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
