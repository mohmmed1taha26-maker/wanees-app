/// خدمة الردود المحلية الفورية لتطبيق ونيس
/// تحتوي على ردود ذكية وسريعة للتحيات والأسئلة الشائعة
class LocalReplyService {
  /// تنظيف وتطبيع النص للمقارنة الذكية
  static String _normalize(String input) {
    var text = input.trim().toLowerCase();

    // إزالة علامات الترقيم والتشكيل
    text = text.replaceAll(RegExp(r'[\?؟!.,؛،]'), '');
    text = text.replaceAll(RegExp(r'[\u064B-\u065F]'), ''); // التشكيل

    // توحيد الألفات والهمزات
    text = text.replaceAll(RegExp(r'[أإآ]'), 'ا');
    text = text.replaceAll('ة', 'ه');
    text = text.replaceAll('ى', 'ي');

    return text.trim();
  }

  /// البحث عن رد محلي، يُرجع null إذا لم يتوفر رد محلي مناسب
  static String? getReply(String userMessage) {
    final clean = _normalize(userMessage);

    // 1. السلام عليكم
    if (clean.contains('سلام عليكم') ||
        clean.contains('السلام عليكم') ||
        clean == 'سلام' ||
        clean == 'السلام') {
      return 'وعليكم السلام ورحمة الله وبركاته! يا هلا وغلا، نورت ونيس 🌟 كيف يومك اليوم؟';
    }

    // 2. مرحبا / أهلاً
    if (clean.contains('مرحبا') ||
        clean.contains('اهلين') ||
        clean.contains('يا هلا') ||
        clean.contains('اهلا') ||
        clean == 'هلا') {
      return 'يا أهلاً وسهلاً بك! أسعدتني جيتك، ونيس جاهز لأي سالفة أو سؤال ببالك 😊';
    }

    // 3. كيف حالك
    if (clean.contains('كيف حالك') ||
        clean.contains('كيفك') ||
        clean.contains('شلونك') ||
        clean.contains('شخبارك') ||
        clean.contains('عساك بخير')) {
      return 'الحمد لله بأحسن حال دامي أسولف معك! أنت بشرني عنك وعن أحوالك اليوم؟ ☕';
    }

    // 4. وش اسمك / ما اسمك
    if (clean.contains('وش اسمك') ||
        clean.contains('ما اسمك') ||
        clean.contains('شو اسمك') ||
        clean.contains('اسمك ايه') ||
        clean.contains('ايش اسمك')) {
      return 'اسمي "ونيس"! سُمّيت كذا لأني حاب أكون لك خير ونيس وصديق دايم في كل وقت 🧡';
    }

    // 5. من أنت
    if (clean.contains('من انت') ||
        clean.contains('مين انت') ||
        clean.contains('عرف عن نفسك') ||
        clean.contains('منهو انت')) {
      return 'أنا ونيس؛ رفيقك الذكي للمحادثة والمؤانسة، مصمم عشان أسولف معك بالعربي بلطف وخفة دم، وأساعدك بأي معلومة أو فكرة تحتاجها!';
    }

    // 6. وش تقدر تسوي / ماذا تستطيع
    if (clean.contains('وش تقدر تسوي') ||
        clean.contains('ماذا تستطيع') ||
        clean.contains('ايش تقدر تسوي') ||
        clean.contains('شنو تقدر تسوي') ||
        clean.contains('وش تسوي') ||
        clean.contains('مميزاتك')) {
      return 'أقدر أسولف معك بأي موضوع، أسمع لك، أجاوب على تساؤلاتك، أعطيك أفكار، وأكون ونيسك في أوقات فراغك. جرّب تسألني أي شيء!';
    }

    // ردود إضافية لطيفة شائعة
    if (clean.contains('صباح الخير') || clean.contains('صباح النور')) {
      return 'صباح الورد والسرور والبركة! أتمنى لك يوم خفيف ومليان إنجازات وسعادة ☀️';
    }

    if (clean.contains('مساء الخير') || clean.contains('مساء النور')) {
      return 'مساء السعادة والراحة والسكينة! عسى يومك كان لطيف وجميل 🌙';
    }

    if (clean.contains('شكرا') ||
        clean.contains('مشكور') ||
        clean.contains('تسلم') ||
        clean.contains('يعطيك العافيه')) {
      return 'العفو من القلب! ونيس دائمًا في خدمتك وعلى الرحب والسعة يا غالي 💛';
    }

    if (clean.contains('مع السلامه') ||
        clean.contains('باي') ||
        clean.contains('الى اللقاء') ||
        clean.contains('في امان الله')) {
      return 'في حفظ الله ورعايته! تشرفت جدًا بالسوالف معك، وتراني بانتظارك ترجع تسولف معي قريبًا 👋';
    }

    // لا يوجد رد محلي مباشر، نوجّه السؤال إلى Gemini
    return null;
  }
}
