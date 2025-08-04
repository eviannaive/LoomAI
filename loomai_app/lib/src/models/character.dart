class Character {
  final String name;
  final String backstory;
  final String personality;
  final String imageUrl;
  final String greeting;
  final String userName;
  final String tags;
  final String gender;

  Character({
    required this.name,
    required this.backstory,
    required this.personality,
    required this.imageUrl,
    this.greeting = '',
    this.userName = '',
    this.tags = '',
    this.gender = 'male',
  });
}
