import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/home.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}