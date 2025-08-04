import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loomai_app/src/models/character.dart';
import 'package:loomai_app/src/theme/input_styles.dart';
import 'package:loomai_app/src/widgets/gender_field.dart';
import 'package:image_picker/image_picker.dart';

class CreateCharacterScreen extends StatefulWidget {
  // 傳入預設角色參數
  final Character? character;

  const CreateCharacterScreen({super.key, this.character});

  @override
  State<CreateCharacterScreen> createState() => _CreateCharacterScreenState();
}

class _CreateCharacterScreenState extends State<CreateCharacterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _aiNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _templateController = TextEditingController();
  final _templateDescController = TextEditingController();
  final _greetingController = TextEditingController();
  final _tagsController = TextEditingController();
  final _genderController = TextEditingController();
  String genderValue = '';
  File? _aiAvatar;
  File? _userAvatar;

  @override
  void dispose() {
    _aiNameController.dispose();
    _userNameController.dispose();
    _imageUrlController.dispose();
    _templateController.dispose();
    _templateDescController.dispose();
    _greetingController.dispose();
    _tagsController.dispose();
    _genderController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final c = widget.character;
    if (c != null) {
      _aiNameController.text = c.name;
      _userNameController.text = c.userName ?? '';
      _imageUrlController.text = c.imageUrl ?? '';
      _templateController.text = c.personality ?? '';
      _templateDescController.text = c.backstory ?? '';
      _greetingController.text = c.greeting ?? '';
      _tagsController.text = c.tags ?? '';
      _genderController.text = c.gender ?? '';
      genderValue = c.gender ?? '';
    }
  }

  void _saveCharacter() {
    if (_formKey.currentState!.validate()) {
      final newCharacter = Character(
        name: _aiNameController.text,
        backstory: _templateDescController.text,
        personality: _templateController.text,
        imageUrl: _imageUrlController.text,
        greeting: _greetingController.text,
        userName: _userNameController.text,
        tags: _tagsController.text,
        gender: _genderController.text,
      );
      Navigator.of(context).pop(newCharacter);
    }
  }

  void _onUploadAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _aiAvatar = File(pickedFile.path);
      });
    }
  }

  void _onUploadUserAvatar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _userAvatar = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('創造角色'),
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
              const Text(
                'AI 名稱',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 左側文字與輸入框
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _aiNameController,
                          decoration: softInputDecoration('例如 Luna、Orion'),
                          validator: (value) => (value == null || value.isEmpty)
                              ? '請輸入角色名稱'
                              : null,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16), // 兩側間距
                  // 右側頭像區塊
                  GestureDetector(
                    onTap: _onUploadAvatar, // 點擊觸發上傳事件
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: (_imageUrlController.text.isNotEmpty)
                          ? NetworkImage(_imageUrlController.text)
                          : (_aiAvatar != null ? FileImage(_aiAvatar!) : null)
                                as ImageProvider?,
                      child:
                          (_imageUrlController.text.isEmpty &&
                              _aiAvatar == null)
                          ? const Icon(Icons.add_a_photo, size: 24)
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GenderField(
                onChanged: (value) {
                  genderValue = value; // 儲存選擇的性別值
                },
              ),
              const SizedBox(height: 16),

              const Text(
                '你的名稱？',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 左側文字與輸入框
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _userNameController,
                          decoration: softInputDecoration('例如 小彤、大王、主銀'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16), // 兩側間距
                  // 右側頭像區塊
                  GestureDetector(
                    onTap: _onUploadUserAvatar, // 點擊觸發上傳事件
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: _userAvatar != null
                          ? FileImage(_userAvatar!) // 預覽已選擇圖片
                          : null,
                      child: _userAvatar == null
                          ? const Icon(Icons.add_a_photo, size: 24)
                          : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Text(
                '角色模板內容',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _templateController,
                maxLines: 16,
                decoration: softInputDecoration(
                  '描述角色的語氣、知識、風格，例如：你是個天真浪漫、愛開玩笑的虛擬女友。',
                ),
              ),
              const SizedBox(height: 16),

              const Text('模板簡介', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _templateDescController,
                maxLines: 5,
                decoration: softInputDecoration('簡短描述這個角色的用途或設計理念，或是使用方式'),
              ),
              const SizedBox(height: 16),

              const Text('開場語句', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _greetingController,
                maxLines: 5,
                decoration: softInputDecoration('當你開啟對話時，角色會說的第一句話'),
              ),

              const SizedBox(height: 16),

              const Text('標籤', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _tagsController,
                maxLines: 1,
                decoration: softInputDecoration('#同人#戀與深空'),
              ),

              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _saveCharacter,
                  child: const Text('建立角色'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
