import 'package:fifamanager/models/transfer_item.dart';

import 'finance_item.dart';

// ─── MODELOS FINANCEIROS ─────────────────────────────────────────────────────

class Finance {
  final String orcamentoTotal;
  final String orcamentoGasto;
  final double orcamentoPercent;

  final String receitaTotal;
  final String despesaTotal;
  final String saldo;
  final bool saldoPositivo;

  final String folhaSalarial;
  final String folhaMensal;

  final String valorMercadoElenco;
  final String valorMercadoMedia;

  // Dados resumidos de patrocínio (para o card de atalho)
  final String patrocinioReceita;
  final int patrocinioTotal;
  final int patrocinioVencendo;

  final List<FinanceItem> receitas;
  final List<FinanceItem> despesas;
  final List<TransferItem> transferencias;

  const Finance({
    required this.orcamentoTotal,
    required this.orcamentoGasto,
    required this.orcamentoPercent,
    required this.receitaTotal,
    required this.despesaTotal,
    required this.saldo,
    required this.saldoPositivo,
    required this.folhaSalarial,
    required this.folhaMensal,
    required this.valorMercadoElenco,
    required this.valorMercadoMedia,
    required this.patrocinioReceita,
    required this.patrocinioTotal,
    required this.patrocinioVencendo,
    required this.receitas,
    required this.despesas,
    required this.transferencias,
  });
}
