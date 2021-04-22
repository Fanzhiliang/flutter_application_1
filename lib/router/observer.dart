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
      Global.routeList.add(routeName);
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
    print('didReplace：');
    print(newRoute);
    print(oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    if (!isNullPage(route)) {
      Global.routeList.removeWhere((element) => element == route.settings.name);
    }
  }
}
