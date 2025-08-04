import 'package:flutter/material.dart';
import 'package:loomai_app/src/models/character.dart';
import 'package:loomai_app/src/views/character_hub/character_detail_screen.dart';
import 'package:loomai_app/src/views/character_hub/create_character_screen.dart';
import 'package:loomai_app/src/widgets/navigation_helpers.dart';

class CharacterHubScreen extends StatefulWidget {
  const CharacterHubScreen({super.key});

  @override
  State<CharacterHubScreen> createState() => _CharacterHubScreenState();
}

class _CharacterHubScreenState extends State<CharacterHubScreen> {
  // Dummy data - now using the proper Character model
  final List<Character> _characters = [
    Character(
      name: 'Luna',
      backstory: '來自月亮的神秘少女，擁有操控夢境的能力。',
      personality: '安靜、內向，但內心充滿了對未知世界的好奇。',
      imageUrl:
          'https://api.hanximeng.com/ranimg/api.php?ts=${DateTime.now().millisecondsSinceEpoch}${UniqueKey()}',
    ),
    Character(
      name: 'Orion',
      backstory: '來自獵戶座的年輕戰士，為了尋找失落的星圖而踏上旅程。',
      personality: '勇敢、正直，有著堅定的信念和不屈不撓的精神。',
      imageUrl:
          'https://api.hanximeng.com/ranimg/api.php?ts=${DateTime.now().millisecondsSinceEpoch}${UniqueKey()}',
    ),
    Character(
      name: 'Seraphina',
      backstory: '熾天使的後裔，擁有治癒人心的歌聲。',
      personality: '溫柔、善良，對所有生命都充滿了愛與同情。',
      imageUrl:
          'https://api.hanximeng.com/ranimg/api.php?ts=${DateTime.now().millisecondsSinceEpoch}${UniqueKey()}',
    ),
    Character(
      name: 'Kai',
      backstory: '來自深海的神秘少年，能夠與海洋生物溝通。',
      personality: '自由、不羈，對陸地世界充滿了好奇與探索的慾望。',
      imageUrl:
          'https://api.hanximeng.com/ranimg/api.php?ts=${DateTime.now().millisecondsSinceEpoch}${UniqueKey()}',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('靈魂編碼'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.8,
        ),
        itemCount: _characters.length,
        itemBuilder: (context, index) {
          final character = _characters[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CharacterDetailScreen(character: character),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      character.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondary.withOpacity(0.2),
                          child: Center(
                            child: Icon(
                              Icons.error,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      character.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newCharacter = await navigateToCreateCharacter(context);
          if (newCharacter != null) {
            setState(() {
              _characters.add(newCharacter);
            });
          }
        },
        tooltip: 'Create Character',
        child: const Icon(Icons.add),
      ),
    );
  }
}
