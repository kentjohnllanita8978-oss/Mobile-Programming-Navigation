import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final VoidCallback onLogout;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.onLogout,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _enableNotifications = true;
  bool _soundEffects = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // App Preferences Header
        Text(
          'App Preferences',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),

        // Dark Theme Switch
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: SwitchListTile(
            title: const Text('Dark Theme'),
            subtitle: const Text('Toggle between Light and Dark visual mode'),
            secondary: Icon(
              widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: theme.colorScheme.primary,
            ),
            value: widget.isDarkMode,
            onChanged: widget.onThemeChanged,
          ),
        ),

        const SizedBox(height: 8),

        // Push Notifications Switch
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: SwitchListTile(
            title: const Text('Trainer Notifications'),
            subtitle: const Text('Receive alerts for new Pokemon updates'),
            secondary: const Icon(Icons.notifications_active_outlined),
            value: _enableNotifications,
            onChanged: (val) => setState(() => _enableNotifications = val),
          ),
        ),

        const SizedBox(height: 8),

        // Sound Effects Switch
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: SwitchListTile(
            title: const Text('Sound Effects'),
            subtitle: const Text('Play sound effects on interaction'),
            secondary: const Icon(Icons.volume_up_outlined),
            value: _soundEffects,
            onChanged: (val) => setState(() => _soundEffects = val),
          ),
        ),

        const SizedBox(height: 24),

        // Storage & Cache Section
        Text(
          'Storage & Data',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),

        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: const Icon(Icons.cleaning_services_outlined),
            title: const Text('Clear Image Cache'),
            subtitle: const Text('Free up local cache storage (2.4 MB)'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Mock Image Cache cleared!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        // Project Info Section
        Text(
          'Project Info',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),

        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.catching_pokemon, color: Colors.red),
                    SizedBox(width: 12),
                    Text(
                      'PokéHub Explorer Project',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const Divider(height: 24),
                _buildInfoRow('Version', 'v1.0.0+1'),
                _buildInfoRow('Framework', 'Flutter 3.47 (Material 3)'),
                _buildInfoRow('Architecture', 'Modular 5-Screen Layout'),
                _buildInfoRow('Navigation', 'Drawer & Bottom Nav Bar'),
                _buildInfoRow('Redirection', 'Dashboard → List → Details'),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Logout Button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Mock Logout executed. Returning to login...'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              widget.onLogout();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.logout),
            label: const Text(
              'Mock Log Out',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
