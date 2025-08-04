import 'package:flutter/material.dart';
import 'package:loomai_app/src/features/character_hub/models/character.dart';
import 'package:loomai_app/src/features/character_hub/views/create_character_screen.dart';
import 'package:loomai_app/src/shared/widgets/navigation_helpers.dart';

class CharacterHubScreen extends StatefulWidget {
  const CharacterHubScreen({super.key});

  @override
  State<CharacterHubScreen> createState() => _CharacterHubScreenState();
}

class _CharacterHubScreenState extends State<CharacterHubScreen> {
  // Dummy data - now using the proper Character model
  final List<Character> _characters = [
    Character(name: 'Luna', backstory: '', personality: '', imageUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026704d'),
    Character(name: 'Orion', backstory: '', personality: '', imageUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026704e'),
    Character(name: 'Seraphina', backstory: '', personality: '', imageUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026704f'),
    Character(name: 'Kai', backstory: '', personality: '', imageUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026704g'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Hub'),
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
                // Navigate to chat with this character
                print('Start chat with ${character.name}');
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
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.2),
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
              _characters.add(newCharacter); // 這裡才能存取 _characters
            });
          }
        },
        tooltip: 'Create Character',
        child: const Icon(Icons.add),
      ),
    );
  }
}
