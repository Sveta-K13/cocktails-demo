import 'package:flutter/material.dart';

import 'package:cocktails_demo/screens/one_cocktail.dart';
import 'package:cocktails_demo/data/models/cocktail.dart';
import 'package:cocktails_demo/styles.dart';
import 'package:cocktails_demo/utils/helper_data.dart';
import 'package:cocktails_demo/utils/white_page_route.dart';

class ParallaxCard extends StatefulWidget {
  final ShiftPositions shiftPositions;
  final Cocktail cocktail;
  final double cardHeight;
  final double screenWidth;
  final double imageWidth;
  final double itemSpacing;

  ParallaxCard(
    this.shiftPositions,
    {
      Key key,
      @required this.cocktail,
      this.imageWidth,
      this.screenWidth,
      this.cardHeight,
      this.itemSpacing,
    }
  ) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ParallaxCardState();
}

class _ParallaxCardState extends State<ParallaxCard> {
  double verticalPadding = 20;
  double left, right;
  String _imagePath;

  onCardTap() {
    var page = OneCocktailScreen(
      cocktail: widget.cocktail,
      detailsDelay: 300,
    );
    Navigator.push(context, WhitePageRoute(enterPage: page, startPosition: 0.1, duration: 500));
  }

  @override
  Widget build(BuildContext context) {
    _imagePath = 'images/Cocktails/${widget.cocktail.image}';
  
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        margin: EdgeInsets.only(
          bottom: widget.itemSpacing/2,
          left: verticalPadding,
          right: verticalPadding,
          top: widget.itemSpacing/2
        ),
        height: widget.cardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.grey[300], blurRadius: 8, spreadRadius: 2.0),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: widget.imageWidth,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0)
                ),
                child:  Stack(
                  children: <Widget>[
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 200),
                      left: widget.shiftPositions.left,
                      top: widget.shiftPositions.top,
                      right: widget.shiftPositions.right,
                      bottom: widget.shiftPositions.bottom,
                      child: Image.asset(
                        _imagePath,
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.center,
                      ),
                    )
                  ],
                )
              ),
            ),
            Expanded(
              child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0.0),
                  child: Text(
                    widget.cocktail.name,
                    style: Styles.cardTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                    child: Text(
                      widget.cocktail.instruction,
                      style: Styles.cardSubtitle,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  )
                ),
              ],
            ),
            )
          ],
        )
      ),
    );
  }
}