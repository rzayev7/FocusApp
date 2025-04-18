import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Settings ⚙️',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/images/logo.png'),
                        ),
                      ),

                    TextButton(
                      onPressed: () {
                        // Profile picture update logic here
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
            const SizedBox(height: 20),
            const Divider(),

            _SettingsTile(title: 'Theme (dark/light)', onTap: () {}),
            _SettingsTile(title: 'Change password', onTap: () {}),
            _SettingsTile(title: 'Block List', onTap: () {}),
            _SettingsTile(title: 'Preferences', onTap: () {}),
            _SettingsTile(title: 'Accessibility', onTap: () {}),
            _SettingsTile(title: 'Timezone', onTap: () {}),
            _SettingsTile(title: 'Language', onTap: () {}),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(title, style: const TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
