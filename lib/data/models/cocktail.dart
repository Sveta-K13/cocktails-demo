import './ingredient.dart';

class Cocktail {
  final String name;
  final String image;
  final String instruction;
  final List<String> tags;
  final List<Ingredient> ingredients;

  Cocktail({
    this.name,
    this.image,
    this.instruction,
    this.tags,
    this.ingredients
  }) : assert(
    name != null,
  );
}