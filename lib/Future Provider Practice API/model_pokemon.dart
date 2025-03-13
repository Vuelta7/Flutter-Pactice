class ModelPokemon {
  final String name;
  final int id;
  final String spriteUrl;

  ModelPokemon({required this.name, required this.id, required this.spriteUrl});

  factory ModelPokemon.fromJson(Map<String, dynamic> json) {
    return ModelPokemon(
      name: json['name'],
      id: json['id'],
      spriteUrl: json['sprites']['front_default'],
    );
  }
}
