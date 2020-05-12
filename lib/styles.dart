import 'package:flutter/material.dart';

class Styles {
  static const double hzScreenPadding = 18;

  static final TextStyle baseTitle = TextStyle(fontSize: 11, fontFamily: 'DMSerifDisplay');
  static final TextStyle baseBody = TextStyle(fontSize: 11, fontFamily: 'OpenSans');

  static final TextStyle appHeader = baseTitle.copyWith(
    color: Color(0xFF0e0e0e),
    fontSize: 36,
    // height: 1,
  );

  static final TextStyle cardTitle = baseTitle.copyWith(
    // height: 1,
    color: Color(0xFF1a1a1a),
    fontSize: 25);
  static final TextStyle cardSubtitle = baseBody.copyWith(
    color: Color(0xFF666666),
    height: 1.5,
    fontSize: 16,
  );
  static final TextStyle cardAction =
      baseBody.copyWith(color: Color(0xFFa6998b), fontSize: 10, height: 1, fontWeight: FontWeight.w600, letterSpacing: 0.1);

  static final TextStyle ingredientsTitleSection = baseBody.copyWith(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold, height: 2);
  static final TextStyle ingredientsTitle = baseBody.copyWith(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600);

  static final TextStyle detailsTitleSection = baseBody.copyWith(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);
  static final TextStyle detailsCardTitle = baseBody.copyWith(color: Colors.black, fontSize: 10, letterSpacing: 0.5);
  static final TextStyle detailsInstruction = baseBody.copyWith(
    color: Color(0xFF666666),
    height: 1.8,
    fontSize: 16
  );
}
