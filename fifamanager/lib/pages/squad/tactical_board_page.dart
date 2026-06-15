import 'package:fifamanager/models/player_position.dart';
import 'package:fifamanager/models/squad_data.dart';
import 'package:flutter/material.dart';

import 'squad_page.dart';

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

  final List<PlayerPosition> players = [
    PlayerPosition(id: '1', position: 'GK', x: 150, y: 650),
    PlayerPosition(id: '2', position: 'LB', x: 40, y: 520),
    PlayerPosition(id: '3', position: 'CB', x: 120, y: 500),
    PlayerPosition(id: '4', position: 'CB', x: 220, y: 500),
    PlayerPosition(id: '5', position: 'RB', x: 300, y: 520),
    PlayerPosition(id: '6', position: 'MC', x: 90, y: 350),
    PlayerPosition(id: '7', position: 'MC', x: 180, y: 320),
    PlayerPosition(id: '8', position: 'MC', x: 270, y: 350),
    PlayerPosition(id: '9', position: 'LW', x: 60, y: 180),
    PlayerPosition(id: '10', position: 'ST', x: 180, y: 120),
    PlayerPosition(id: '11', position: 'RW', x: 300, y: 180),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F7D45),
      appBar: AppBar(
        title: const Text('Prancheta Tática'),
        backgroundColor: const Color(0xFF0F7D45),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final fieldWidth = constraints.maxWidth;
            final fieldHeight = constraints.maxHeight;

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  for (final p in players) {
                    p.showDelete = false;
                  }
                });
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(painter: FootballFieldPainter()),
                  ),

                  ...players.map((player) {
                    return Positioned(
                      left: player.x,
                      top: player.y,
                      child: GestureDetector(
                        onTap: () async {
                          // Sem jogador: abre seleção
                          if (player.player == null) {
                            _selectPlayer(player);
                            return;
                          }

                          // Já está selecionado: remove
                          if (player.showDelete) {
                            setState(() {
                              player.player = null;
                              player.showDelete = false;
                            });
                            return;
                          }

                          // Primeiro clique: mostra o X
                          setState(() {
                            for (final p in players) {
                              p.showDelete = false;
                            }

                            player.showDelete = true;
                          });
                        },

                        onPanUpdate: (details) {
                          setState(() {
                            player.x = (player.x + details.delta.dx).clamp(
                              0.0,
                              fieldWidth - 70,
                            );

                            player.y = (player.y + details.delta.dy).clamp(
                              0.0,
                              fieldHeight - 90,
                            );
                          });
                        },
                        child: PlayerWidget(
                          position: player.position,
                          player: player.player,
                          showDelete: player.showDelete,
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
            );
          },
        ),
      ),
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final String position;
  final PlayerData? player;
  final bool showDelete;
  final VoidCallback onDelete;

  const PlayerWidget({
    super.key,
    required this.position,
    required this.player,
    required this.showDelete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final hasPlayer = player != null;

    return SizedBox(
      width: 90,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 72,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  hasPlayer ? player!.name : position,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              if (showDelete)
                Positioned(
                  right: -10,
                  top: -10,
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            hasPlayer ? player!.name : 'Selecionar',
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

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

    final filteredPlayers = players.where((p) {
      return p.name.toLowerCase().contains(search.toLowerCase());
    }).toList();

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
