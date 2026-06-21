import 'package:fifamanager/models/club.dart';
import 'package:fifamanager/models/formation.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/core/theme/app_theme.dart';
import 'package:fifamanager/models/models.dart';

class EditClubPage extends StatefulWidget {
  final Club? club; // null = criando novo

  const EditClubPage({super.key, this.club});

  @override
  State<EditClubPage> createState() => _EditClubPageState();
}

class _EditClubPageState extends State<EditClubPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _stadiumController;

  int _selectedShirt = 1; // 1–12
  Formation? _selectedFormation;
  String? _logoPath; // futuramente: path da imagem selecionada

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.club?.name ?? '');
    _stadiumController = TextEditingController(
      text: widget.club?.stadium ?? '',
    );
    _selectedFormation = Formations.all.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _stadiumController.dispose();
    super.dispose();
  }

  void _save() {
    // TODO: salvar via provider / bloc
    Navigator.pop(context);
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
          widget.club == null ? 'NOVO CLUBE' : 'EDITAR CLUBE',
          style: TextStyle(
            color: colors.accent,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _save,
            child: Text(
              'SALVAR',
              style: TextStyle(
                color: colors.accent,
                fontWeight: FontWeight.w900,
                fontSize: 13,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          children: [
            // ── ESCUDO ──────────────────────────────────────────────────────
            _ShieldPicker(
              logoPath: _logoPath,
              onTap: () {
                // TODO: abrir image picker
              },
            ),

            const SizedBox(height: 28),

            // ── INFORMAÇÕES ──────────────────────────────────────────────────
            _SectionHeader(label: 'INFORMAÇÕES'),
            _Card(
              children: [
                _InputTile(
                  icon: Icons.shield_outlined,
                  hint: 'Nome do clube',
                  controller: _nameController,
                ),
                _TileDivider(),
                _InputTile(
                  icon: Icons.stadium_outlined,
                  hint: 'Nome do estádio',
                  controller: _stadiumController,
                ),
              ],
            ),

            const SizedBox(height: 28),

            // ── UNIFORME ────────────────────────────────────────────────────
            _SectionHeader(label: 'UNIFORME'),
            _ShirtSelector(
              selected: _selectedShirt,
              onSelect: (i) => setState(() => _selectedShirt = i),
            ),

            const SizedBox(height: 28),

            // ── FORMAÇÃO ─────────────────────────────────────────────────────
            _SectionHeader(label: 'FORMAÇÃO PREFERIDA'),
            _FormationSelector(
              selected: _selectedFormation,
              onSelect: (f) => setState(() => _selectedFormation = f),
            ),

            const SizedBox(height: 28),

            // ── JOGADORES ────────────────────────────────────────────────────
            _SectionHeader(label: 'ELENCO'),
            _PlayersSection(players: widget.club?.players ?? []),

            const SizedBox(height: 32),

            // ── BOTÃO SALVAR ─────────────────────────────────────────────────
            _SaveButton(onPressed: _save),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ── ESCUDO ────────────────────────────────────────────────────────────────────

class _ShieldPicker extends StatelessWidget {
  final String? logoPath;
  final VoidCallback onTap;

  const _ShieldPicker({required this.logoPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: colors.card,
                shape: BoxShape.circle,
                border: Border.all(color: colors.accent, width: 2),
                boxShadow: colors.cardShadow,
              ),
              child: logoPath != null
                  ? ClipOval(child: Image.asset(logoPath!, fit: BoxFit.cover))
                  : Icon(Icons.shield, color: colors.accent, size: 52),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: colors.accent,
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.background, width: 2),
                ),
                child: Icon(Icons.camera_alt, color: colors.onAccent, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── UNIFORME ──────────────────────────────────────────────────────────────────

class _ShirtSelector extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;

  const _ShirtSelector({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        itemCount: 12,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          final number = index + 1;
          final isSelected = selected == number;

          return GestureDetector(
            onTap: () => onSelect(number),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 78,
              decoration: BoxDecoration(
                color: isSelected ? colors.accentBg : colors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? colors.accent : colors.border,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected ? colors.cardShadow : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/shirt/shirt_$number.png',
                    height: 56,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '#$number',
                    style: TextStyle(
                      color: isSelected ? colors.accent : colors.muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── FORMAÇÃO ──────────────────────────────────────────────────────────────────

class _FormationSelector extends StatelessWidget {
  final Formation? selected;
  final ValueChanged<Formation> onSelect;

  const _FormationSelector({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return _Card(
      children: Formations.all.map((formation) {
        final isSelected = selected?.name == formation.name;
        final isLast = formation == Formations.all.last;

        return Column(
          children: [
            InkWell(
              onTap: () => onSelect(formation),
              borderRadius: BorderRadius.circular(18),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: isSelected ? colors.accentBg : colors.cardAlt,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.sports_soccer,
                        color: isSelected ? colors.accent : colors.muted,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        formation.name,
                        style: TextStyle(
                          color: isSelected
                              ? colors.accent
                              : colors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    if (isSelected)
                      Icon(Icons.check_circle, color: colors.accent, size: 20)
                    else
                      Icon(
                        Icons.radio_button_unchecked,
                        color: colors.border,
                        size: 20,
                      ),
                  ],
                ),
              ),
            ),
            if (!isLast)
              Divider(
                color: colors.divider,
                height: 1,
                thickness: 1,
                indent: 68,
              ),
          ],
        );
      }).toList(),
    );
  }
}

// ── JOGADORES ─────────────────────────────────────────────────────────────────

class _PlayersSection extends StatelessWidget {
  final List<PlayerData> players;

  const _PlayersSection({required this.players});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    if (players.isEmpty) {
      return _Card(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                Icon(Icons.group_outlined, color: colors.muted, size: 40),
                const SizedBox(height: 12),
                Text(
                  'Nenhum jogador cadastrado',
                  style: TextStyle(
                    color: colors.muted,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add, color: colors.accent, size: 18),
                  label: Text(
                    'ADICIONAR JOGADOR',
                    style: TextStyle(
                      color: colors.accent,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      letterSpacing: 0.6,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: colors.accent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return _Card(
      children: [
        ...players.asMap().entries.map((entry) {
          final i = entry.key;
          final player = entry.value;
          final isLast = i == players.length - 1;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.cardAlt,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        player.number.toString(),
                        style: TextStyle(
                          color: colors.accent,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
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
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            player.position,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: colors.accentBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        player.ovr.toString(),
                        style: TextStyle(
                          color: colors.accent,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.chevron_right, color: colors.muted, size: 18),
                  ],
                ),
              ),
              if (!isLast)
                Divider(
                  color: colors.divider,
                  height: 1,
                  thickness: 1,
                  indent: 68,
                ),
            ],
          );
        }),
        // Botão adicionar ao fim da lista
        Divider(color: colors.divider, height: 1, thickness: 1),
        InkWell(
          onTap: () {},
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: colors.accent, size: 18),
                const SizedBox(width: 8),
                Text(
                  'ADICIONAR JOGADOR',
                  style: TextStyle(
                    color: colors.accent,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── COMPONENTES BASE ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 10),
      child: Row(
        children: [
          Container(width: 3, height: 16, color: colors.accent),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: colors.muted,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final List<Widget> children;
  const _Card({required this.children});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.border),
        boxShadow: colors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

class _TileDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: context.colors.divider,
      height: 1,
      thickness: 1,
      indent: 54,
    );
  }
}

class _InputTile extends StatelessWidget {
  final IconData icon;
  final String hint;
  final TextEditingController controller;

  const _InputTile({
    required this.icon,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: colors.accentBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: colors.accent, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: colors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: colors.muted,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.accent,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
        ),
        child: Text(
          'SALVAR CLUBE',
          style: TextStyle(
            color: colors.onAccent,
            fontWeight: FontWeight.w900,
            fontSize: 15,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
