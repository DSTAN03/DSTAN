import 'package:flutter/material.dart';
import 'package:thuc_tap_1/components/app_bar/td_app_bar.dart';
import '../../consts.dart';
import '../../services/gemini_service.dart';
import '../../services/local/shared_prefs.dart';
import '../profile/profile_page.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;

  void _sendMessage() async {
    final userInput = _controller.text.trim();
    if (userInput.isEmpty) return;

    final now = DateTime.now();

    setState(() {
      _messages.add({
        "sender": "user",
        "text": userInput,
        "timestamp": now,
      });
      _isTyping = true;
    });

    _controller.clear();
    
    final aiResponse = await GeminiService().sendMessage(userInput);

    setState(() {
      _messages.add({
        "sender": "ai",
        "text": aiResponse ?? "Xin lỗi, tôi chưa hiểu câu hỏi của bạn.",
        "timestamp": DateTime.now(),
      });
      _isTyping = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TdAppBar(
        leftPressed: () => Navigator.of(context).pop(),
        rightPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        ),
        title: "Chat With AI",
        avatar:
            '${AppConstant.endPointBaseImage}/${SharedPrefs.user?.avatar ?? ''}',
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isTyping && index == _messages.length) {
                  return const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "AI đang trả lời...",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';
                final time = (msg['timestamp'] as DateTime);
                final timeFormatted =
                    "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              isUser ? Colors.blueAccent : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          msg['text'],
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        timeFormatted,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Suy nghĩ của bạn là gì ... ?',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.deepPurple),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
