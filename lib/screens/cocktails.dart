import 'package:flutter/material.dart';

import 'package:cocktails_demo/styles.dart';
import 'package:cocktails_demo/data/models/cocktail.dart';
import 'package:cocktails_demo/ui/vertical_cards.dart';

class CocktailsScreen extends StatelessWidget {
  final List<Cocktail> cocktails;
  final List<Cocktail> baseCocktails;

  CocktailsScreen({this.cocktails, this.baseCocktails});

  @override
  Widget build(BuildContext context) {

    AppBar appBar = AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        color: Colors.black,
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Cocktails',
        style: Styles.cardTitle,
      ),
      centerTitle: true,
      brightness: Brightness.light,
    );
    
    return Scaffold(
      appBar: appBar,
      body: VerticalCards(
        cocktails: cocktails,
        baseCocktails: baseCocktails,
        appBarHeight: appBar.preferredSize.height
      ),
    );
  }

  
}

