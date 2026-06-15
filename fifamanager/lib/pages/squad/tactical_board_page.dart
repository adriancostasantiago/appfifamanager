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
    // ATAQUE
    PlayerPosition(id: '9', position: 'LW', x: 20, y: 140),
    PlayerPosition(id: '10', position: 'ST', x: 130, y: 90),
    PlayerPosition(id: '11', position: 'RW', x: 240, y: 140),

    // MEIO
    PlayerPosition(id: '6', position: 'MC', x: 40, y: 300),
    PlayerPosition(id: '7', position: 'MC', x: 130, y: 260),
    PlayerPosition(id: '8', position: 'MC', x: 220, y: 300),

    // DEFESA
    PlayerPosition(id: '2', position: 'LB', x: 10, y: 460),
    PlayerPosition(id: '3', position: 'CB', x: 90, y: 440),
    PlayerPosition(id: '4', position: 'CB', x: 180, y: 440),
    PlayerPosition(id: '5', position: 'RB', x: 270, y: 460),

    // GOLEIRO
    PlayerPosition(id: '1', position: 'GK', x: 135, y: 550),
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
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/TacticalBoard.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //CustomPaint(painter: FootballFieldPainter()),
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
                              fieldWidth - 112.0,
                            );

                            player.y = (player.y + details.delta.dy).clamp(
                              0.0,
                              fieldHeight - 144.0,
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
  final PlayerData? player;
  final String position;
  final bool showDelete;
  final VoidCallback onDelete;

  const PlayerWidget({
    super.key,
    required this.player,
    required this.position,
    required this.showDelete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 112, // 140 -> 112
      height: 144, // 180 -> 144
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // POSIÇÃO
          Positioned(
            top: 0,
            left: 48, // 60 -> 48
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(blurRadius: 3, color: Colors.black26),
                ],
              ),
              child: Text(
                position,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ),

          // CAMISA
          Positioned(
            top: 16,
            left: 20,
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
                  Image.asset(
                    'assets/shirt.png',
                    width: 80, // 100 -> 80
                  ),

                  Text(
                    player?.number.toString() ?? '',
                    style: const TextStyle(
                      fontSize: 16, // 20 -> 16
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // X
          if (showDelete)
            Positioned(
              right: 6,
              top: 24,
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 14),
                ),
              ),
            ),

          // OVR
          Positioned(
            left: 20,
            top: 16,
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF3C8F28),
                borderRadius: BorderRadius.circular(6),
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
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),

          // NOME
          Positioned(
            top: 64, // 80 -> 64
            left: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(blurRadius: 6, color: Colors.black54),
                ],
              ),
              child: Text(
                player?.name ?? 'Selecionar',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 7,
                ),
              ),
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
