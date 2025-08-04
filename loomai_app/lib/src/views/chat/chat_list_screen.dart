import 'package:flutter/material.dart';
import 'package:loomai_app/src/views/chat/conversation_screen.dart';
import 'package:loomai_app/src/widgets/navigation_helpers.dart';

// Dummy model for a chat session
class _ChatSession {
  final String characterName;
  final String lastMessage;
  final String
  avatarUrl; // In a real app, this might be a local asset or network URL

  _ChatSession({
    required this.characterName,
    required this.lastMessage,
    required this.avatarUrl,
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Dummy data for the chat list
  final List<_ChatSession> _chatSessions = [
    _ChatSession(
      characterName: 'Luna',
      lastMessage:
          'Hey, I was just thinking about that cafe we talked about...',
      avatarUrl:
          'https://api.hanximeng.com/ranimg/api.php?ts=${DateTime.now().millisecondsSinceEpoch}${UniqueKey()}', // Placeholder path
    ),
    _ChatSession(
      characterName: 'Orion',
      lastMessage: 'The data stream is fascinating today.',
      avatarUrl:
          'https://api.hanximeng.com/ranimg/api.php?ts=${DateTime.now().millisecondsSinceEpoch}${UniqueKey()}',
    ),
    _ChatSession(
      characterName: 'Seraphina',
      lastMessage: 'Did you see the sunrise this morning? It was beautiful.',
      avatarUrl:
          'https://api.hanximeng.com/ranimg/api.php?ts=${DateTime.now().millisecondsSinceEpoch}${UniqueKey()}',
    ),
  ];

  void _navigateToConversation(String characterName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConversationScreen(characterName: characterName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('對話'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newCharacter = await navigateToCreateCharacter(context);
              if (newCharacter != null) {
                // 這裡你要決定要怎麼用 newCharacter，比如加到某個列表
                print('Created character: ${newCharacter.name}');
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _chatSessions.length,
        itemBuilder: (context, index) {
          final session = _chatSessions[index];
          return ListTile(
            leading: session.avatarUrl != null && session.avatarUrl.isNotEmpty
                ? CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(session.avatarUrl),
                  )
                : CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      session.characterName[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
            title: Text(session.characterName),
            subtitle: Text(
              session.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => _navigateToConversation(session.characterName),
          );
        },
      ),
    );
  }
}
