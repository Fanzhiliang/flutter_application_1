import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';

class HideWave extends StatelessWidget {
  final Widget child;
  final Brightness brightness;

  HideWave({
    Key key,
    this.child,
    this.brightness = Brightness.light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          brightness: brightness,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: child);
  }
}
