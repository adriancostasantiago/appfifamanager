import 'package:flutter/material.dart';
import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:fifamanager/models/models.dart';

/// Resultado retornado ao confirmar um marcador
class GoalScorerResult {
  final PlayerData player;
  final int goalCount;
  final bool isOwnGoal;

  const GoalScorerResult({
    required this.player,
    required this.goalCount,
    required this.isOwnGoal,
  });
}

class GoalScorerSelectionPage extends StatefulWidget {
  /// Jogadores do time mandante (meu clube)
  final List<PlayerData> homePlayers;

  /// Jogadores do time visitante
  final List<PlayerData> awayPlayers;

  /// Nome do time mandante
  final String homeTeamName;

  /// Nome do time visitante
  final String awayTeamName;

  final Function(GoalScorerResult) onScorerSelected;

  /// Define qual aba abre primeiro: true = mandante, false = visitante
  final bool initialShowingHome;

  const GoalScorerSelectionPage({
    super.key,
    required this.homePlayers,
    required this.awayPlayers,
    required this.homeTeamName,
    required this.awayTeamName,
    required this.onScorerSelected,
    this.initialShowingHome = true,
  });

  @override
  State<GoalScorerSelectionPage> createState() =>
      _GoalScorerSelectionPageState();
}

class _GoalScorerSelectionPageState extends State<GoalScorerSelectionPage> {
  final TextEditingController _searchController = TextEditingController();
  String _search = '';

  late bool _showingHome;

  PlayerData? _selectedPlayer;
  int _goalCount = 1;

  @override
  void initState() {
    super.initState();
    _showingHome = widget.initialShowingHome;
  }

  List<PlayerData> get _currentPlayers =>
      _showingHome ? widget.homePlayers : widget.awayPlayers;

  List<PlayerData> get _filteredPlayers {
    final players = _currentPlayers.where((p) {
      return p.name.toLowerCase().contains(_search.toLowerCase());
    }).toList();
    players.sort((a, b) => b.ovr.compareTo(a.ovr));
    return players;
  }

  void _selectPlayer(PlayerData player) {
    setState(() {
      if (_selectedPlayer?.name == player.name) {
        _selectedPlayer = null;
        _goalCount = 1;
      } else {
        _selectedPlayer = player;
        _goalCount = 1;
      }
    });
  }

