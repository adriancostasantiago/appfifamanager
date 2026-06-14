import 'package:flutter/material.dart';

// ─── MODELOS FINANCEIROS ─────────────────────────────────────────────────────

class FinanceData {
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

  const FinanceData({
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

class FinanceItem {
  final String label;
  final String value;
  final IconData icon;

  const FinanceItem({
    required this.label,
    required this.value,
    required this.icon,
  });
}

class TransferItem {
  final String player;
  final String tipo; // 'COMPRA' | 'VENDA' | 'EMPRÉSTIMO'
  final String valor;
  final String data;
  final bool entrada;

  const TransferItem({
    required this.player,
    required this.tipo,
    required this.valor,
    required this.data,
    required this.entrada,
  });
}
