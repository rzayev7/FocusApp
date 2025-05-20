import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../services/task_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Settings ⚙️',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                      TextButton(
                        onPressed: () {
                          _showComingSoon(context);
                        },
                        child: const Text(
                          'Change Profile Picture',
                          style: TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Card(
                color: isDark ? Colors.grey[900] : Colors.grey.shade100,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: Column(
                    children: [
                      _SettingsTile(
                        icon: isDark ? Icons.brightness_2 : Icons.brightness_7,
                        title: isDark ? 'Switch to Light Theme' : 'Switch to Dark Theme',
                        onTap: () => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      _SettingsTile(
                        icon: Icons.lock_outline,
                        title: 'Change password',
                        onTap: () => Navigator.pushNamed(context, '/change_password'),
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      _SettingsTile(
                        icon: Icons.block,
                        title: 'Block List',
                        onTap: () => _showComingSoon(context),
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      _SettingsTile(
                        icon: Icons.tune,
                        title: 'Preferences',
                        onTap: () => _showComingSoon(context),
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      _SettingsTile(
                        icon: Icons.accessibility_new,
                        title: 'Accessibility',
                        onTap: () => _showComingSoon(context),
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      _SettingsTile(
                        icon: Icons.access_time,
                        title: 'Timezone',
                        onTap: () => _showComingSoon(context),
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      _SettingsTile(
                        icon: Icons.language,
                        title: 'Language',
                        onTap: () => _showComingSoon(context),
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text('Logout', style: TextStyle(color: Colors.red)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? Colors.grey[900] : Colors.white,
                    elevation: 2,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(icon, color: color ?? Colors.black),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(fontSize: 16, color: color ?? Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
