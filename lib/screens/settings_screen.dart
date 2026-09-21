import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 650),
      child: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          Text(
            'الإعدادات',
            style: Theme.of(context).textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  value: isDark,
                  onChanged: onThemeChanged,
                  title: const Text('الوضع الليلي'),
                  subtitle: const Text('اختر المظهر المريح لك'),
                  secondary: const Icon(Icons.dark_mode_outlined),
                ),
                const Divider(height: 1),
                const ListTile(
                  leading: Icon(Icons.language_rounded),
                  title: Text('اللغة'),
                  trailing: Text('العربية'),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.delete_outline),
                  title: const Text('مسح بيانات المحادثة'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
