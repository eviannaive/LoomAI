import 'package:flutter/material.dart';
import 'package:loomai_app/src/views/character_hub/character_hub_screen.dart';
import 'package:loomai_app/src/views/chat/chat_list_screen.dart';
import 'package:loomai_app/src/views/memory_box/memory_box_screen.dart';
import 'package:loomai_app/src/views/profile/profile_screen.dart';
import 'package:loomai_app/src/theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ChatScreen(),
    CharacterHubScreen(),
    MemoryBoxScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoomAI',
      theme: AppTheme.vibrantVioletTheme,
      home: Scaffold(
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.messenger_outlined),
              label: '對話',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.style_rounded),
              label: '靈魂編碼',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.memory), label: '回憶盒子'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '檔案'),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor:
              AppTheme.vibrantVioletTheme.colorScheme.secondary,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
