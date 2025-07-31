import 'package:flutter/material.dart';
import 'package:loomai_app/src/features/character_hub/models/character.dart';
import 'package:loomai_app/src/features/character_hub/views/create_character_screen.dart';

/// 導航至創建角色畫面，並回傳創建的角色（若有）
Future<Character?> navigateToCreateCharacter(BuildContext context) async {
  final newCharacter = await Navigator.push<Character>(
    context,
    MaterialPageRoute(builder: (context) => const CreateCharacterScreen()),
  );
  return newCharacter;
}
