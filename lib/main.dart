import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;

const _geminiApiKey = String.fromEnvironment('GEMINI_API_KEY');
const _geminiModel = String.fromEnvironment(
  'GEMINI_MODEL',
  defaultValue: 'gemini-1.5-flash',
);

void main() {
  runApp(const WaneesApp());
}

class WaneesApp extends StatelessWidget {
  const WaneesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ونيس',
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0D9488),
          brightness: Brightness.light,
        ),
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: ChatPage(),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _gemini = GeminiService(apiKey: _geminiApiKey, model: _geminiModel);

  final List<ChatMessage> _messages = [
    const ChatMessage(
      text:
          'أهلًا، أنا ونيس. اكتب سؤالك أو فكرتك، وأنا أساعدك بأسلوب عربي واضح.',
      isUser: false,
    ),
  ];

  bool _isSending = false;
  bool get _hasGeminiApiKey => _geminiApiKey.trim().isNotEmpty;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isSending) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isSending = true;
      _controller.clear();
    });
    _scrollToBottom();

    final localReply = LocalReplyService.tryReply(text);
    if (localReply != null) {
      _addAssistantMessage(localReply);
      return;
    }

    if (!_hasGeminiApiKey) {
      _addAssistantMessage(
        'لم يتم ضبط مفتاح Gemini API. شغل التطبيق بهذا الشكل:\n'
        'flutter run --dart-define=GEMINI_API_KEY=YOUR_KEY',
      );
      return;
    }

    try {
      final reply = await _gemini.sendMessage(_messages.skip(1).toList());
      _addAssistantMessage(reply);
    } on GeminiException catch (error) {
      _addAssistantMessage('تعذر الاتصال بـ Gemini. ${error.message}');
    } catch (_) {
      _addAssistantMessage(
        'تعذر الاتصال بـ Gemini. تحقق من الاتصال أو مفتاح API.',
      );
    }
  }

  void _addAssistantMessage(String text) {
    if (!mounted) return;
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: false));
      _isSending = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            if (!_hasGeminiApiKey) const _ApiKeyNotice(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                itemCount: _messages.length + (_isSending ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_isSending && index == _messages.length) {
                    return const _TypingBubble();
                  }
                  return _MessageBubble(message: _messages[index]);
                },
              ),
            ),
            _InputBar(
              controller: _controller,
              isSending: _isSending,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.28)),
            ),
            child: const Icon(
              Icons.chat_bubble_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ونيس',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'رفيقك الذكي للدردشة والمساعدة اليومية',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiKeyNotice extends StatelessWidget {
  const _ApiKeyNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF59E0B).withOpacity(0.4)),
      ),
      child: const Text(
        'تنبيه: مفتاح Gemini غير موجود في الكود. أضفه وقت التشغيل باستخدام --dart-define.',
        style: TextStyle(color: Color(0xFF92400E), height: 1.5),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final alignment =
        message.isUser ? Alignment.centerRight : Alignment.centerLeft;
    final color = message.isUser ? const Color(0xFF0D9488) : Colors.white;
    final textColor = message.isUser ? Colors.white : const Color(0xFF111827);
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: Radius.circular(message.isUser ? 20 : 6),
      bottomRight: Radius.circular(message.isUser ? 6 : 20),
    );

    return Align(
      alignment: alignment,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 330),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          message.text,
          textAlign: TextAlign.start,
          style: TextStyle(color: textColor, fontSize: 15.5, height: 1.55),
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2.4),
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.isSending,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool isSending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 5,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك هنا...',
                filled: true,
                fillColor: const Color(0xFFF3F4F6),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 52,
            height: 52,
            child: FilledButton(
              onPressed: isSending ? null : onSend,
              style: FilledButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Icon(Icons.send_rounded),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  const ChatMessage({required this.text, required this.isUser});

  final String text;
  final bool isUser;
}

class LocalReplyService {
  const LocalReplyService._();

  static String? tryReply(String input) {
    final text = input.trim().toLowerCase();

    if (text.isEmpty) return null;

    if (_matchesAny(text, ['السلام عليكم', 'سلام عليكم'])) {
      return 'وعليكم السلام ورحمة الله وبركاته. حياك الله، كيف أقدر أساعدك؟';
    }

    if (_matchesAny(text, ['مرحبا', 'هلا', 'اهلا', 'أهلا'])) {
      return 'أهلًا وسهلًا. اكتب طلبك وأنا معك.';
    }

    if (_matchesAny(text, ['من انت', 'من أنت', 'وش انت', 'ما هو ونيس'])) {
      return 'أنا ونيس، مساعد دردشة عربي يساعدك في الأفكار والكتابة والأسئلة اليومية.';
    }

    return null;
  }

  static bool _matchesAny(String text, List<String> patterns) {
    return patterns.any((pattern) => text == pattern.toLowerCase());
  }
}

class GeminiService {
  const GeminiService({required this.apiKey, required this.model});

  final String apiKey;
  final String model;

  Future<String> sendMessage(List<ChatMessage> messages) async {
    final uri = Uri.https(
      'generativelanguage.googleapis.com',
      '/v1beta/models/$model:generateContent',
      {'key': apiKey},
    );

    final response = await http
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'systemInstruction': {
              'parts': [
                {
                  'text':
                      'أنت ونيس، مساعد عربي ودود وواضح. أجب بالعربية ما لم يطلب المستخدم غير ذلك.',
                },
              ],
            },
            'contents': messages
                .where((message) => message.text.trim().isNotEmpty)
                .map(
                  (message) => {
                    'role': message.isUser ? 'user' : 'model',
                    'parts': [
                      {'text': message.text},
                    ],
                  },
                )
                .toList(),
            'generationConfig': {
              'temperature': 0.7,
              'topP': 0.95,
              'maxOutputTokens': 900,
            },
          }),
        )
        .timeout(
          const Duration(seconds: 45),
          onTimeout: () => throw const GeminiException('انتهت مهلة الطلب.'),
        );

    final body = _decodeJsonObject(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final error = body['error'] as Map<String, dynamic>?;
      throw GeminiException(
        error?['message'] as String? ??
            'تحقق من مفتاح API أو اسم الموديل أو الاتصال.',
      );
    }

    final candidates = body['candidates'] as List<dynamic>?;
    final candidate = candidates == null || candidates.isEmpty
        ? null
        : candidates.first as Map<String, dynamic>?;
    final parts = (candidate?['content'] as Map<String, dynamic>?)?['parts']
        as List<dynamic>?;
    final text = parts
        ?.map((part) => (part as Map<String, dynamic>)['text'])
        .whereType<String>()
        .join('\n')
        .trim();

    if (text == null || text.isEmpty) {
      throw const GeminiException('وصل رد فارغ من Gemini. حاول بصياغة مختلفة.');
    }

    return text;
  }

  Map<String, dynamic> _decodeJsonObject(String source) {
    try {
      final decoded = jsonDecode(source);
      if (decoded is Map<String, dynamic>) return decoded;
    } catch (_) {
      throw const GeminiException('وصل رد غير مفهوم من الخدمة.');
    }

    throw const GeminiException('وصل رد غير مفهوم من الخدمة.');
  }
}

class GeminiException implements Exception {
  const GeminiException(this.message);

  final String message;
}
