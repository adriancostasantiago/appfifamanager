import 'package:flutter/material.dart';
import 'package:fifamanager/routes/app_routes.dart';
import 'package:fifamanager/widgets/app_bottom_navigation.dart';
import 'package:fifamanager/widgets/app_drawer.dart';

enum SquadViewMode { resumo, detalhado }

final List<PlayerData> goalkeepers = [
  PlayerData(
    name: 'Marc-André Ter Stegen',
    country: 'ALEMANHA',
    position: 'GK',
    photo: '',
    ovr: 89,
    marketValue: '€12M',
    salary: '€350K/sem',
    contractUntil: '2028',
  ),
  PlayerData(
    name: 'Iñaki Peña',
    country: 'ESPANHA',
    position: 'GK',
    photo: '',
    ovr: 67,
    marketValue: '€5M',
    salary: '€80K/sem',
    contractUntil: '2026',
  ),
  PlayerData(
    name: 'Ander Astralaga',
    country: 'ESPANHA',
    position: 'GK',
    photo: '',
    ovr: 59,
    marketValue: '€1M',
    salary: '€15K/sem',
    contractUntil: '2027',
  ),
];

final List<PlayerData> defenders = [
  PlayerData(
    name: 'Ronald Araújo',
    country: 'URUGUAI',
    position: 'CB',
    photo: '',
    ovr: 49,
    marketValue: '€35M',
    salary: '€220K/sem',
    contractUntil: '2026',
  ),
  PlayerData(
    name: 'Jules Koundé',
    country: 'FRANÇA',
    position: 'RB',
    photo: '',
    ovr: 85,
    marketValue: '€55M',
    salary: '€260K/sem',
    contractUntil: '2029',
  ),
  PlayerData(
    name: 'Alejandro Balde',
    country: 'ESPANHA',
    position: 'LB',
    photo: '',
    ovr: 83,
    marketValue: '€60M',
    salary: '€240K/sem',
    contractUntil: '2028',
  ),
  PlayerData(
    name: 'Andreas Christensen',
    country: 'DINAMARCA',
    position: 'CB',
    photo: '',
    ovr: 83,
    marketValue: '€18M',
    salary: '€190K/sem',
    contractUntil: '2026',
  ),
  PlayerData(
    name: 'Eric García',
    country: 'ESPANHA',
    position: 'CB',
    photo: '',
    ovr: 80,
    marketValue: '€15M',
    salary: '€110K/sem',
    contractUntil: '2027',
  ),
  PlayerData(
    name: 'Pau Cubarsí',
    country: 'ESPANHA',
    position: 'CB',
    photo: '',
    ovr: 81,
    marketValue: '€70M',
    salary: '€90K/sem',
    contractUntil: '2030',
  ),
  PlayerData(
    name: 'Héctor Fort',
    country: 'ESPANHA',
    position: 'RB',
    photo: '',
    ovr: 73,
    marketValue: '€10M',
    salary: '€40K/sem',
    contractUntil: '2029',
  ),
  PlayerData(
    name: 'Gerard Martín',
    country: 'ESPANHA',
    position: 'LB',
    photo: '',
    ovr: 71,
    marketValue: '€8M',
    salary: '€35K/sem',
    contractUntil: '2027',
  ),
];

final List<PlayerData> midfielders = [
  PlayerData(
    name: 'Pedri González',
    country: 'ESPANHA',
    position: 'CM',
    photo: '',
    ovr: 87,
    marketValue: '€90M',
    salary: '€280K/sem',
    contractUntil: '2028',
  ),
  PlayerData(
    name: 'Frenkie de Jong',
    country: 'HOLANDA',
    position: 'CDM',
    photo: '',
    ovr: 88,
    marketValue: '€65M',
    salary: '€300K/sem',
    contractUntil: '2026',
  ),
  PlayerData(
    name: 'Gavi',
    country: 'ESPANHA',
    position: 'CM',
    photo: '',
    ovr: 85,
    marketValue: '€80M',
    salary: '€220K/sem',
    contractUntil: '2030',
  ),
  PlayerData(
    name: 'Dani Olmo',
    country: 'ESPANHA',
    position: 'CAM',
    photo: '',
    ovr: 85,
    marketValue: '€50M',
    salary: '€200K/sem',
    contractUntil: '2029',
  ),
  PlayerData(
    name: 'Fermín López',
    country: 'ESPANHA',
    position: 'CM',
    photo: '',
    ovr: 80,
    marketValue: '€40M',
    salary: '€95K/sem',
    contractUntil: '2029',
  ),
  PlayerData(
    name: 'Marc Casadó',
    country: 'ESPANHA',
    position: 'CDM',
    photo: '',
    ovr: 78,
    marketValue: '€25M',
    salary: '€60K/sem',
    contractUntil: '2028',
  ),
  PlayerData(
    name: 'Pablo Torre',
    country: 'ESPANHA',
    position: 'CAM',
    photo: '',
    ovr: 76,
    marketValue: '€12M',
    salary: '€45K/sem',
    contractUntil: '2027',
  ),
  PlayerData(
    name: 'Oriol Romeu',
    country: 'ESPANHA',
    position: 'CDM',
    photo: '',
    ovr: 77,
    marketValue: '€4M',
    salary: '€85K/sem',
    contractUntil: '2026',
  ),
  PlayerData(
    name: 'Noah Darvich',
    country: 'ALEMANHA',
    position: 'CAM',
    photo: '',
    ovr: 70,
    marketValue: '€6M',
    salary: '€20K/sem',
    contractUntil: '2027',
  ),
  PlayerData(
    name: 'Unai Hernández',
    country: 'ESPANHA',
    position: 'CM',
    photo: '',
    ovr: 68,
    marketValue: '€3M',
    salary: '€12K/sem',
    contractUntil: '2026',
  ),
];

