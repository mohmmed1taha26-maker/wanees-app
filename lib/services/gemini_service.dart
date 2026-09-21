import 'dart:convert';
import 'package:http/http.dart' as http;

/// خدمة الاتصال بـ Gemini API لتطبيق ونيس
/// تعتمد حصريًا على متغير البيئة --dart-define=GEMINI_API_KEY
class GeminiService {
  // قراءة المفتاح بأمان تام من البيئة بدون تضمينه في الكود
  static const String apiKey = String.fromEnvironment('GEMINI_API_KEY');

  // التحقق من وجود المفتاح
  static bool get hasApiKey => apiKey.isNotEmpty;

  // رابط استدعاء Gemini API
  static const String _endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

  // التعليمات التوجيهية لهوية وشخصية "ونيس"
  static const String _systemInstruction = '''
أنت "ونيس"؛ رفيق ونديم ذكي ومساعد محادثة عربي ودود ولبق، يتميز بالدفء وخفة الظل والمصداقية.
- تحدث باللغة العربية دائماً (لهجة بيضاء لطيفة أو فصحى ميسرة وقريبة للقلب).
- أجوبتك موجزة، واضحة، تشع إيجابية ومحبة، وتساعد السائل بروح الصديق المخلص.
- تجنب التعقيد والإطالة غير الضرورية، وتفاعل باهتمام ومودة مع المستخدم.
''';

  /// إرسال رسالة المستخدم إلى Gemini والحصول على الرد
  static Future<String> generateReply(String userMessage) async {
    // في حال عدم توفر المفتاح
    if (!hasApiKey) {
      return 'أهلاً بك! مفتاح Gemini غير متوفر حالياً، أستطيع التفاعل معك عبر الردود المحلية الترحيبية والأسئلة الشائعة.';
    }

    final url = Uri.parse('$_endpoint?key=$apiKey');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({
              'systemInstruction': {
                'parts': [
                  {'text': _systemInstruction}
                ]
              },
              'contents': [
                {
                  'parts': [
                    {'text': userMessage}
                  ]
                }
              ],
              'generationConfig': {
                'temperature': 0.7,
                'maxOutputTokens': 800,
              }
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        final candidates = decoded['candidates'] as List?;
        if (candidates != null && candidates.isNotEmpty) {
          final content = candidates.first['content'];
          final parts = content?['parts'] as List?;
          if (parts != null && parts.isNotEmpty) {
            final text = parts.first['text'] as String?;
            if (text != null && text.trim().isNotEmpty) {
              return text.trim();
            }
          }
        }
        return 'تعذر الاتصال بـ Gemini، حاول مرة أخرى لاحقًا.';
      } else {
        return 'تعذر الاتصال بـ Gemini، حاول مرة أخرى لاحقًا.';
      }
    } catch (_) {
      // الالتزام التام بالنص المحدد في الشروط عند الفشل
      return 'تعذر الاتصال بـ Gemini، حاول مرة أخرى لاحقًا.';
    }
  }
}
