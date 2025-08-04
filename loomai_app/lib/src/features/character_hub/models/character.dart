
class Character {
  final String name;
  final String backstory;
  final String personality;
  final String imageUrl;

  Character({
    required this.name,
    required this.backstory,
    required this.personality,
    this.imageUrl = 'https://i.pravatar.cc/150?u=a042581f4e29026704d',
  });
}