  void _confirm() {
    if (_selectedPlayer == null) return;

    // É gol contra quando o jogador escolhido é do time oposto à seção que abriu a tela.
    // Ex: seção CASA abriu (initialShowingHome=true) e usuário escolheu jogador da aba VISITANTE (_showingHome=false) → gol contra.
    final isOwnGoal = _showingHome != widget.initialShowingHome;

    widget.onScorerSelected(
      GoalScorerResult(
        player: _selectedPlayer!,
        goalCount: _goalCount,
        isOwnGoal: isOwnGoal,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // É modo "gol contra" quando a aba atual é oposta à que iniciou a seleção
    final isOwnGoalMode = _showingHome != widget.initialShowingHome;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'REGISTRAR GOL',
          style: TextStyle(
            color: colors.accent,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Toggle Casa / Visitante ──────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: _TeamToggle(
                homeTeamName: widget.homeTeamName,
                awayTeamName: widget.awayTeamName,
                showingHome: _showingHome,
                initialShowingHome: widget.initialShowingHome,
                onToggle: (value) {
                  setState(() {
                    _showingHome = value;
                    _selectedPlayer = null;
                    _goalCount = 1;
                    _search = '';
                    _searchController.clear();
                  });
                },
              ),
            ),

            // ── Banner gol contra ────────────────────────────────────────
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: isOwnGoalMode
                  ? Padding(
                      key: const ValueKey('own-goal-banner'),
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: colors.redBg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: colors.red.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.sports_soccer,
                              color: colors.red,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                // Se a seção que abriu é CASA e o usuário mudou para aba visitante
                                // → "Jogadores do visitante — gol será registrado como GOL CONTRA"
                                // Se a seção que abriu é VISITANTE e o usuário mudou para aba mandante
                                // → "Jogadores do mandante — gol será registrado como GOL CONTRA"
                                widget.initialShowingHome
                                    ? 'Jogadores do visitante — gol será registrado como GOL CONTRA'
                                    : 'Jogadores do mandante — gol será registrado como GOL CONTRA',
                                style: TextStyle(
                                  color: colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(key: ValueKey('no-banner')),
            ),

            const SizedBox(height: 14),

            // ── Busca ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onChanged: (v) => setState(() => _search = v),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // ── Label elenco ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isOwnGoalMode ? colors.red : colors.accent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'ELENCO (${_filteredPlayers.length})',
                    style: TextStyle(
                      color: colors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ── Lista de jogadores ───────────────────────────────────────
            Expanded(
              child: _filteredPlayers.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.person_search,
                            size: 48,
                            color: colors.muted,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Nenhum jogador encontrado',
                            style: TextStyle(
                              color: colors.muted,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _filteredPlayers.length,
                      itemBuilder: (_, index) {
                        final player = _filteredPlayers[index];
                        final isSelected = _selectedPlayer?.name == player.name;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _ScorerPlayerCard(
                            player: player,
                            isSelected: isSelected,
                            isOwnGoal: isOwnGoalMode,
                            goalCount: isSelected ? _goalCount : 1,
                            onTap: () => _selectPlayer(player),
                            onGoalCountChanged: isSelected
                                ? (count) => setState(() => _goalCount = count)
                                : null,
                          ),
                        );
                      },
                    ),
            ),

            // ── Painel de confirmação ────────────────────────────────────
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(anim),
                child: child,
              ),
              child: _selectedPlayer != null
                  ? _ConfirmBar(
                      key: ValueKey(_selectedPlayer!.name),
                      player: _selectedPlayer!,
                      goalCount: _goalCount,
                      isOwnGoal: isOwnGoalMode,
                      onConfirm: _confirm,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Toggle mandante / visitante
// ─────────────────────────────────────────────────────────────────────────────

class _TeamToggle extends StatelessWidget {
  final String homeTeamName;
  final String awayTeamName;
  final bool showingHome;
  final bool initialShowingHome;
  final ValueChanged<bool> onToggle;

  const _TeamToggle({
    required this.homeTeamName,
    required this.awayTeamName,
    required this.showingHome,
    required this.initialShowingHome,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    // A aba que iniciou a seleção é a "principal" — exibe MANDANTE ou VISITANTE
    // A aba oposta é sempre GOL CONTRA
    final homeSublabel = initialShowingHome ? 'MANDANTE' : 'GOL CONTRA';
    final awaySublabel = initialShowingHome ? 'GOL CONTRA' : 'VISITANTE';

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          _ToggleOption(
            label: homeTeamName,
            sublabel: homeSublabel,
            isActive: showingHome,
            activeColor: initialShowingHome ? colors.accent : colors.red,
            icon: Icons.shield,
            onTap: () => onToggle(true),
          ),
          _ToggleOption(
            label: awayTeamName,
            sublabel: awaySublabel,
            isActive: !showingHome,
            activeColor: initialShowingHome ? colors.red : colors.accent,
            icon: Icons.sports_soccer,
            onTap: () => onToggle(false),
          ),
        ],
      ),
    );
  }
}

class _ToggleOption extends StatelessWidget {
  final String label;
  final String sublabel;
  final bool isActive;
  final Color activeColor;
  final IconData icon;
  final VoidCallback onTap;

  const _ToggleOption({
    required this.label,
    required this.sublabel,
    required this.isActive,
    required this.activeColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isActive
                ? activeColor.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isActive
                  ? activeColor.withValues(alpha: 0.5)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isActive ? activeColor : colors.muted,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isActive ? activeColor : colors.muted,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      sublabel,
                      style: TextStyle(
                        color: isActive
                            ? activeColor.withValues(alpha: 0.7)
                            : colors.muted,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
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

// ─────────────────────────────────────────────────────────────────────────────
// Card do jogador selecionável
// ─────────────────────────────────────────────────────────────────────────────

class _ScorerPlayerCard extends StatelessWidget {
  final PlayerData player;
  final bool isSelected;
  final bool isOwnGoal;
  final int goalCount;
  final VoidCallback onTap;
  final ValueChanged<int>? onGoalCountChanged;

  const _ScorerPlayerCard({
    required this.player,
    required this.isSelected,
    required this.isOwnGoal,
    required this.goalCount,
    required this.onTap,
    this.onGoalCountChanged,
  });

  Color _accentFor(BuildContext context) =>
      isOwnGoal ? context.colors.red : context.colors.accent;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accent = _accentFor(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected ? accent.withValues(alpha: 0.08) : colors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected ? accent : colors.border,
          width: isSelected ? 1.5 : 1,
        ),
        boxShadow: colors.cardShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  children: [
                    // Avatar
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: colors.cardAlt,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? accent : colors.border,
                        ),
                      ),
                      child: Icon(
                        Icons.person,
                        color: isSelected ? accent : colors.muted,
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 14),

                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            player.name,
                            style: TextStyle(
                              color: isSelected ? accent : colors.textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${player.position} • ${player.country}',
                            style: TextStyle(
                              color: colors.subtle,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // OVR badge
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? accent.withValues(alpha: 0.15)
                            : player.ovrColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'OVR',
                            style: TextStyle(
                              fontSize: 9,
                              color: isSelected ? accent : Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            player.ovr.toString(),
                            style: TextStyle(
                              color: isSelected ? accent : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // ── Seletor de gols (visível só quando selecionado) ──────
                AnimatedSize(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  child: isSelected
                      ? Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: _GoalCountSelector(
                            count: goalCount,
                            accent: accent,
                            isOwnGoal: isOwnGoal,
                            onChanged: onGoalCountChanged,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Seletor de quantidade de gols
// ─────────────────────────────────────────────────────────────────────────────

class _GoalCountSelector extends StatelessWidget {
  final int count;
  final Color accent;
  final bool isOwnGoal;
  final ValueChanged<int>? onChanged;

  const _GoalCountSelector({
    required this.count,
    required this.accent,
    required this.isOwnGoal,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.sports_soccer, size: 16, color: accent),
          const SizedBox(width: 8),
          Text(
            isOwnGoal ? 'GOLS CONTRA' : 'GOLS MARCADOS',
            style: TextStyle(
              color: accent,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
          const Spacer(),
          // Botão –
          _CountButton(
            icon: Icons.remove,
            enabled: count > 1,
            accent: accent,
            onTap: () => onChanged?.call(count - 1),
          ),
          // Valor
          Container(
            width: 42,
            alignment: Alignment.center,
            child: Text(
              '$count',
              style: TextStyle(
                color: accent,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          // Botão +
          _CountButton(
            icon: Icons.add,
            enabled: count < 9,
            accent: accent,
            onTap: () => onChanged?.call(count + 1),
          ),
        ],
      ),
    );
  }
}

class _CountButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final Color accent;
  final VoidCallback onTap;

  const _CountButton({
    required this.icon,
    required this.enabled,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: enabled ? accent.withValues(alpha: 0.15) : colors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: enabled ? accent.withValues(alpha: 0.4) : colors.border,
          ),
        ),
        child: Icon(icon, size: 18, color: enabled ? accent : colors.muted),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Barra de confirmação (desliza de baixo)
// ─────────────────────────────────────────────────────────────────────────────

class _ConfirmBar extends StatelessWidget {
  final PlayerData player;
  final int goalCount;
  final bool isOwnGoal;
  final VoidCallback onConfirm;

  const _ConfirmBar({
    super.key,
    required this.player,
    required this.goalCount,
    required this.isOwnGoal,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accent = isOwnGoal ? colors.red : colors.accent;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      decoration: BoxDecoration(
        color: colors.card,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: Row(
        children: [
          // Resumo do gol
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '⚽ x$goalCount${isOwnGoal ? ' (G.C.)' : ''}',
                        style: TextStyle(
                          color: accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Botão confirmar
          SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: onConfirm,
              icon: const Icon(Icons.check, size: 18),
              label: const Text(
                'CONFIRMAR',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 0.8,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: colors.onAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
