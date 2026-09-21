import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/brand_mark.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onStartChat});
  final VoidCallback onStartChat;
  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BrandMark(),
            const SizedBox(height: 40),
            Text(
              'مساحتك الآمنة للكلام',
              style: Theme.of(context).textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.w800, color: AppColors.ink),
            ),
            const SizedBox(height: 12),
            Text(
              'ونيس حاضر يسمعك، يفهمك، ويشاركك لحظاتك اليومية.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: onStartChat,
              icon: const Icon(Icons.chat_rounded),
              label: const Text('ابدأ محادثة جديدة'),
            ),
            const SizedBox(height: 48),
            const Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _Feature(
                  icon: Icons.favorite_rounded,
                  title: 'حديث بلا أحكام',
                  text: 'تحدث براحتك وفي أي وقت.',
                ),
                _Feature(
                  icon: Icons.lightbulb_rounded,
                  title: 'أفكار قريبة منك',
                  text: 'مساعدة لطيفة وواضحة عندما تحتاجها.',
                ),
                _Feature(
                  icon: Icons.lock_rounded,
                  title: 'خصوصيتك أولاً',
                  text: 'تجربة بسيطة تحترم مساحتك.',
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class _Feature extends StatelessWidget {
  const _Feature({required this.icon, required this.title, required this.text});
  final IconData icon;
  final String title;
  final String text;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 260,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.aqua, size: 30),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 6),
            Text(text),
          ],
        ),
      ),
    ),
  );
}
