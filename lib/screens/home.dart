import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cocktails_demo/ui/cocktails_slider.dart';
import 'package:cocktails_demo/data/models/cocktail.dart';
import 'package:cocktails_demo/data/demo_data.dart';
import 'package:cocktails_demo/utils/transform.dart';
import 'package:cocktails_demo/styles.dart';
import './cocktails.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Cocktail> _cocktails;
  List<Cocktail> _baseCocktails;

  @override
  void initState() {
    super.initState();
    var data = DemoData();
    _cocktails = data.getCocktails();
    _baseCocktails = _cocktails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Styles.hzScreenPadding,
                  vertical: Styles.hzScreenPadding * 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'What cocktail',
                      overflow: TextOverflow.visible,
                      style: Styles.appHeader,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'will you be drinking',
                      overflow: TextOverflow.visible,
                      style: Styles.appHeader,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'today?',
                      overflow: TextOverflow.visible,
                      style: Styles.appHeader,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                    ),
                  ],
                )
              ),
              Container(
                child: CocktailsSlider(
                  cocktails: _cocktails,
                ),
              ),
              Expanded(child: SizedBox(),),
              _buildButton(),
              Expanded(child: SizedBox(),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    _buttonTap() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CocktailsScreen(
            cocktails: _cocktails,
            baseCocktails: _baseCocktails,
          )
        )
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(56.0, 0, 56.0, 0),
      child: CupertinoButton(
        color: Colors.black87,
        pressedOpacity: 0.8,
        onPressed: _buttonTap,
        child: Text(
          getButtonTitle('Check all'),
          style: Styles.cardAction.copyWith(color: Colors.white),
        ),
      )
    );
  }

}
