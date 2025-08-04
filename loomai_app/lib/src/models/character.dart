class Character {
  final String name;
  final String backstory;
  final String personality;
  final String imageUrl; //先用來demo資料
  final String greeting;
  final String userName;
  final String? userAvatarUrl;
  final String tags;
  final String gender;

  Character({
    required this.name,
    required this.backstory,
    required this.personality,
    required this.imageUrl,
    this.greeting = '',
    this.userName = '',
    this.userAvatarUrl,
    this.tags = '',
    this.gender = 'male',
  });
}
