import 'dart:convert';

import 'package:http/http.dart' as http;

class ChatMessage {
  const ChatMessage({required this.text, required this.isUser});
  final String text;
  final bool isUser;
}

class GeminiService {
  static const apiKey = String.fromEnvironment('GEMINI_API_KEY');
  static const model = String.fromEnvironment(
    'GEMINI_MODEL',
    defaultValue: 'gemini-1.5-flash',
  );
  static const localResponses = {
    'السلام عليكم': 'وعليكم السلام ورحمة الله وبركاته، مرحباً بك!',
    'مرحبا': 'مرحباً بك! يسعدني التحدث معك.',
    'كيف حالك': 'أنا بخير والحمد لله! كيف حالك أنت؟',
    'كيفك': 'بخير ونعمة، أتمنى أن تكون بأفضل حال.',
    'من انت': 'أنا ونيس، رفيقك الذكي للمحادثة.',
    'وش تقدر تسوي': 'أقدر أجاوبك، أقترح أفكاراً، وأساعدك في الأسئلة اليومية.',
  };

  Future<String> ask(String prompt) async {
    if (apiKey.isEmpty) return _localReply(prompt);
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey',
    );
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'text':
                      'أنت ونيس، مساعد عربي لطيف. أجب بالعربية باختصار ووضوح.\n\n$prompt',
                },
              ],
            },
          ],
        }),
      );
      if (response.statusCode != 200) return _localReply(prompt);
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['candidates']?[0]?['content']?['parts']?[0]?['text']
              ?.toString()
              .trim() ??
          _localReply(prompt);
    } catch (_) {
      return _localReply(prompt);
    }
  }

  String _localReply(String prompt) {
    final normalized = prompt.trim().replaceAll(RegExp(r'[؟?!,.،]'), '');
    for (final entry in localResponses.entries) {
      if (normalized.contains(entry.key)) return entry.value;
    }
    return 'يسعدني أن أسمع منك. وضّح لي سؤالك أكثر وسأحاول مساعدتك.';
  }
}
