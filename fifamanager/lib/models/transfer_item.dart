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
