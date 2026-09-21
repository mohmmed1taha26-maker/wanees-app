import 'package:flutter/material.dart';

import '../services/gemini_service.dart';
import '../theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  final scrollController = ScrollController();
  final service = GeminiService();
  final messages = <ChatMessage>[
    const ChatMessage(
      text: 'أهلاً بك! أنا ونيس، كيف أستطيع مساعدتك اليوم؟',
      isUser: false,
    ),
  ];
  bool isLoading = false;

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> send([String? value]) async {
    final text = (value ?? controller.text).trim();
    if (text.isEmpty || isLoading) return;
    setState(() {
      messages.add(ChatMessage(text: text, isUser: true));
      controller.clear();
      isLoading = true;
    });
    _scrollDown();
    final reply = await service.ask(text);
    if (!mounted) return;
    setState(() {
      messages.add(ChatMessage(text: reply, isUser: false));
      isLoading = false;
    });
    _scrollDown();
  }

  void _scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  });

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.mint,
                  child: Text(
                    'و',
                    style: TextStyle(
                      color: AppColors.ink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ونيس',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text('متصل ويستمع لك'),
                  ],
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'محادثة جديدة',
                  onPressed: () => setState(
                    () => messages
                      ..clear()
                      ..add(
                        const ChatMessage(
                          text: 'أهلاً بك! كيف أستطيع مساعدتك اليوم؟',
                          isUser: false,
                        ),
                      ),
                  ),
                  icon: const Icon(Icons.refresh_rounded),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: messages.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) => index == messages.length
                  ? const _Bubble(text: 'ونيس يكتب...', isUser: false)
                  : _Bubble(
                      text: messages[index].text,
                      isUser: messages[index].isUser,
                    ),
            ),
          ),
          SizedBox(
            height: 54,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              children:
                  [
                        'السلام عليكم',
                        'وش تقدر تسوي؟',
                        'اعطني فكرة مشروع',
                        'كيف حالك؟',
                      ]
                      .map(
                        (text) => Padding(
                          padding: const EdgeInsetsDirectional.only(end: 8),
                          child: ActionChip(
                            label: Text(text),
                            onPressed: () => send(text),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 3,
                      textInputAction: TextInputAction.send,
                      decoration: const InputDecoration(
                        hintText: 'اكتب رسالتك هنا...',
                      ),
                      onSubmitted: (_) => send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    tooltip: 'إرسال',
                    onPressed: isLoading ? null : send,
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.text, required this.isUser});
  final String text;
  final bool isUser;
  @override
  Widget build(BuildContext context) => Align(
    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      constraints: const BoxConstraints(maxWidth: 600),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isUser
            ? AppColors.navy
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: TextStyle(color: isUser ? Colors.white : null, height: 1.5),
      ),
    ),
  );
}
