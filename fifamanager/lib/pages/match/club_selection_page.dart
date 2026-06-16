import 'package:fifamanager/models/club_data.dart';
import 'package:flutter/material.dart';
import 'package:fifamanager/core/theme/app_theme.dart';

class ClubSelectionPage extends StatefulWidget {
  final List<ClubData> clubs;
  final Function(ClubData) onClubSelected;

  const ClubSelectionPage({
    super.key,
    required this.clubs,
    required this.onClubSelected,
  });

  @override
  State<ClubSelectionPage> createState() => _ClubSelectionPageState();
}

class _ClubSelectionPageState extends State<ClubSelectionPage> {
  final TextEditingController _searchController = TextEditingController();

  String _search = '';

  List<ClubData> get _filteredClubs {
    final clubs = widget.clubs.where((c) {
      return c.name.toLowerCase().contains(_search.toLowerCase()) ||
          c.league.toLowerCase().contains(_search.toLowerCase());
    }).toList();

    clubs.sort((a, b) => a.name.compareTo(b.name));

    return clubs;
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
          'SELECIONAR ADVERSÁRIO',
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
                    hintText: 'Buscar clube ou liga...',
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
                    'CLUBES (${_filteredClubs.length})',
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
              child: _filteredClubs.isEmpty
                  ? _EmptyState(search: _search)
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _filteredClubs.length,
                      itemBuilder: (_, index) {
                        final club = _filteredClubs[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _SelectableClubCard(
                            club: club,
                            onTap: () {
                              widget.onClubSelected(club);
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

class _SelectableClubCard extends StatelessWidget {
  final ClubData club;
  final VoidCallback onTap;

  const _SelectableClubCard({required this.club, required this.onTap});

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
              // Escudo / logo do clube
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: colors.cardAlt,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: club.logoUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          club.logoUrl!,
                          fit: BoxFit.contain,
                          errorBuilder: (_, _, _) =>
                              Icon(Icons.shield, color: colors.muted, size: 30),
                        ),
                      )
                    : Icon(Icons.shield, color: colors.muted, size: 30),
              ),

              const SizedBox(width: 14),

              // Informações do clube
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      club.name,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      club.league,
                      style: TextStyle(
                        color: colors.subtle,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      club.country,
                      style: TextStyle(
                        color: colors.muted,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Overall / rating do clube
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: colors.accentBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: colors.accent.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'OVR',
                      style: TextStyle(
                        fontSize: 10,
                        color: colors.accent,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      club.ovr.toString(),
                      style: TextStyle(
                        color: colors.accent,
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

class _EmptyState extends StatelessWidget {
  final String search;

  const _EmptyState({required this.search});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, color: colors.muted, size: 52),
          const SizedBox(height: 16),
          Text(
            search.isEmpty
                ? 'Nenhum clube disponível'
                : 'Nenhum resultado para "$search"',
            style: TextStyle(
              color: colors.muted,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
