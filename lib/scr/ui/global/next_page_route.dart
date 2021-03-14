import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextPageRoute extends CupertinoPageRoute {
  NextPageRoute({@required this.nextPage})
      : super(builder: (BuildContext context) => nextPage);

  Widget nextPage;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: nextPage);
  }
}