class Driver { //definicion de la clase y atributos
  final int id;
  final String name;
  final String team;
  final int number;
  final String imagePath;

  Driver({ //metodo constructor
    required this.id,
    required this.name,
    required this.team,
    required this.number,
    required this.imagePath,
  });

  factory Driver.fromJson(Map<String, dynamic> json) { //crea un objeto driver a partir de un map(que lee los archivos json)
    return Driver(
      id: json['id'],
      name: json['name'],
      team: json['team'],
      number: json['number'],
      imagePath: json['imagePath'],
    );
  }
}
