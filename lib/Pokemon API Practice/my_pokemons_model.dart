class MyPokemonsModel {
  final String name;
  final String spritesUrl;

  MyPokemonsModel({required this.name, required this.spritesUrl});

  factory MyPokemonsModel.fromJson(Map<String, dynamic> json) {
    return MyPokemonsModel(
      name: json['name'],
      spritesUrl: json['sprites']['front_default'],
    );
  }
}
