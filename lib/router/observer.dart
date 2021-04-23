import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';

bool isNullPage(Route route) {
  return route.settings.name == null ||
      route.settings.name.toString() == 'null';
}

class GlobalObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (!isNullPage(route)) {
      String name = route.settings.name as String;
      List<String> arr = name.split('?');
      String routeName =
          arr.length > 0 && arr.first.isNotEmpty ? arr.first : '';
      Global.routeList.add(routeName == '/' ? Global.routeMap.root : routeName);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (!isNullPage(route)) {
      Global.routeList.removeLast();
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    int lastIndex =
        Global.routeList.lastIndexOf(oldRoute!.settings.name as String);
    if (lastIndex >= 0) {
      Global.routeList[lastIndex] = newRoute!.settings.name.toString();
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    if (!isNullPage(route)) {
      Global.routeList.removeWhere((element) => element == route.settings.name);
    }
  }
}
