import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 820),
        child: Column(
          children: [
            Text(
              'اختر ما يناسبك',
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('اجعل وقتك مع ونيس أوسع وأقرب إليك.'),
            const SizedBox(height: 28),
            const Wrap(
              spacing: 18,
              runSpacing: 18,
              alignment: WrapAlignment.center,
              children: [
                _Plan(
                  title: 'مجاني',
                  price: '0',
                  features: ['محادثات يومية', 'ردود ذكية أساسية'],
                ),
                _Plan(
                  title: 'ونيس بلس',
                  price: '19',
                  features: [
                    'محادثات بلا حدود',
                    'ردود أسرع',
                    'أولوية للميزات الجديدة',
                  ],
                  highlighted: true,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class _Plan extends StatelessWidget {
  const _Plan({
    required this.title,
    required this.price,
    required this.features,
    this.highlighted = false,
  });
  final String title, price;
  final List<String> features;
  final bool highlighted;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 300,
    child: Card(
      color: highlighted ? AppColors.mint : null,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              '$price ر.س / شهر',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 20),
            ...features.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_outline, size: 19),
                    const SizedBox(width: 8),
                    Text(item),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                child: Text(highlighted ? 'ابدأ الآن' : 'الخطة الحالية'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
