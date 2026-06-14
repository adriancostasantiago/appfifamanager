import 'package:flutter/material.dart';

// ─── MODELOS DE PATROCÍNIO ───────────────────────────────────────────────────

enum SponsorStatus { ativo, vencendo, expirado }

class SponsorData {
  final String name;
  final String categoria;
  final String valorAnual;
  final int contratoAnos; // anos restantes
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
