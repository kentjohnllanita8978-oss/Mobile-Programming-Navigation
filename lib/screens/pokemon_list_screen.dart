import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonListScreen extends StatefulWidget {
  final Function(Pokemon) onPokemonSelected;

  const PokemonListScreen({
    super.key,
    required this.onPokemonSelected,
  });

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  String _searchQuery = '';
  String _selectedType = 'All';

  List<Pokemon> get _filteredPokemons {
    return samplePokemons.where((pokemon) {
      final matchesSearch = pokemon.name
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          pokemon.primaryType
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

      final matchesType = _selectedType == 'All' ||
          pokemon.primaryType == _selectedType ||
          pokemon.secondaryType == _selectedType;

      return matchesSearch && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final types = ['All', 'Electric', 'Fire', 'Grass', 'Water', 'Ghost'];

    return Column(
      children: [
        // Search & Filter Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            onChanged: (value) => setState(() => _searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Search Pokemon or element type...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Type Filter Chips
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: types.length,
            itemBuilder: (context, index) {
              final type = types[index];
              final isSelected = _selectedType == type;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: FilterChip(
                  selected: isSelected,
                  label: Text(type),
                  onSelected: (selected) {
                    setState(() {
                      _selectedType = selected ? type : 'All';
                    });
                  },
                  selectedColor: theme.colorScheme.primaryContainer,
                  checkmarkColor: theme.colorScheme.primary,
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        // Pokemon List View
        Expanded(
          child: _filteredPokemons.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.catching_pokemon,
                        size: 64,
                        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No Pokémon found matching your search',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredPokemons.length,
                  itemBuilder: (context, index) {
                    final pokemon = _filteredPokemons[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => widget.onPokemonSelected(pokemon),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                // Pokemon Thumbnail Card
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: pokemon.typeColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Hero(
                                    tag: 'pokemon-${pokemon.id}',
                                    child: Image.network(
                                      pokemon.imageUrl,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) =>
                                          const Icon(
                                        Icons.catching_pokemon,
                                        size: 48,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),

                                // Pokemon Details Summary
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            pokemon.name,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '#${pokemon.id.toString().padLeft(3, '0')}',
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: theme
                                                  .colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          _buildTypeBadge(
                                            pokemon.primaryType,
                                            pokemon.typeColor,
                                          ),
                                          if (pokemon.secondaryType != null) ...[
                                            const SizedBox(width: 6),
                                            _buildTypeBadge(
                                              pokemon.secondaryType!,
                                              Colors.grey,
                                            ),
                                          ],
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'HP: ${pokemon.hp} | ATK: ${pokemon.attack} | SPD: ${pokemon.speed}',
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: theme
                                              .colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildTypeBadge(String type, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        type,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
