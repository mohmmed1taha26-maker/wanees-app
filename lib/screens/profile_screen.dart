import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: const Column(
          children: [
            CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.peach,
              child: Icon(Icons.person_rounded, size: 46, color: AppColors.ink),
            ),
            SizedBox(height: 16),
            Text(
              'زائر ونيس',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text('أكمل ملفك لتجربة أكثر قرباً'),
            SizedBox(height: 28),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.badge_outlined),
                    title: Text('الاسم'),
                    subtitle: Text('زائر'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.email_outlined),
                    title: Text('البريد الإلكتروني'),
                    subtitle: Text('لم تتم إضافته بعد'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
