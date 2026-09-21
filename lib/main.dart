import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/subscription_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WaneesApp());
}

/// التطبيق الرئيسي "ونيس"
class WaneesApp extends StatelessWidget {
  const WaneesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ونيس - رفيقك الذكي للمحادثة',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // الدعم الكامل للغة العربية واتجاه RTL
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('ar', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // جدول المسارات
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/chat': (context) => const ChatScreen(),
        '/login': (context) => const LoginScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/subscription': (context) => const SubscriptionScreen(),
      },
    );
  }
}
