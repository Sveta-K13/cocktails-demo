import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

import 'package:cocktails_demo/data/models/cocktail.dart';
import 'package:cocktails_demo/ui/parallax_card.dart';
import 'package:cocktails_demo/utils/helper_data.dart';

class VerticalCards extends StatefulWidget {
  final List<Cocktail> cocktails;
  final List<Cocktail> baseCocktails;
  final double cardWidth;
  final double cardHeight;
  final double cardImageScale;
  final double parallaxSpeed;
  final double itemSpacing;
  final double appBarHeight;

  VerticalCards({
    @required this.cocktails,
    this.baseCocktails,
    this.appBarHeight,
    this.cardWidth = 300,
    this.cardHeight = 150,
    this.cardImageScale = 1.2,
    this.parallaxSpeed = 1.2,
    this.itemSpacing = 24.0,
  }) : assert(cocktails != null);

  @override
  State<StatefulWidget> createState() => _VerticalCardsState();
}

class _VerticalCardsState extends State<VerticalCards> with SingleTickerProviderStateMixin {
  List<Cocktail> cocktails;
  List<Cocktail> baseCocktails;
  int _itemCount;

  double _cardWidth;
  double _cardHeight;
  double _imageWidth;
  double _topPadding;
  double _bottomPadding;

  double _screenWidth;
  double _screenHeight;
  double _listHeight;

  double _accelerometerX = 0.0;
  
  double _scrollOffset = 0.0;
  int oldCocktailsLength;

  @override
  void initState() {
    cocktails = widget.cocktails;
    baseCocktails = widget.baseCocktails;
    oldCocktailsLength = cocktails.length;

    WidgetsBinding.instance.addPostFrameCallback((_) { 
      accelerometerEvents.listen((AccelerometerEvent event) {
        setState(() {
          _accelerometerX = event.x;
        });
      });
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double verticalListViewPadding = 16.0;
    Size size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;
    _itemCount = cocktails.length;
    _cardWidth = widget.cardWidth;
    _cardHeight = widget.cardHeight;
    _imageWidth = _cardWidth * 0.33;

    _topPadding = MediaQuery.of(context).padding.top + verticalListViewPadding;
    _bottomPadding = MediaQuery.of(context).padding.bottom + verticalListViewPadding;

    _listHeight = (_cardHeight * _itemCount) + (widget.itemSpacing * (_itemCount - 1));

    Widget listContent() {
      return  Container(
        child: ListView.builder(
          padding:  EdgeInsets.only(top: _topPadding, bottom: _bottomPadding),
          physics: BouncingScrollPhysics(),
          itemCount: _itemCount,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => _buildItemRenderer(index),
        ),
      );
    }
    
    return NotificationListener(
      onNotification: _handleScrollNotifications,
      child: Center(
        child: listContent(),
      ),
    );
  }

  Widget _buildItemRenderer(int itemIndex) {
    double itemSpacing = widget.itemSpacing;
    double itemCenterOffset = _topPadding + _listHeight  / _itemCount * (itemIndex +  1);
    return ParallaxCard(
      countPositioned(
        _scrollOffset,
        itemCenterOffset: itemCenterOffset
      ), 
      key: Key(itemIndex.toString()),
      cardHeight: _cardHeight,
      screenWidth: _screenWidth,
      imageWidth: _imageWidth,
      itemSpacing: itemSpacing,
      cocktail: cocktails[itemIndex]
    );
  }

  ShiftPositions countPositioned(double offset, {double itemCenterOffset}) {
    double freeSrace = widget.cardImageScale  - 1;
    double baseHorizontalShift = _imageWidth * freeSrace;
    double baseVerticalShift = _cardHeight * freeSrace;
    double normalizedOffset = offset  + _screenHeight/2;
    double maxShift = _cardHeight + _screenHeight/2;

    // -1.0 ... 1.0
    double dy = (itemCenterOffset - normalizedOffset).clamp(-maxShift, maxShift) / maxShift;
    double finalDy = dy * widget.parallaxSpeed;

    double imageShift = finalDy * baseVerticalShift;
    double top =  -baseVerticalShift - imageShift;
    double bottom =  -baseVerticalShift + imageShift;

    double horizontalImageShift = _accelerometerX * 2;
    double left = -baseHorizontalShift + horizontalImageShift;
    double right = -baseHorizontalShift - horizontalImageShift;

    return ShiftPositions(
      left: left,
      top: top,
      right: right,
      bottom: bottom
    );
  }

  bool _handleScrollNotifications(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      _setOffset(notification.metrics.pixels);
    }
    
    double normalizedOffset = _scrollOffset + _screenHeight/2 - widget.appBarHeight;
    if (normalizedOffset > _listHeight - _screenHeight/2) {
      if (cocktails.length == oldCocktailsLength) {
        setState(() {
          cocktails += baseCocktails;
          oldCocktailsLength = cocktails.length;
        });
      }
    }

    return true;
  }

  void _setOffset(double value) {
    setState(() {
      _scrollOffset = value;
    });
  }
}


