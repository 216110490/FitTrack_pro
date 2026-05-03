import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile_provider.dart';
import '../providers/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showEditDialog(BuildContext context, ProfileProvider provider) {
    final nameController = TextEditingController(text: provider.name);
    final emailController = TextEditingController(text: provider.email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                provider.updateProfile(
                  nameController.text.trim(),
                  emailController.text.trim(),
                );
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Avatar
          Center(
            child: CircleAvatar(
              radius: 55,
              backgroundImage: profile.progressImage != null
                  ? FileImage(profile.progressImage!)
                  : null,
              child: profile.progressImage == null
                  ? const Icon(Icons.person, size: 60)
                  : null,
            ),
          ),

          const SizedBox(height: 16),

          // Name
          Center(
            child: Text(
              profile.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Email
          Center(
            child: Text(
              profile.email,
              style: const TextStyle(fontSize: 16),
            ),
          ),

          const SizedBox(height: 24),

          // Edit Profile
          Card(
            child: ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              subtitle: const Text('Change name and email'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showEditDialog(context, profile),
            ),
          ),

          // Progress Photo
          Card(
            child: ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Progress Photo'),
              subtitle: const Text('Pick a photo from gallery'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: profile.pickProgressImage,
            ),
          ),

          // Dark Mode
          Card(
            child: SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              subtitle: const Text('Switch between light and dark theme'),
              value: theme.isDark,
              onChanged: theme.toggleTheme,
            ),
          ),

          // About
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