final List<PlayerData> forwards = [
  PlayerData(
    name: 'Robert Lewandowski',
    country: 'POLÔNIA',
    position: 'ST',
    photo: '',
    ovr: 89,
    marketValue: '€15M',
    salary: '€340K/sem',
    contractUntil: '2026',
  ),
  PlayerData(
    name: 'Raphinha',
    country: 'BRASIL',
    position: 'RW',
    photo: '',
    ovr: 87,
    marketValue: '€70M',
    salary: '€230K/sem',
    contractUntil: '2027',
  ),
  PlayerData(
    name: 'Lamine Yamal',
    country: 'ESPANHA',
    position: 'RW',
    photo: '',
    ovr: 81,
    marketValue: '€150M',
    salary: '€150K/sem',
    contractUntil: '2030',
  ),
  PlayerData(
    name: 'Ferran Torres',
    country: 'ESPANHA',
    position: 'LW',
    photo: '',
    ovr: 82,
    marketValue: '€30M',
    salary: '€180K/sem',
    contractUntil: '2027',
  ),
  PlayerData(
    name: 'Ansu Fati',
    country: 'ESPANHA',
    position: 'LW',
    photo: '',
    ovr: 78,
    marketValue: '€20M',
    salary: '€140K/sem',
    contractUntil: '2027',
  ),
  PlayerData(
    name: 'Pau Víctor',
    country: 'ESPANHA',
    position: 'ST',
    photo: '',
    ovr: 73,
    marketValue: '€8M',
    salary: '€30K/sem',
    contractUntil: '2028',
  ),
  PlayerData(
    name: 'Vitor Roque',
    country: 'BRASIL',
    position: 'ST',
    photo: '',
    ovr: 79,
    marketValue: '€25M',
    salary: '€55K/sem',
    contractUntil: '2029',
  ),
];

class SquadPage extends StatefulWidget {
  const SquadPage({super.key});

  @override
  State<SquadPage> createState() => _SquadPageState();
}

class _SquadPageState extends State<SquadPage> {
  SquadViewMode _viewMode = SquadViewMode.resumo;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<PlayerData> _filter(List<PlayerData> players) {
    if (_searchQuery.trim().isEmpty) return players;
    final query = _searchQuery.trim().toLowerCase();
    return players.where((p) => p.name.toLowerCase().contains(query)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredGoalkeepers = _filter(goalkeepers);
    final filteredDefenders = _filter(defenders);
    final filteredMidfielders = _filter(midfielders);
    final filteredForwards = _filter(forwards);

    final hasResults =
        filteredGoalkeepers.isNotEmpty ||
        filteredDefenders.isNotEmpty ||
        filteredMidfielders.isNotEmpty ||
        filteredForwards.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFF101314),
      appBar: AppBar(
        backgroundColor: const Color(0xFF101314),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'FC MANAGER',
          style: TextStyle(
            color: Color(0xFF00FF41),
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ),
      drawer: const AppDrawer(activeRoute: AppRoutes.squad),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SquadStats(),
                    const SizedBox(height: 20),

                    _SquadSearchField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                      },
                    ),

                    const SizedBox(height: 24),

                    _SquadViewModeTabs(
                      activeMode: _viewMode,
                      onModeSelected: (mode) {
                        setState(() => _viewMode = mode);
                      },
                    ),

                    const SizedBox(height: 24),

