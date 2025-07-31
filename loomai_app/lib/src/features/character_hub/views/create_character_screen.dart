
import 'package:flutter/material.dart';
import 'package:loomai_app/src/features/character_hub/models/character.dart';

class CreateCharacterScreen extends StatefulWidget {
  const CreateCharacterScreen({super.key});

  @override
  State<CreateCharacterScreen> createState() => _CreateCharacterScreenState();
}

class _CreateCharacterScreenState extends State<CreateCharacterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _backstoryController = TextEditingController();
  final _personalityController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _backstoryController.dispose();
    _personalityController.dispose();
    super.dispose();
  }

  void _saveCharacter() {
    if (_formKey.currentState!.validate()) {
      final newCharacter = Character(
        name: _nameController.text,
        backstory: _backstoryController.text,
        personality: _personalityController.text,
      );
      // Pass the new character back to the previous screen
      Navigator.of(context).pop(newCharacter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Character'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveCharacter,
            tooltip: 'Save Character',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'E.g., Luna, Orion',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _backstoryController,
                decoration: const InputDecoration(
                  labelText: 'Backstory',
                  hintText: 'Describe their history and background.',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _personalityController,
                decoration: const InputDecoration(
                  labelText: 'Personality & System Prompt',
                  hintText: 'Define their traits, speaking style, likes, and dislikes. This will be used as the OpenAI system message.',
                  border: OutlineInputBorder(),
                ),
                maxLines: 8,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _saveCharacter,
                  child: const Text('Save Character'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
