import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_button.dart';

/// صفحة البداية / الرئيسية لتطبيق ونيس
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Text('🦊', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(width: 8),
            const Text(
              'ونيس',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.star_rounded, color: AppColors.accent),
            tooltip: 'الاشتراك',
            onPressed: () => Navigator.pushNamed(context, '/subscription'),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'الإعدادات',
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // الشعار / الأيقونة الترحيبية
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.12),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(color: AppColors.border, width: 2),
                  ),
                  child: const Center(
                    child: Text(
                      '🦊',
                      style: TextStyle(fontSize: 54),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // بطاقة ترحيبية صغيرة لطيفة
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'ونيس متاح الآن وجاهز للسوالف',
                        style: TextStyle(
                          fontFamily: 'Tajawal',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // اسم ونيس والترحيب
                const Text(
                  'يا أهلاً بك في ونيس',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),

                // الوصف المختصر
                const Text(
                  'رفيقك العربي الذكي للدردشة والمؤانسة.\nأسولف معك، أسمعك، وأجاوب على كل تساؤلاتك بكل لطف وذكاء.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 36),

                // أزرار البداية والدخول
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: Column(
                    children: [
                      AppButton(
                        label: 'ابدأ المحادثة الآن',
                        icon: Icons.chat_bubble_rounded,
                        isFullWidth: true,
                        height: 52,
                        onPressed: () {
                          Navigator.pushNamed(context, '/chat');
                        },
                      ),
                      const SizedBox(height: 14),
                      AppButton(
                        label: 'تسجيل الدخول',
                        icon: Icons.login_rounded,
                        variant: AppButtonVariant.outlined,
                        isFullWidth: true,
                        height: 50,
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // ميزات ونيس السريعة
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: const [
                    _FeatureChip(icon: Icons.bolt_rounded, label: 'ردود محلية فورية'),
                    _FeatureChip(icon: Icons.auto_awesome, label: 'ذكاء اصطناعي Gemini'),
                    _FeatureChip(icon: Icons.lock_outline_rounded, label: 'خصوصية وأمان'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Tajawal',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