                    if (!hasResults)
                      const _NoResultsMessage()
                    else ...[
                      if (filteredGoalkeepers.isNotEmpty)
                        _PositionSection(
                          title: 'GOLEIROS',
                          count: filteredGoalkeepers.length,
                          players: filteredGoalkeepers,
                          viewMode: _viewMode,
                        ),

                      if (filteredDefenders.isNotEmpty)
                        _PositionSection(
                          title: 'DEFENSORES',
                          count: filteredDefenders.length,
                          players: filteredDefenders,
                          viewMode: _viewMode,
                        ),

                      if (filteredMidfielders.isNotEmpty)
                        _PositionSection(
                          title: 'MEIAS',
                          count: filteredMidfielders.length,
                          players: filteredMidfielders,
                          viewMode: _viewMode,
                        ),

                      if (filteredForwards.isNotEmpty)
                        _PositionSection(
                          title: 'ATACANTES',
                          count: filteredForwards.length,
                          players: filteredForwards,
                          viewMode: _viewMode,
                        ),
                    ],
                  ],
                ),
              ),
            ),
            const AppBottomNavigation(activeRoute: AppRoutes.squad),
          ],
        ),
      ),
    );
  }
}

class _SquadStats extends StatelessWidget {
  const _SquadStats();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'MÉDIA OVR',
            value: '84.2',
            valueColor: Color(0xFF00FF41),
          ),
        ),
        const SizedBox(width: 10),

        Expanded(
          child: _StatCard(title: 'JOGADORES', value: '28'),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _StatCard(title: 'VALOR TOTAL', value: '€420M'),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;

  const _StatCard({
    required this.title,
    required this.value,
    this.valueColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF7C8579),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: valueColor,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

/// Campo de busca para localizar um jogador pelo nome.
class _SquadSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SquadSearchField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          isDense: true,
          filled: false,
          hintText: 'Buscar jogador...',
          hintStyle: const TextStyle(
            color: Color(0xFF7C8579),
            fontWeight: FontWeight.w600,
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF7C8579)),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF7C8579)),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

class _NoResultsMessage extends StatelessWidget {
  const _NoResultsMessage();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, color: Color(0xFF7C8579), size: 32),
          SizedBox(height: 10),
          Text(
            'Nenhum jogador encontrado',
            style: TextStyle(
              color: Color(0xFF9AA39C),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Toggle de visualização [ RESUMO ] [ DETALHADO ], no mesmo padrão visual
/// das abas "CLASSIFICAÇÃO" / "ARTILHARIA" da tela de ligas.
class _SquadViewModeTabs extends StatelessWidget {
  final SquadViewMode activeMode;
  final ValueChanged<SquadViewMode> onModeSelected;

  const _SquadViewModeTabs({
    required this.activeMode,
    required this.onModeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _SquadViewModeTabButton(
          label: 'RESUMO',
          selected: activeMode == SquadViewMode.resumo,
          onTap: () => onModeSelected(SquadViewMode.resumo),
        ),
        const SizedBox(width: 28),
        _SquadViewModeTabButton(
          label: 'DETALHADO',
          selected: activeMode == SquadViewMode.detalhado,
          onTap: () => onModeSelected(SquadViewMode.detalhado),
        ),
      ],
    );
  }
}

class _SquadViewModeTabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SquadViewModeTabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: selected
                  ? const Color(0xFF00FF41)
                  : const Color(0xFF7C8579),
              fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
              fontSize: 12,
              letterSpacing: 1.8,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 2,
            width: 80,
            decoration: BoxDecoration(
              color: selected ? const Color(0xFF00FF41) : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

class _PositionSection extends StatelessWidget {
  final String title;
  final int count;
  final List<PlayerData> players;
  final SquadViewMode viewMode;

  const _PositionSection({
    required this.title,
    required this.count,
    required this.players,
    required this.viewMode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 4, height: 28, color: const Color(0xFF00FF41)),
              const SizedBox(width: 12),

              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFD7E2D1),
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(width: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1E22),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          if (viewMode == SquadViewMode.resumo)
            ...players.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _PlayerCard(player: p),
              ),
            )
          else
            _PlayerTable(players: players),
        ],
      ),
    );
  }
}

// ─── MODO RESUMO ────────────────────────────────────────────────────────────

class _PlayerCard extends StatelessWidget {
  final PlayerData player;

  const _PlayerCard({required this.player});

