
import 'package:flutter/material.dart';
import 'package:loomai_app/src/features/character_hub/views/character_hub_screen.dart';
import 'package:loomai_app/src/features/chat/views/chat_screen.dart';
import 'package:loomai_app/src/features/memory_box/views/memory_box_screen.dart';
import 'package:loomai_app/src/features/profile/views/profile_screen.dart';
import 'package:loomai_app/src/shared/theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CharacterHubScreen(),
    ChatScreen(),
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
      theme: AppTheme.darkTheme,
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Characters',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.memory),
              label: 'Memories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
