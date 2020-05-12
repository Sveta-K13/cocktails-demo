import 'package:flutter/material.dart';

import 'package:cocktails_demo/ui/transition_container.dart';
import 'package:cocktails_demo/data/models/cocktail.dart';
import 'package:cocktails_demo/styles.dart';

class CocktailCard extends StatelessWidget {
  final double offset;
  final double cardWidth;
  final Cocktail cocktail;
  final Size size;

  final double margin = 12;
  final double topMargin = 30;
  final double topImageOffset = -20;

  const CocktailCard(
    this.offset,
    {
      Key key,
      this.cardWidth = 250,
      @required this.cocktail,
      this.size,
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      padding: EdgeInsets.only(top: 20),
      child: Hero(
        tag: cocktail.name,
        flightShuttleBuilder: _buildFlight,
        child: TransitionContainer(
          margin: EdgeInsets.fromLTRB(margin, topMargin, margin, margin),
          borderRadius: 8.0,
          childOpacity: 0.0,
          opacityInterval: Interval(0.0, 1.0, curve: Curves.easeIn),
          child: _buildContent(),
        ),      
      ),
    );
  }

  Widget _buildFlight(
    BuildContext flightContext,
    Animation<double> heroAnimation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return AnimatedBuilder(
      animation: heroAnimation,
      builder: (context, child) {
        var widthTween = Tween<double>(begin: size.width, end: double.infinity).evaluate(heroAnimation);
        var marginTween = Tween<double>(begin: margin, end: 0).evaluate(heroAnimation);
        var topMarginTween = Tween<double>(begin: topMargin, end: 0).evaluate(heroAnimation);
        return TransitionContainer(
          animationValue: heroAnimation.value,
          borderRadius: Tween<double>(begin: 8, end: 0).evaluate(heroAnimation),
          width: widthTween,
          margin: EdgeInsets.fromLTRB(
            marginTween,
            topMarginTween,
            marginTween,
            marginTween
          ),
          childOpacity: 0.0,
          opacityInterval: Interval(0.0, 0.1, curve: Curves.easeIn),
          child: _buildContent(),
        );
      },
    );
  }

  Widget _buildContent() {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
          top: topImageOffset,
          left: 0,
          right: 0,
          child: Column(
            children: <Widget>[
              _buildCocktailImage(),
              _buildCocktailData(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCocktailImage() {
    const int hPadding = 40;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Image.asset(
        'images/Cocktails/${cocktail.image}',
        width: cardWidth - (2 * hPadding),
      ),
    );
  }

   Widget _buildCocktailData() {
    return Column(
      children: <Widget>[
        SizedBox(height: 25,),
        Material(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(cocktail.name, style: Styles.cardTitle, textAlign: TextAlign.center),
          ),
        ),
        SizedBox()
      ],
    );
  }
}
