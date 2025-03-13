class ModelPokemon {
  final String name;
  final int id;
  final String spritesUrl;

  ModelPokemon(
      {required this.name, required this.id, required this.spritesUrl});

  factory ModelPokemon.fromJson(Map<String, dynamic> json) {
    return ModelPokemon(
      name: json['name'],
      id: json['id'],
      spritesUrl: json['sprites']['front_default'],
    );
  }
}
