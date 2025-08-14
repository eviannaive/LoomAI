import 'package:flutter/material.dart';
import 'package:loomai_app/src/views/home_screen.dart';

import 'package:loomai_app/src/theme/theme.dart';
import 'package:loomai_app/src/views/welcome_screen.dart';

class App extends StatelessWidget {
  final bool seenWelcome;

  const App({super.key, required this.seenWelcome});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LoomAI',
      theme: AppTheme.vibrantVioletTheme,
      initialRoute: seenWelcome ? '/home' : '/welcome',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeScreen(), // 你原本的主畫面
      },
    );
  }
}
