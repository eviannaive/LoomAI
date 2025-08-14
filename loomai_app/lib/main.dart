import 'package:flutter/material.dart';
import 'package:loomai_app/src/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final seenWelcome = prefs.getBool('seen_welcome') ?? false;

  runApp(App(seenWelcome: seenWelcome));
}
