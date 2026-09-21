import 'package:flutter/material.dart';

import 'screens/app_shell.dart';
import 'screens/chat_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/subscription_screen.dart';
import 'theme/app_theme.dart';

void main() => runApp(const WaneesApp());

class WaneesApp extends StatefulWidget {
  const WaneesApp({super.key});
  @override
  State<WaneesApp> createState() => _WaneesAppState();
}

class _WaneesAppState extends State<WaneesApp> {
  bool isDark = false;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(onStartChat: () => setState(() => selectedIndex = 1)),
      const ChatScreen(),
      const SubscriptionScreen(),
      SettingsScreen(isDark: isDark, onThemeChanged: (value) => setState(() => isDark = value)),
      const ProfileScreen(),
      const LoginScreen(),
    ];
    return MaterialApp(
      title: 'ونيس', debugShowCheckedModeBanner: false,
      theme: AppTheme.light, darkTheme: AppTheme.dark,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: AppShell(selectedIndex: selectedIndex, onIndexChanged: (index) => setState(() => selectedIndex = index), child: pages[selectedIndex]),
      ),
    );
  }
}