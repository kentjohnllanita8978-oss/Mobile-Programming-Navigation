import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final int currentIndex;
  final Function(int) onSelectTab;
  final VoidCallback onOpenLogin;
  final VoidCallback onLogout;

  const AppDrawer({
    super.key,
    required this.currentIndex,
    required this.onSelectTab,
    required this.onOpenLogin,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          // Drawer Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.tertiary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.catching_pokemon,
                size: 40,
                color: theme.colorScheme.primary,
              ),
            ),
            accountName: const Text(
              'Trainer Red',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text('trainer.red@pokemon.com'),
          ),

          // Navigation Items
          ListTile(
            leading: Icon(
              currentIndex == 0 ? Icons.dashboard : Icons.dashboard_outlined,
              color: currentIndex == 0 ? theme.colorScheme.primary : null,
            ),
            title: const Text('Dashboard'),
            selected: currentIndex == 0,
            onTap: () {
              Navigator.pop(context);
              onSelectTab(0);
            },
          ),
          ListTile(
            leading: Icon(
              currentIndex == 1
                  ? Icons.catching_pokemon
                  : Icons.catching_pokemon_outlined,
              color: currentIndex == 1 ? theme.colorScheme.primary : null,
            ),
            title: const Text('Pokémon List'),
            selected: currentIndex == 1,
            onTap: () {
              Navigator.pop(context);
              onSelectTab(1);
            },
          ),
          ListTile(
            leading: Icon(
              currentIndex == 2 ? Icons.settings : Icons.settings_outlined,
              color: currentIndex == 2 ? theme.colorScheme.primary : null,
            ),
            title: const Text('Project Settings'),
            selected: currentIndex == 2,
            onTap: () {
              Navigator.pop(context);
              onSelectTab(2);
            },
          ),

          const Divider(),

          // Auth Actions
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Mock Login Screen'),
            subtitle: const Text('View login screen sample'),
            onTap: () {
              Navigator.pop(context);
              onOpenLogin();
            },
          ),

          const Spacer(),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Mock Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              onLogout();
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
