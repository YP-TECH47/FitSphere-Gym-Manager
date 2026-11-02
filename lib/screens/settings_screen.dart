import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=admin'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin Portal User',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'admin@fitpro.app',
                      style: TextStyle(color: AppTheme.textSecondaryColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: Colors.white10),
          _buildSectionHeader('Gym Management'),
          _buildSettingsTile(context, FontAwesomeIcons.building, 'Gym Information'),
          _buildSettingsTile(context, FontAwesomeIcons.usersGear, 'Staff Directory'),
          _buildSettingsTile(context, FontAwesomeIcons.moneyCheckDollar, 'Billing & Taxes'),
          
          _buildSectionHeader('App Settings'),
          _buildSettingsTile(context, FontAwesomeIcons.bell, 'Notifications'),
          _buildSettingsTile(context, FontAwesomeIcons.shieldHalved, 'Security & Access'),
          _buildSettingsTile(context, FontAwesomeIcons.moon, 'Dark Mode', isSwitch: true, value: true),
          
          _buildSectionHeader('Support'),
          _buildSettingsTile(context, FontAwesomeIcons.circleQuestion, 'Help Center'),
          _buildSettingsTile(context, FontAwesomeIcons.rightFromBracket, 'Logout', color: AppTheme.errorColor),
          
          const SizedBox(height: 40),
          const Center(
            child: Text(
              'App Version 1.0.0',
              style: TextStyle(color: AppTheme.textSecondaryColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0, bottom: 8.0),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context, IconData icon, String title, {Color? color, bool isSwitch = false, bool value = false}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (color ?? AppTheme.textSecondaryColor).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color ?? AppTheme.textSecondaryColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(color: color ?? AppTheme.textPrimaryColor),
      ),
      trailing: isSwitch
          ? Switch(
              value: value,
              onChanged: (v) {},
              activeColor: AppTheme.primaryColor,
            )
          : const Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.textSecondaryColor),
      onTap: () {},
    );
  }
}
