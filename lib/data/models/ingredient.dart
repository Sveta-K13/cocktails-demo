class Ingredient {
  final String name;
  final String image;
  final String amount;

  Ingredient(
    this.name,
    {
      this.image,
      this.amount
    }
  ) : assert(
    name != null,
  );
}