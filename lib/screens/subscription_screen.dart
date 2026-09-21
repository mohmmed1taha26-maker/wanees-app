import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_button.dart';

/// صفحة خطط الاشتراك في ونيس
class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool _isYearly = true;

  void _handleSubscribe(String planName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: const [
            Text('🌟', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Text('تأكيد الاشتراك التجريبي', style: TextStyle(fontFamily: 'Tajawal')),
          ],
        ),
        content: Text(
          'أنت بصدد اختيار خطة "$planName". هذه واجهة مبدئية فقط دون أي رسوم مالية حالياً.',
          style: const TextStyle(fontFamily: 'Tajawal', height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Tajawal')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('مبروك! تم تفعيل اشتراك "$planName" التجريبي بنجاح 🎉'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('تأكيد الاشتراك', style: TextStyle(fontFamily: 'Tajawal')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('خطط الاشتراك'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                // رأس الصفحة
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Text('💎', style: TextStyle(fontSize: 32)),
                ),
                const SizedBox(height: 14),
                const Text(
                  'اختر الخطة المناسبة لك',
                  style: AppTextStyles.heading2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                const Text(
                  'استمتع بتجربة محادثة ذكية غير محدودة مع ونيس بدون أي قيود',
                  style: AppTextStyles.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // زر التبديل بين الشهري والسنوي
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _CycleButton(
                        label: 'شهري',
                        isSelected: !_isYearly,
                        onTap: () => setState(() => _isYearly = false),
                      ),
                      _CycleButton(
                        label: 'سنوي (وفر 20%)',
                        isSelected: _isYearly,
                        onTap: () => setState(() => _isYearly = true),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // بطاقات الخطط
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 640;
                    if (isWide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildFreePlanCard(),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: _buildPremiumPlanCard(),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          _buildFreePlanCard(),
                          const SizedBox(height: 20),
                          _buildPremiumPlanCard(),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFreePlanCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'الخطة المجانية',
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'مناسبة للاستخدام اليومي الخفيف والتعرف على ونيس',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: const [
                Text(
                  '0',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  'ريال / شهرياً',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            const _PlanFeature(text: 'ردود محلية ذكية فورية'),
            const _PlanFeature(text: 'محادثات مجانية أساسية يومية'),
            const _PlanFeature(text: 'دعم كامل للغة العربية RTL'),
            const _PlanFeature(text: 'سرعة استجابة قياسية'),
            const _PlanFeature(
              text: 'دعم Gemini غير المحدود',
              isIncluded: false,
            ),
            const _PlanFeature(
              text: 'تخصيص كامل لصوت وشخصية ونيس',
              isIncluded: false,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'خطتك الحالية',
              variant: AppButtonVariant.outlined,
              isFullWidth: true,
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumPlanCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.primary, width: 2),
      ),
      color: Colors.white,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -12,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'الأكثر طلباً ⭐',
                style: TextStyle(
                  fontFamily: 'Tajawal',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ونيس بلس (Wanees Plus)',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'للمستخدمين الباحثين عن تجربة ذكاء اصطناعي كاملة وممتعة',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 18),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      _isYearly ? '19' : '25',
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _isYearly ? 'ريال / شهرياً (تدفع سنوياً)' : 'ريال / شهرياً',
                      style: const TextStyle(
                        fontFamily: 'Tajawal',
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32),
                const _PlanFeature(text: 'ردود محلية وذكاء فوري بدون توقف'),
                const _PlanFeature(text: 'رسائل غير محدودة مع ذكاء Gemini'),
                const _PlanFeature(text: 'سرعة استجابة فائقة وأولوية قصوى'),
                const _PlanFeature(text: 'حفظ وتصدير سجلات المحادثات'),
                const _PlanFeature(text: 'تخصيص أسلوب وشخصية ونيس المفضلة'),
                const _PlanFeature(text: 'شارة عضو مميز ودعم فني مخصص'),
                const SizedBox(height: 24),
                AppButton(
                  label: 'اشترك الآن في ونيس بلس',
                  variant: AppButtonVariant.primary,
                  isFullWidth: true,
                  onPressed: () => _handleSubscribe('ونيس بلس'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CycleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CycleButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Tajawal',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _PlanFeature extends StatelessWidget {
  final String text;
  final bool isIncluded;

  const _PlanFeature({
    required this.text,
    this.isIncluded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(
            isIncluded ? Icons.check_circle_rounded : Icons.cancel_outlined,
            size: 18,
            color: isIncluded ? AppColors.success : AppColors.textMuted.withOpacity(0.5),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Tajawal',
                fontSize: 14,
                color: isIncluded ? AppColors.textPrimary : AppColors.textMuted,
                decoration: isIncluded ? TextDecoration.none : TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
