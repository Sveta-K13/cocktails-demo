import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cocktails_demo/ui/transition_container.dart';
import 'package:cocktails_demo/data/models/cocktail.dart';
import 'package:cocktails_demo/ui/cocktail_details.dart';
import 'package:cocktails_demo/styles.dart';

class OneCocktailScreen extends StatelessWidget {
  final Cocktail cocktail;
  final int detailsDelay;

  OneCocktailScreen({
    this.cocktail,
    this.detailsDelay = 900,
  }) : assert(cocktail != null);

  @override
  Widget build(BuildContext context) {
    // TODO bring to vars
    Size size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Stack(
              children: <Widget>[
                _buildImage(
                  context,
                  size: size
                ),
                CocktailDetails(
                  cocktail: cocktail,
                  delay: detailsDelay,
                ),
              ],
            ),
            _buildBackButton(context),
            _buildStatusbarBackground(context)
          ],
        ),
      )
    );
  }

  Widget _buildImage(context, {Size size}) {

    Widget _buildFlight(
      BuildContext flightContext,
      Animation<double> heroAnimation,
      HeroFlightDirection flightDirection,
      BuildContext fromHeroContext,
      BuildContext toHeroContext
    ) {
        return AnimatedBuilder(
          animation: heroAnimation,
          builder: (context, child) {
            var topMargin = Tween<double>(begin: 30, end: 0).evaluate(heroAnimation);
            var otherMargins = Tween<double>(begin: 12, end: 0).evaluate(heroAnimation);
            return TransitionContainer(
              animationValue: heroAnimation.value,
              borderRadius: Tween<double>(begin: 8, end: 0).evaluate(heroAnimation),
              width: Tween<double>(begin: size.width, end: double.infinity).evaluate(heroAnimation),
              // height: Tween<double>(begin: size.height * 0.4, end: double.infinity).evaluate(heroAnimation),
              margin: EdgeInsets.fromLTRB(otherMargins, topMargin, otherMargins, otherMargins),
              childOpacity: 1.0,
              opacityInterval: Interval(0.95, 1.0, curve: Curves.easeIn),
              child: Image.asset(
                'images/Cocktails/${cocktail.image}',
                fit: BoxFit.fitWidth,
              ),
            );
          },
        );
      }

    return Hero(
      tag: cocktail.name,
      flightShuttleBuilder: _buildFlight,
      child: Image.asset(
        'images/Cocktails/${cocktail.image}',
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SafeArea(
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        padding: EdgeInsets.only(left: Styles.hzScreenPadding),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 18
        ),
        onPressed: () {
          Navigator.pop(context);
        }
      ),
    );
  }
  
  Widget _buildStatusbarBackground(context) {
    return Positioned(
      top: 0,
      child: Container(
        height: MediaQuery.of(context).padding.top,
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0.45),
      ),
    );
  }
}

