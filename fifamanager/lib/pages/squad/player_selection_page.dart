import 'package:flutter/material.dart';
import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:fifamanager/models/models.dart';

class PlayerSelectionPage extends StatefulWidget {
  final String position;
  final List<PlayerData> players;
  final Function(PlayerData) onPlayerSelected;

  const PlayerSelectionPage({
    super.key,
    required this.position,
    required this.players,
    required this.onPlayerSelected,
  });

  @override
  State<PlayerSelectionPage> createState() => _PlayerSelectionPageState();
}

class _PlayerSelectionPageState extends State<PlayerSelectionPage> {
  final TextEditingController _searchController = TextEditingController();

  String _search = '';

  List<PlayerData> get _filteredPlayers {
    final players = widget.players.where((p) {
      return p.name.toLowerCase().contains(_search.toLowerCase());
    }).toList();

    players.sort((a, b) => b.ovr.compareTo(a.ovr));

    return players;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'SELECIONAR JOGADOR',
          style: TextStyle(
            color: colors.accent,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: colors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.border),
                ),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: colors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Buscar jogador...',
                    hintStyle: TextStyle(color: colors.muted),
                    prefixIcon: Icon(Icons.search, color: colors.muted),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _search = value;
                    });
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(width: 4, height: 28, color: colors.accent),
                  const SizedBox(width: 12),
                  Text(
                    'ELENCO (${_filteredPlayers.length})',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filteredPlayers.length,
                itemBuilder: (_, index) {
                  final player = _filteredPlayers[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _SelectablePlayerCard(
                      player: player,
                      onTap: () {
                        widget.onPlayerSelected(player);
                        Navigator.pop(context);
                      },
                    ),
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

class _SelectablePlayerCard extends StatelessWidget {
  final PlayerData player;
  final VoidCallback onTap;

  const _SelectablePlayerCard({required this.player, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: colors.border),
            boxShadow: colors.cardShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: colors.cardAlt,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.person, color: colors.muted, size: 30),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '${player.position} • ${player.country}',
                      style: TextStyle(
                        color: colors.subtle,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      'Contrato: ${player.contractUntil} anos',
                      style: TextStyle(
                        color: colors.muted,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: player.ovrColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'OVR',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      player.ovr.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
