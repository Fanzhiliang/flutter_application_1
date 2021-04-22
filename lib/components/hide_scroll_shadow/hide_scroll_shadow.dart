import 'package:flutter/material.dart';

// 消除滚动的月牙阴影
class HideScrollShadow extends StatelessWidget {
  final Widget child;

  HideScrollShadow({required this.child});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyHideShadowBehavior(),
      child: child,
    );
  }
}

class MyHideShadowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
