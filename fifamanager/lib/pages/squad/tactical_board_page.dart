import 'package:fifamanager/models/player_position.dart';
import 'package:fifamanager/models/squad_data.dart';
import 'package:flutter/material.dart';

import 'squad_page.dart';

// Dimensões de referência usadas para calcular as posições originais
const double _kRefWidth = 300.0;
const double _kRefHeight = 600.0;

class TacticalBoardPage extends StatefulWidget {
  const TacticalBoardPage({super.key});

  @override
  State<TacticalBoardPage> createState() => _TacticalBoardPageState();
}

class _TacticalBoardPageState extends State<TacticalBoardPage> {
  Future<void> _selectPlayer(PlayerPosition slot) async {
    final selected = await showModalBottomSheet<PlayerData>(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return _PlayerPicker(position: slot.position);
      },
    );

    if (selected != null) {
      setState(() {
        slot.player = selected;
      });
    }
  }

  void _showPlayerOptions(PlayerPosition slot) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: ListTile(
            leading: const Icon(Icons.close),
            title: const Text('Remover jogador'),
            onTap: () {
              Navigator.pop(context);

              setState(() {
                slot.player = null;
              });
            },
          ),
        );
      },
    );
  }

  // Posições normalizadas (0.0–1.0): representam o canto superior-esquerdo
  // do widget do jogador em relação ao campo completo.
  // Mantidas dentro de margens seguras para qualquer proporção de tela.
  final List<PlayerPosition> players = [
    // ATAQUE  (y ~0.08–0.20)
    PlayerPosition(id: '9', position: 'LW', x: 0.05, y: 0.14),
    PlayerPosition(id: '10', position: 'ST', x: 0.38, y: 0.06),
    PlayerPosition(id: '11', position: 'RW', x: 0.68, y: 0.14),

    // MEIO  (y ~0.35–0.46)
    PlayerPosition(id: '6', position: 'MC', x: 0.08, y: 0.42),
    PlayerPosition(id: '7', position: 'MC', x: 0.38, y: 0.35),
    PlayerPosition(id: '8', position: 'MC', x: 0.65, y: 0.42),

    // DEFESA  (y ~0.60–0.68)
    PlayerPosition(id: '2', position: 'LB', x: 0.02, y: 0.62),
    PlayerPosition(id: '3', position: 'CB', x: 0.22, y: 0.60),
    PlayerPosition(id: '4', position: 'CB', x: 0.52, y: 0.60),
    PlayerPosition(id: '5', position: 'RB', x: 0.72, y: 0.62),

    // GOLEIRO  (y ~0.82)
    PlayerPosition(id: '1', position: 'GK', x: 0.38, y: 0.82),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F7D45),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 4, 31, 17),
                Color.fromARGB(255, 0, 0, 0),
              ],
            ),
          ),
          child: AppBar(
            title: const Text('Prancheta Tática'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Campo ocupa toda a tela disponível
            final double fieldWidth = constraints.maxWidth;
            final double fieldHeight = constraints.maxHeight;

            // Escala relativa à largura de referência, limitada a 1x para não crescer demais
            final double scale =
                (fieldWidth / _kRefWidth).clamp(0.0, 1.0) * 0.80;

            // Tamanhos escalados do PlayerWidget
            final double playerW = 112 * scale;
            final double playerH = 144 * scale;

            Widget fieldContent = GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  for (final p in players) {
                    p.showDelete = false;
                  }
                });
              },
              child: SizedBox(
                width: fieldWidth,
                height: fieldHeight,
                child: Stack(
                  children: [
                    // Fundo do campo
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/TacticalBoard.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),

                    // Jogadores sempre dentro dos limites do campo
                    ...players.map((player) {
                      final double left = (player.x * fieldWidth).clamp(
                        0.0,
                        fieldWidth - playerW,
                      );
                      final double top = (player.y * fieldHeight).clamp(
                        0.0,
                        fieldHeight - playerH,
                      );
                      return Positioned(
                        left: left,
                        top: top,
                        child: GestureDetector(
                          onTap: () async {
                            if (player.player == null) {
                              _selectPlayer(player);
                              return;
                            }

                            if (player.showDelete) {
                              setState(() {
                                player.player = null;
                                player.showDelete = false;
                              });
                              return;
                            }

                            setState(() {
                              for (final p in players) {
                                p.showDelete = false;
                              }
                              player.showDelete = true;
                            });
                          },

                          onPanUpdate: (details) {
                            setState(() {
                              // Atualiza coordenada normalizada
                              player.x =
                                  (player.x + details.delta.dx / fieldWidth)
                                      .clamp(0.0, 1.0 - playerW / fieldWidth);
                              player.y =
                                  (player.y + details.delta.dy / fieldHeight)
                                      .clamp(0.0, 1.0 - playerH / fieldHeight);
                            });
                          },

                          child: PlayerWidget(
                            position: player.position,
                            player: player.player,
                            showDelete: player.showDelete,
                            scale: scale,
                            onDelete: () {
                              setState(() {
                                player.player = null;
                                player.showDelete = false;
                              });
                            },
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            );

            return fieldContent;
          },
        ),
      ),
    );
  }
}

