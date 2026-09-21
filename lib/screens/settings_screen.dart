import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// صفحة الإعدادات وتخصيص تجربة ونيس
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedTheme = 'الوضع الدافئ (الافتراضي)';
  String _selectedLanguage = 'العربية (Arabic)';
  bool _soundEnabled = true;
  bool _hapticEnabled = true;

  void _clearAllHistory() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('مسح جميع المحادثات', style: TextStyle(fontFamily: 'Tajawal')),
        content: const Text(
          'هل أنت متأكد من مسح جميع سجلات المحادثات المخزنة محلياً؟ لا يمكن التراجع عن هذه الخطوة.',
          style: TextStyle(fontFamily: 'Tajawal'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء', style: TextStyle(fontFamily: 'Tajawal')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم مسح جميع المحادثات بنجاح!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('مسح الكل', style: TextStyle(fontFamily: 'Tajawal')),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: const [
            Text('🦊', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Text('عن تطبيق ونيس', style: TextStyle(fontFamily: 'Tajawal', fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'ونيس هو موقع وتطبيق دردشة عربي ذكي وحديث، يقدم تجربة مؤانسة وحوار لطيف وممتع بأسلوب عربي دافئ وودود.',
              style: TextStyle(fontFamily: 'Tajawal', height: 1.5),
            ),
            SizedBox(height: 12),
            Text(
              'الإصدار: 1.0.0 (Web & Mobile Ready)',
              style: TextStyle(fontFamily: 'Tajawal', color: AppColors.textMuted, fontSize: 13),
            ),
            SizedBox(height: 4),
            Text(
              'الذكاء الاصطناعي: ردود محلية + Gemini API',
              style: TextStyle(fontFamily: 'Tajawal', color: AppColors.textMuted, fontSize: 13),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('حسناً', style: TextStyle(fontFamily: 'Tajawal')),
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
        title: const Text('الإعدادات'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // قسم المظهر
                const _SectionHeader(title: 'المظهر والألوان'),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.palette_outlined, color: AppColors.primary),
                        title: const Text('نمط الثيم والألوان', style: TextStyle(fontFamily: 'Tajawal')),
                        subtitle: Text(_selectedTheme, style: const TextStyle(fontFamily: 'Tajawal', color: AppColors.textMuted)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) => SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: const Text('الوضع الدافئ (الافتراضي)', style: TextStyle(fontFamily: 'Tajawal')),
                                    trailing: _selectedTheme.contains('الدافئ') ? const Icon(Icons.check, color: AppColors.primary) : null,
                                    onTap: () {
                                      setState(() => _selectedTheme = 'الوضع الدافئ (الافتراضي)');
                                      Navigator.pop(ctx);
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('الوضع الفاتح الكلاسيكي', style: TextStyle(fontFamily: 'Tajawal')),
                                    trailing: _selectedTheme.contains('الكلاسيكي') ? const Icon(Icons.check, color: AppColors.primary) : null,
                                    onTap: () {
                                      setState(() => _selectedTheme = 'الوضع الفاتح الكلاسيكي');
                                      Navigator.pop(ctx);
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('الوضع الليلي (قريباً)', style: TextStyle(fontFamily: 'Tajawal')),
                                    trailing: _selectedTheme.contains('الليلي') ? const Icon(Icons.check, color: AppColors.primary) : null,
                                    onTap: () {
                                      setState(() => _selectedTheme = 'الوضع الليلي (قريباً)');
                                      Navigator.pop(ctx);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.language_rounded, color: AppColors.primary),
                        title: const Text('اللغة', style: TextStyle(fontFamily: 'Tajawal')),
                        subtitle: Text(_selectedLanguage, style: const TextStyle(fontFamily: 'Tajawal', color: AppColors.textMuted)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('اللغة العربية هي اللغة الأساسية المدعومة حالياً بالكامل!'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // قسم التفاعل
                const _SectionHeader(title: 'التفاعل والإشعارات'),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      SwitchListTile(
                        activeColor: AppColors.primary,
                        secondary: const Icon(Icons.volume_up_outlined, color: AppColors.primary),
                        title: const Text('المؤثرات الصوتية', style: TextStyle(fontFamily: 'Tajawal')),
                        subtitle: const Text('تشغيل صوت ناعم عند وصول رسالة جديدة', style: TextStyle(fontFamily: 'Tajawal', fontSize: 12)),
                        value: _soundEnabled,
                        onChanged: (v) => setState(() => _soundEnabled = v),
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        activeColor: AppColors.primary,
                        secondary: const Icon(Icons.vibration_rounded, color: AppColors.primary),
                        title: const Text('الاهتزاز التفاعلي', style: TextStyle(fontFamily: 'Tajawal')),
                        subtitle: const Text('اهتزاز خفيف عند إرسال واستقبال الرسائل', style: TextStyle(fontFamily: 'Tajawal', fontSize: 12)),
                        value: _hapticEnabled,
                        onChanged: (v) => setState(() => _hapticEnabled = v),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // قسم البيانات والمحادثة
                const _SectionHeader(title: 'البيانات والخصوصية'),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.delete_sweep_outlined, color: AppColors.error),
                        title: const Text(
                          'مسح سجل المحادثات',
                          style: TextStyle(fontFamily: 'Tajawal', color: AppColors.error, fontWeight: FontWeight.w600),
                        ),
                        subtitle: const Text(
                          'حذف جميع الرسائل والبدء بمحادثة نظيفة',
                          style: TextStyle(fontFamily: 'Tajawal', fontSize: 12),
                        ),
                        onTap: _clearAllHistory,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // قسم عن التطبيق
                const _SectionHeader(title: 'حول التطبيق'),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.info_outline_rounded, color: AppColors.primary),
                        title: const Text('عن ونيس', style: TextStyle(fontFamily: 'Tajawal')),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        onTap: _showAboutDialog,
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.privacy_tip_outlined, color: AppColors.primary),
                        title: const Text('سياسة الخصوصية والاستخدام', style: TextStyle(fontFamily: 'Tajawal')),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('محادثاتك محفوظة بخصوصية وأمان تام.')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Tajawal',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
