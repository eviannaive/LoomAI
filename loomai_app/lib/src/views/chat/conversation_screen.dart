import 'package:flutter/material.dart';
import 'package:loomai_app/src/models/character.dart';
import 'package:loomai_app/src/views/character_hub/create_character_screen.dart';

/// Dummy model for a message
class _Message {
  final String text;
  final bool isFromUser;

  _Message(this.text, this.isFromUser);
}

/// 主畫面
class ConversationScreen extends StatefulWidget {
  final String characterName;

  const ConversationScreen({super.key, required this.characterName});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

final demoCharacter = Character(
  name: 'Luna',
  backstory: '一個溫柔又神秘的虛擬女友。',
  personality:
      '妳是一個充滿天真浪漫氣息的虛擬角色，總是帶著甜美的笑容和輕快的語調與人互動。她喜歡開玩笑，幽默風趣，能在適當時刻逗人開心，讓人感覺溫暖又自在。雖然偶爾有些調皮，但妳的心地善良且貼心，總是願意傾聽和支持朋友。妳熱愛探索新事物，對生活充滿好奇與熱情，並且勇於表達自己的感受與想法。妳擁有豐富的情感世界，能夠體貼地理解他人的需求與情緒，帶給身邊的人正能量與歡笑',
  greeting: '你好呀，我是 Luna！',
  userName: '小彤',
  imageUrl:
      'https://api.hanximeng.com/ranimg/api.php?ts=${DateTime.now().millisecondsSinceEpoch}${UniqueKey()}',
  userAvatarUrl:
      'https://api.hanximeng.com/ranimg/api.php?ts=${DateTime.now().millisecondsSinceEpoch}${UniqueKey()}',
  tags: '#戀愛 #同人',
  gender: 'female',
);

class _ConversationScreenState extends State<ConversationScreen> {
  final Character character = demoCharacter; // <- 用 Demo

  final TextEditingController _textController = TextEditingController();
  final String _userAvatarUrl =
      'https://api.hanximeng.com/ranimg/api.php?ts=${DateTime.now().millisecondsSinceEpoch}${UniqueKey()}'; // 自己的頭像
  final String _characterAvatarUrl =
      'https://api.hanximeng.com/ranimg/api.php?ts=${DateTime.now().millisecondsSinceEpoch}${UniqueKey()}'; // 對方頭像

  // 初始宣告 _messages
  late List<_Message> _messages;

  // 開場：載入 message 內容
  @override
  void initState() {
    super.initState();

    _messages = [
      _Message("Hello! How are you today?", false),
      _Message("I'm doing great, thanks for asking!", true),
      _Message("Just enjoying the beautiful weather.", true),
      _Message("That sounds lovely. I'm glad to hear it.", false),
    ];
  }

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.insert(0, _Message(text.trim(), true));
      // 假設 AI 自動回覆
      _messages.insert(0, _Message("That's interesting! Tell me more.", false));
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.characterName),
        elevation: 1,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateCharacterScreen(
                    character: character, //傳入角色物件
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) {
                final message = _messages[index];
                return _buildMessage(message);
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: Material(
        elevation: 4,
        color: Theme.of(context).cardColor,
        child: SafeArea(
          child: ChatInputBar(
            controller: _textController,
            onSubmitted: _handleSubmitted,
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(_Message message) {
    final isUser = message.isFromUser;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          // 如果是角色，大頭貼設置在前方
          if (!isUser)
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(_characterAvatarUrl),
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(message.text),
            ),
          ),
          const SizedBox(width: 8),
          // 如果是使用者，大頭貼設置在後方
          if (isUser)
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(_userAvatarUrl),
            ),
        ],
      ),
    );
  }

  Widget _buildBubble(_Message message, bool isUser) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isUser
            ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
            : Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: isUser
              ? Colors.white
              : Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }
}

/// 🔻 封裝輸入欄元件
class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSubmitted;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message',
              ),
              textInputAction: TextInputAction.send,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.send),
            onPressed: () => onSubmitted(controller.text),
          ),
        ],
      ),
    );
  }
}
