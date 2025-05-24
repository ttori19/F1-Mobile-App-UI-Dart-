class Driver {
  final int id;
  final String name;
  final String team;
  final int number;
  final String imagePath;

  Driver({
    required this.id,
    required this.name,
    required this.team,
    required this.number,
    required this.imagePath,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      name: json['name'],
      team: json['team'],
      number: json['number'],
      imagePath: json['imagePath'],
    );
  }
}
