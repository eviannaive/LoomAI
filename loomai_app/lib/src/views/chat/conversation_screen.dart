import 'package:flutter/material.dart';

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

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<_Message> _messages = [
    _Message("Hello! How are you today?", false),
    _Message("I'm doing great, thanks for asking!", true),
    _Message("Just enjoying the beautiful weather.", true),
    _Message("That sounds lovely. I'm glad to hear it.", false),
  ];

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    setState(() {
      _messages.insert(0, _Message(text.trim(), true));
      // 假設 AI 自動回覆
      _messages.insert(0, _Message("That's interesting! Tell me more.", false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.characterName),
        elevation: 1,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: () async {}),
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isFromUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: message.isFromUser
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isFromUser
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
        ],
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
