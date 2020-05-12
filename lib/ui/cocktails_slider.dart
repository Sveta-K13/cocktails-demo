import 'package:flutter/material.dart';

import 'package:cocktails_demo/screens/one_cocktail.dart';
import 'package:cocktails_demo/utils/white_page_route.dart';
import 'package:cocktails_demo/utils/rotation_3d.dart';
import 'package:cocktails_demo/data/models/cocktail.dart';
import './cocktail_card.dart';

class CocktailsSlider extends StatefulWidget {
  final List<Cocktail> cocktails;

  const CocktailsSlider({
    Key key,
    this.cocktails,
  }) : super(key: key);

  @override
  CocktailsSliderState createState() => CocktailsSliderState();
}

class CocktailsSliderState extends State<CocktailsSlider> with SingleTickerProviderStateMixin {
  final _maxRotation = 20;
  final wPart = 0.6;
  final ratio = 3/4;
  final scrollFactor = 0.01;
  final tweenTime = 1000;


  double _normalizedOffset = 0.0;
  double _prevScrollX = 0.0;
  bool _isScrolling = false;

  Size size;
  double _cardWidth;
  double _cardHeight;
  int _itemCount;

  PageController _pageController;
  AnimationController _tweenController;
  Tween<double> _tween;
  Animation<double> _tweenAnim;

  @override
  Widget build(BuildContext context) {
    _itemCount = widget.cocktails.length;
    //  TODO
    size = MediaQuery.of(context).size;
    _cardWidth = size.width * wPart;
    _cardHeight = _cardWidth / ratio;
    
    _pageController = PageController(
      initialPage: 1,
      viewportFraction: _cardWidth / size.width,
    );

    Widget listContent = Container(
      height: _cardHeight,
      margin: EdgeInsets.only(bottom: 24.0),
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: _itemCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: (c, i) => _buildItemRenderer(i),
      ),
    );

    return  Listener(
      onPointerUp: _handlePointerUp,
      child: NotificationListener(
        onNotification: _handleScrollNotifications,
        child: listContent,
      ),
    );
  }

  onCardTap(Cocktail cocktail) {
    var page = OneCocktailScreen(cocktail: cocktail);
    Navigator.push(context, WhitePageRoute(enterPage: page));
  }

  Widget _buildItemRenderer(int i) {
    Cocktail cocktail = widget.cocktails[i];
    double currentPage = 1;
    try {
      currentPage = _pageController?.page;
    } catch (e) {
      // do nothing
    }
    double distance =  (i - currentPage).abs() / (_itemCount / 2);
    double scale =  (1 - distance).clamp(0.0, 1.0);
    return Rotation3d(
      rotationY: _normalizedOffset * _maxRotation,
      scale: scale,
      child: GestureDetector(
        onTap: () => onCardTap(cocktail),
        child: CocktailCard(
          _normalizedOffset,
          cocktail: cocktail,
          cardWidth: _cardWidth * scale,
          size: size,
        ),
      )
    );
  }

  bool _handleScrollNotifications(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_isScrolling) {
        double dx = notification.metrics.pixels - _prevScrollX;
        double newOffset = _normalizedOffset + (dx * scrollFactor);
        _setOffset(newOffset.clamp(-1.0, 1.0));
      }
      _prevScrollX = notification.metrics.pixels;
    }
    else if (notification is ScrollStartNotification) {
      _isScrolling = true;
      _prevScrollX = notification.metrics.pixels;
      if (_tween != null) {
        _tweenController.stop();
      }
    }
    return true;
  }

  void _handlePointerUp(PointerUpEvent event) {
    if (_isScrolling) {
      _isScrolling = false;
      _startOffsetTweenToZero();
    }
  }

  void _setOffset(double value) {
    setState(() {
      _normalizedOffset = value;
    });
  }

  void _startOffsetTweenToZero() {
    if (_tweenController == null) {
      _tweenController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: tweenTime),
      );
      _tween = Tween<double>(begin: -1, end: 0);
      _tweenAnim = _tween.animate(
        CurvedAnimation(
          parent: _tweenController,
          curve: Curves.elasticOut,
        ),
      )
      ..addListener(() {
        _setOffset(_tweenAnim.value);
      });
    }
    _tween.begin = _normalizedOffset;
    _tweenController.reset();
    _tween.end = 0;
    _tweenController.forward();
  }

}
