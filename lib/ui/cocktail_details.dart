import 'package:cocktails_demo/data/models/ingredient.dart';
import 'package:flutter/material.dart';

import 'package:cocktails_demo/data/models/cocktail.dart';
import 'package:cocktails_demo/styles.dart';

class CocktailDetails extends StatefulWidget {
  final Cocktail cocktail;
  final int delay;
  CocktailDetails({Key key, this.cocktail, this.delay = 900}) : super(key: key);

  @override
  _CocktailDetailsState createState() => _CocktailDetailsState();
}

class _CocktailDetailsState extends State<CocktailDetails> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    Future.delayed(
      Duration(milliseconds: widget.delay),
      () => _controller.forward(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
        // TODO bring to vars
    Size size = MediaQuery.of(context).size;
    return  SlideTransition(
      position: _offsetAnimation,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.only(top: size.width - 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            controller: ScrollController(),
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              _buildTitle(widget.cocktail.name),
              _buildInstruction(widget.cocktail.instruction),
              ..._buildIngredientsList(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _ingredientItem(Ingredient ingredient) {
    return ListTile(
      leading: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(24)
        ),
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Image.asset(
                'images/Ingredients/${ingredient.image}',
              ),
            )
          ),
        )
      ),
      title: Text(
        ingredient.name,
        style: Styles.cardSubtitle,
      ),
      trailing: Text(
        ingredient.amount,
        style: Styles.cardAction,
      ),
    );
  }

  List<Widget> _buildIngredientsList() {
    return widget.cocktail.ingredients.map((elem) => _ingredientItem(elem)).toList();
  }

  Widget _buildInstruction(String instruction) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 25),
      child: Text(
        instruction,
        style: Styles.detailsInstruction,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        title,
        style: Styles.appHeader,
        textAlign: TextAlign.center,
      ),
    );
  }
}