// --------------------------------------------------------------------------
// PlayerWidget com suporte a escala
// --------------------------------------------------------------------------
class PlayerWidget extends StatelessWidget {
  final PlayerData? player;
  final String position;
  final bool showDelete;
  final VoidCallback onDelete;

  /// Fator de escala calculado pelo pai (fieldWidth / _kRefWidth)
  final double scale;

  const PlayerWidget({
    super.key,
    required this.player,
    required this.position,
    required this.showDelete,
    required this.onDelete,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    // Dimensões base (referência 1x)
    final double w = 112 * scale;
    final double h = 144 * scale;
    final double shirtW = 80 * scale;
    final double ovrSize = 24 * scale;
    final double xBtnSize = 26 * scale;

    return SizedBox(
      width: w,
      height: h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // POSIÇÃO
          Positioned(
            top: 0,
            left: 48 * scale,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 6 * scale,
                vertical: 2 * scale,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4 * scale),
                boxShadow: const [
                  BoxShadow(blurRadius: 3, color: Colors.black26),
                ],
              ),
              child: Text(
                position,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10 * scale,
                ),
              ),
            ),
          ),

          // CAMISA
          Positioned(
            top: 16 * scale,
            left: 20 * scale,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 14,
                    color: showDelete
                        ? Colors.greenAccent.withValues(alpha: 0.5)
                        : Colors.black45,
                    spreadRadius: showDelete ? 2 : 0,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/shirt.png', width: shirtW),
                  Text(
                    player?.number.toString() ?? '',
                    style: TextStyle(
                      fontSize: 16 * scale,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // X (remover)
          if (showDelete)
            Positioned(
              right: 6 * scale,
              top: 24 * scale,
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  width: xBtnSize,
                  height: xBtnSize,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 14 * scale,
                  ),
                ),
              ),
            ),

          // OVR
          Positioned(
            left: 20 * scale,
            top: 16 * scale,
            child: Container(
              width: ovrSize,
              height: ovrSize,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF3C8F28),
                borderRadius: BorderRadius.circular(6 * scale),
                border: Border.all(color: Colors.white, width: 1.5),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black38,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                '${player?.ovr ?? 0}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11 * scale,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),

          // NOME
          Positioned(
            top: 64 * scale,
            left: 8 * scale,
            right: 8 * scale,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 6 * scale,
                horizontal: 8 * scale,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(6 * scale),
                boxShadow: const [
                  BoxShadow(blurRadius: 6, color: Colors.black54),
                ],
              ),
              child: Text(
                player?.name ?? 'Selecionar',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 7 * scale,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------------------
// _PlayerPicker (sem alterações de lógica)
// --------------------------------------------------------------------------
class _PlayerPicker extends StatefulWidget {
  final String position;

  const _PlayerPicker({required this.position});

  @override
  State<_PlayerPicker> createState() => _PlayerPickerState();
}

class _PlayerPickerState extends State<_PlayerPicker> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final players = squad.players.where((p) {
      switch (widget.position) {
        case 'GK':
          return p.position == 'GK';
        case 'LB':
          return p.position == 'LB';
        case 'RB':
          return p.position == 'RB';
        case 'CB':
          return p.position == 'CB';
        case 'MC':
          return ['CM', 'CDM', 'CAM'].contains(p.position);
        case 'LW':
          return p.position == 'LW';
        case 'RW':
          return p.position == 'RW';
        case 'ST':
          return p.position == 'ST';
        default:
          return true;
      }
    }).toList();

    final filteredPlayers = players
        .where((p) => p.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              'Selecionar Jogador',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Buscar jogador...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPlayers.length,
                itemBuilder: (context, index) {
                  final player = filteredPlayers[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(player.ovr.toString())),
                    title: Text(player.name),
                    subtitle: Text('${player.position} • OVR ${player.ovr}'),
                    onTap: () {
                      Navigator.pop(context, player);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------------------------
// FootballFieldPainter (sem alterações)
// --------------------------------------------------------------------------
class FootballFieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fieldPaint = Paint()..color = const Color(0xFF118C4F);

    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), fieldPaint);
    canvas.drawRect(
      Rect.fromLTWH(10, 10, size.width - 20, size.height - 20),
      linePaint,
    );
    canvas.drawLine(
      Offset(10, size.height / 2),
      Offset(size.width - 10, size.height / 2),
      linePaint,
    );
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 60, linePaint);
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      4,
      Paint()..color = Colors.white,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2 - 120, 10, 240, 120),
      linePaint,
    );
    canvas.drawRect(Rect.fromLTWH(size.width / 2 - 60, 10, 120, 50), linePaint);
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2 - 120, size.height - 130, 240, 120),
      linePaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2 - 60, size.height - 60, 120, 50),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
