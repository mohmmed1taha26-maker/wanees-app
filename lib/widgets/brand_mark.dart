import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.compact = false});
  final bool compact;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: compact ? 38 : 46,
        height: compact ? 38 : 46,
        decoration: BoxDecoration(
          color: AppColors.mint,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Center(
          child: Text(
            'و',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.ink,
            ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Text(
        'ونيس',
        style: TextStyle(
          fontSize: compact ? 20 : 24,
          fontWeight: FontWeight.w800,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    ],
  );
}
