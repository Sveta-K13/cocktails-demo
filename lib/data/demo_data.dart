import './models/cocktail.dart';
import './models/ingredient.dart';

class DemoData {
  List<Cocktail> _cocktails = [
    Cocktail(
      name: 'Black Russian',
      image: 'blackRussian.jpg',
      instruction: 'Pour the ingredients into an old fashioned glass filled with ice cubes. Stir gently.',
      tags: [
        'IBA', 'ContemporaryClassic',
      ],
      ingredients: [
        // TODO
        Ingredient('Coffee Liqueur', image: 'coffeeLiqueur.png', amount: '3/4 oz'),
        Ingredient('Vodka', image: 'vodka.png', amount: '1 1/2 oz'),
      ],
    ),
    Cocktail(
      name: 'Mojito',
      image: 'mojito.jpg',
      instruction: 'Muddle mint leaves with sugar and lime juice. Add a splash of soda water and fill the glass with cracked ice. Pour the rum and top with soda water. Garnish and serve with straw.',
      tags: [
        'IBA', 'ContemporaryClassic', 'Alcoholic', 'USA',
      ],
      ingredients: [
        Ingredient('Light rum', image: 'lightRum.png', amount: '2-3 oz'),
        Ingredient('Lime', image: 'lime.png', amount: 'Juice of 1'),
        Ingredient('Sugar', image: 'sugar.png', amount: '2 tsp'),
        Ingredient('Mint', image: 'mint.png', amount: '2-4'),
        Ingredient('Soda water', image: 'sodaWater.png', amount: ''),
      ],
    ),
    Cocktail(
      name: 'Long Island Tea',
      image: 'longIsland.jpg',
      instruction: 'Combine all ingredients (except cola) and pour over ice in a highball glass. Add the splash of cola for color. Decorate with a slice of lemon and serve.',
      tags: [
        'Strong', 'Asia', 'StrongFlavor', 'Brunch', 'Vegetarian',
      ],
      ingredients: [
        Ingredient('Vodka', image: 'vodka.png', amount: '1/2 oz'),
        Ingredient('Light rum', image: 'lightRum.png', amount: '1/2 oz'),
        Ingredient('Gin', image: 'gin.png', amount: '1/2 oz'),
        Ingredient('Tequila', image: 'tequila.png', amount: '1/2 oz'),
        Ingredient('Lemon', image: 'lemon.png', amount: 'Juice of 1/2'),
        Ingredient('Coca-cola', image: 'coca-cola.png', amount: '1 splash'),
      ],
    ),
    Cocktail(
      name: 'Negroni',
      image: 'negroni.jpg',
      instruction: 'Stir into glass over ice, garnish and serve.',
      tags: [
        'IBA', 'Classic',
      ],
      ingredients: [
        Ingredient('Gin', image: 'gin.png', amount: '1 oz'),
        Ingredient('Campari', image: 'campari.png', amount: '1 oz'),
        Ingredient('Sweet Vermouth', image: 'sweetVermouth.png', amount: '1 oz'),
      ],
    ),
    Cocktail(
      name: 'Daiquiri',
      image: 'daiquiri.jpg',
      instruction: 'Pour all ingredients into shaker with ice cubes. Shake well. Strain in chilled cocktail glass.',
      tags: [
        'IBA', 'Classic', 'Beach',
      ],
      ingredients: [
        Ingredient('Light rum', image: 'lightRum.png', amount: '1 1/2 oz'),
        Ingredient('Lime', image: 'lime.png', amount: 'Juice of 1/2'),
        Ingredient('Powdered sugar', image: 'powderedSugar.png', amount: '1 tsp'),
      ],
    ),
  ];

  List<Cocktail> getCocktails() => _cocktails;
  List<Ingredient> getIngredients(Cocktail cocktail) => cocktail.ingredients;
}
