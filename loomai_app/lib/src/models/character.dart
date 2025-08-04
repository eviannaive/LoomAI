class Character {
  final String name;
  final String backstory;
  final String personality;
  final String imageUrl;

  Character({
    required this.name,
    required this.backstory,
    required this.personality,
    this.imageUrl = 'https://api.hanximeng.com/ranimg/api.php',
  });
}
