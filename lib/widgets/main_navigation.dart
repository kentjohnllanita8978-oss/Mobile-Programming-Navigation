import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../screens/login_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/pokemon_list_screen.dart';
import '../screens/pokemon_detail_screen.dart';
import '../screens/settings_screen.dart';
import 'app_drawer.dart';

class MainNavigation extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const MainNavigation({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentTabIndex = 0; // 0: Dashboard, 1: List, 2: Settings
  Pokemon? _selectedPokemon; // Non-null when viewing Details Screen
  bool _isLoggedIn = true; // State for login view toggle

  void _onTabTapped(int index) {
    setState(() {
      _currentTabIndex = index;
      _selectedPokemon = null; // Reset details screen when changing tabs
    });
  }

  void _navigateToPokemonDetails(Pokemon pokemon) {
    setState(() {
      _selectedPokemon = pokemon;
    });
  }

  void _clearSelectedPokemon() {
    setState(() {
      _selectedPokemon = null;
    });
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
      _selectedPokemon = null;
    });
  }

  void _handleLoginSuccess() {
    setState(() {
      _isLoggedIn = true;
      _currentTabIndex = 0;
      _selectedPokemon = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // If not logged in, render the Mock Login Screen
    if (!_isLoggedIn) {
      return LoginScreen(onLoginSuccess: _handleLoginSuccess);
    }

    // If a Pokemon is selected, display the Details Screen (Redirection requirement d)
    if (_selectedPokemon != null) {
      return PokemonDetailScreen(
        pokemon: _selectedPokemon!,
        onBack: _clearSelectedPokemon,
      );
    }

    // Main tabs
    final List<Widget> pages = [
      DashboardScreen(
        onViewPokemonsPressed: () => _onTabTapped(1), // Redirection to List
        onPokemonSelected: _navigateToPokemonDetails,
      ),
      PokemonListScreen(
        onPokemonSelected: _navigateToPokemonDetails, // Redirection to Details
      ),
      SettingsScreen(
        isDarkMode: widget.isDarkMode,
        onThemeChanged: widget.onThemeChanged,
        onLogout: _handleLogout,
      ),
    ];

    final List<String> titles = [
      'PokéHub Dashboard',
      'Pokémon Collection',
      'Project Settings',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_currentTabIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (_currentTabIndex == 1)
            IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'Tap any Pokemon for Details',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tap on any Pokémon card to view details!'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
        ],
      ),
      drawer: AppDrawer(
        currentIndex: _currentTabIndex,
        onSelectTab: _onTabTapped,
        onOpenLogin: () {
          setState(() => _isLoggedIn = false);
        },
        onLogout: _handleLogout,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: pages[_currentTabIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentTabIndex,
        onDestinationSelected: _onTabTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.catching_pokemon_outlined),
            selectedIcon: Icon(Icons.catching_pokemon),
            label: 'Pokemons',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