  @override
  Widget build(BuildContext context) {
    final ovrColor = _getOvrColor(player.ovr);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 56,
              height: 56,
              color: const Color(0xFF1F2327),
              child: const Icon(
                Icons.person,
                size: 32,
                color: Color(0xFF7C8579),
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '${player.position} • ${player.country}',
                  style: const TextStyle(
                    color: Color(0xFF9AA39C),
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  'CONTRATO ATÉ ${player.contractUntil}',
                  style: const TextStyle(
                    color: Color(0xFF7C8579),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: ovrColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'OVR',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                Text(
                  player.ovr.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── MODO DETALHADO (TABELA) ────────────────────────────────────────────────

class _PlayerTable extends StatelessWidget {
  final List<PlayerData> players;

  const _PlayerTable({required this.players});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF16191D),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF1F2327)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Cabeçalho
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            color: const Color(0xFF1A1E22),
            child: const Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    'NOME',
                    style: TextStyle(
                      color: Color(0xFF7C8579),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'OVR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF7C8579),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'VALOR',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF7C8579),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'SALÁRIO',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF7C8579),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Linhas
          for (int i = 0; i < players.length; i++)
            Column(
              children: [
                if (i > 0) const Divider(height: 1, color: Color(0xFF1F2327)),
                _PlayerTableRow(player: players[i]),
              ],
            ),
        ],
      ),
    );
  }
}

class _PlayerTableRow extends StatefulWidget {
  final PlayerData player;

  const _PlayerTableRow({required this.player});

  @override
  State<_PlayerTableRow> createState() => _PlayerTableRowState();
}

class _PlayerTableRowState extends State<_PlayerTableRow> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final player = widget.player;
    final ovrColor = _getOvrColor(player.ovr);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _expanded = !_expanded),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Icon(
                            _expanded
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_right,
                            size: 18,
                            color: const Color(0xFF7C8579),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  player.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${player.position} • ${player.country}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xFF7C8579),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: ovrColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            player.ovr.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        player.marketValue ?? '-',
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF00FF41),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        player.salary ?? '-',
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF9AA39C),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (_expanded)
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ContractChip(contractUntil: player.contractUntil),
                      const SizedBox(height: 10),
                      _PlayerActionButtons(player: player),
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

/// Indica até quando o jogador tem contrato com o clube.
class _ContractChip extends StatelessWidget {
  final String contractUntil;

  const _ContractChip({required this.contractUntil});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1E22),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.event_note, size: 14, color: Color(0xFF7C8579)),
          const SizedBox(width: 6),
          Text(
            'CONTRATO ATÉ $contractUntil',
            style: const TextStyle(
              color: Color(0xFF9AA39C),
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

/// Ações exibidas ao expandir a linha do jogador.
class _PlayerActionButtons extends StatelessWidget {
  final PlayerData player;

  const _PlayerActionButtons({required this.player});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PlayerActionButton(
            icon: Icons.autorenew,
            label: 'RENOVAR',
            color: const Color(0xFF00FF41),
            onTap: () {
              // TODO: implementar lógica de renovação de contrato
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _PlayerActionButton(
            icon: Icons.sell_outlined,
            label: 'VENDER',
            color: const Color(0xFF4FC3F7),
            onTap: () {
              // TODO: implementar lógica de venda do jogador
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _PlayerActionButton(
            icon: Icons.swap_horiz,
            label: 'EMPRESTAR',
            color: const Color(0xFFFFB74D),
            onTap: () {
              // TODO: implementar lógica de empréstimo do jogador
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _PlayerActionButton(
            icon: Icons.person_remove_outlined,
            label: 'DISPENSAR',
            color: const Color(0xFFE53935),
            onTap: () {
              // TODO: implementar lógica de dispensa do jogador
            },
          ),
        ),
      ],
    );
  }
}

class _PlayerActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _PlayerActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1E22),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.4)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Color _getOvrColor(int ovr) {
  if (ovr <= 50) {
    return const Color(0xFFE53935); // Vermelho
  } else if (ovr <= 60) {
    return const Color(0xFFFF9800); // Laranja
  } else if (ovr <= 70) {
    return const Color.fromARGB(255, 255, 232, 29); // Amarelo
  } else if (ovr <= 80) {
    return const Color.fromARGB(255, 107, 168, 37); // Verde Claro
  } else {
    return const Color.fromARGB(255, 5, 104, 46); // Verde Escuro
  }
}

class PlayerData {
  final String name;
  final String country;
  final String position;
  final String photo;
  final int ovr;
  final String? marketValue;
  final String? salary;
  final String contractUntil;

  PlayerData({
    required this.name,
    required this.country,
    required this.position,
    required this.photo,
    required this.ovr,
    this.marketValue,
    this.salary,
    this.contractUntil = '-',
  });
}
