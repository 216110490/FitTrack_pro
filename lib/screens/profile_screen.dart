import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile_provider.dart';
import '../providers/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 58,
              backgroundImage: profileProvider.progressImage != null
                  ? FileImage(profileProvider.progressImage!)
                  : null,
              child: profileProvider.progressImage == null
                  ? const Icon(Icons.person, size: 60)
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Student User',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const Center(child: Text('fittrack@student.com')),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Progress Photo'),
              subtitle: const Text('Pick a photo from the device gallery'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: profileProvider.pickProgressImage,
            ),
          ),
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              subtitle: const Text('Switch between light and dark theme'),
              value: themeProvider.isDark,
              onChanged: themeProvider.toggleTheme,
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About'),
              subtitle: Text(
                'FitTrack Pro is an IS487 Flutter project focused on fitness tracking.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
