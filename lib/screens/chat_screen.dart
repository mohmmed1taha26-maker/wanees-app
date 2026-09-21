import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/loading_message.dart';
import '../widgets/message_input.dart';
import '../services/local_reply_service.dart';
import '../services/gemini_service.dart';

class ChatMessageModel {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessageModel({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

/// صفحة المحادثة بين المستخدم وونيس
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessageModel> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  final List<String> _suggestions = [
    'السلام عليكم',
    'وش تقدر تسوي؟',
    'كيف حالك اليوم؟',
    'من أنت؟',
    'وش اسمك؟',
  ];

  @override
  void initState() {
    super.initState();
    // رسالة الترحيب الأولى من ونيس
    _messages.add(
      ChatMessageModel(
        text:
            'يا هلا والله! أنا ونيس 🦊، خويك ورفيقك الذكي. وش في خاطرك تسولف فيه اليوم؟ تفضل أنا كلي آذان صاغية!',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _handleSendMessage(String text) async {
    if (text.trim().isEmpty || _isLoading) return;

    final userMessage = text.trim();

    setState(() {
      _messages.add(
        ChatMessageModel(
          text: userMessage,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _isLoading = true;
    });
    _scrollToBottom();

    // 1. فحص الردود المحلية أولاً
    final localReply = LocalReplyService.getReply(userMessage);

    if (localReply != null) {
      // محاكاة تأخير بسيط واقعي
      await Future.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;
      setState(() {
        _messages.add(
          ChatMessageModel(
            text: localReply,
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
        _isLoading = false;
      });
      _scrollToBottom();
      return;
    }

    // 2. إذا لم يتوفر رد محلي، نستخدم Gemini
    final geminiReply = await GeminiService.generateReply(userMessage);

    if (!mounted) return;
    setState(() {
      _messages.add(
        ChatMessageModel(
          text: geminiReply,
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
      _isLoading = false;
    });
    _scrollToBottom();
  }

  void _clearChat() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('مسح المحادثة', style: TextStyle(fontFamily: 'Tajawal')),
        content: const Text(
          'هل ترغب فعلاً في مسح سجل المحادثة والبدء من جديد؟',
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
              setState(() {
                _messages.clear();
                _messages.add(
                  ChatMessageModel(
                    text: 'بدأنا صفحة جديدة! يا هلا بك، وش تحب نسولف فيه؟ 🌟',
                    isUser: false,
                    timestamp: DateTime.now(),
                  ),
                );
              });
            },
            child: const Text('مسح', style: TextStyle(fontFamily: 'Tajawal')),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: const Center(
                    child: Text('🦊', style: TextStyle(fontSize: 20)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 11,
                    height: 11,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'ونيس',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  GeminiService.hasApiKey ? 'نشط • مدعوم بالذكاء' : 'نشط • ردود محلية',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            tooltip: 'مسح المحادثة',
            onPressed: _clearChat,
          ),
          IconButton(
            icon: const Icon(Icons.person_outline_rounded),
            tooltip: 'الملف الشخصي',
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // قائمة الرسائل
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: _messages.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length && _isLoading) {
                      return const LoadingMessage();
                    }
                    final msg = _messages[index];
                    return ChatBubble(
                      text: msg.text,
                      isUser: msg.isUser,
                      timestamp: msg.timestamp,
                    );
                  },
                ),
              ),

              // اقتراحات سريعة تظهر إذا كانت الرسائل قليلة
              if (_messages.length <= 3 && !_isLoading)
                Container(
                  height: 46,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _suggestions.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final s = _suggestions[index];
                      return ActionChip(
                        label: Text(
                          s,
                          style: const TextStyle(
                            fontFamily: 'Tajawal',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryDark,
                          ),
                        ),
                        backgroundColor: AppColors.primaryLight,
                        side: BorderSide(color: AppColors.primary.withOpacity(0.2)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () => _handleSendMessage(s),
                      );
                    },
                  ),
                ),

              // مربع كتابة الرسائل
              MessageInput(
                onSend: _handleSendMessage,
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
