import 'package:flutter/material.dart';

import '../widgets/brand_mark.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const BrandMark(),
            const SizedBox(height: 36),
            const Text(
              'مرحباً بعودتك',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('سجّل دخولك لتستمر مع ونيس'),
            const SizedBox(height: 32),
            const TextField(
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 14),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                child: const Text('تسجيل الدخول'),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(onPressed: () {}, child: const Text('إنشاء حساب جديد')),
          ],
        ),
      ),
    ),
  );
}
