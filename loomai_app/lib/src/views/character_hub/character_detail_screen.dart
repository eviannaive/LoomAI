import 'package:flutter/material.dart';
import 'package:loomai_app/src/models/character.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(character.tags),
                  const SizedBox(height: 24),
                  Text('模板簡介', style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 8),
                  Text(character.backstory),
                  const SizedBox(height: 24),
                  Text('角色性別', style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 8),
                  Text(character.gender),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement memory opening functionality
                        print('Opening memories for ${character.name}');
                      },
                      child: const Text('開啟記憶'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
