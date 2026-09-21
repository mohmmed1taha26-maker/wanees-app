import 'package:flutter/material.dart';

/// نظام الألوان لتطبيق ونيس
/// ألوان دافئة، مريحة للعين، وتعكس هوية عربية ودية
class AppColors {
  // الألوان الأساسية
  static const Color primary = Color(0xFFD97736); // برتقالي دافئ أنيق
  static const Color primaryHover = Color(0xFFC36528);
  static const Color primaryLight = Color(0xFFFBF1E8);
  static const Color primaryDark = Color(0xFF9E4B18);

  // الألوان الثانوية والمساندة
  static const Color secondary = Color(0xFF4A6B82); // كحلي هادئ مريح
  static const Color secondaryLight = Color(0xFFEBF1F5);
  static const Color accent = Color(0xFFE7A054); // لمسة ذهبية دافئة

  // خلفيات التطبيق
  static const Color background = Color(0xFFFAF6F0); // بيج دافئ فائق الراحة
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF3EDE4);

  // ألوان النصوص
  static const Color textPrimary = Color(0xFF2C241E); // بني داكن مريح للقراءة
  static const Color textSecondary = Color(0xFF6F655D);
  static const Color textMuted = Color(0xFF9E948C);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ألوان فقاعات المحادثة
  static const Color userBubble = Color(0xFFD97736);
  static const Color userBubbleText = Color(0xFFFFFFFF);
  static const Color botBubble = Color(0xFFFFFFFF);
  static const Color botBubbleText = Color(0xFF2C241E);

  // الحدود والظلال
  static const Color border = Color(0xFFE9E1D7);
  static const Color borderLight = Color(0xFFF3EFE9);
  static const Color shadow = Color(0x0A2C241E);

  // الحالات
  static const Color success = Color(0xFF2D8A61);
  static const Color successLight = Color(0xFFE8F5EF);
  static const Color error = Color(0xFFD64545);
  static const Color errorLight = Color(0xFFFBECEC);
  static const Color warning = Color(0xFFE59819);
}
