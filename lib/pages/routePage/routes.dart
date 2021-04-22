import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
// 页面
import './page1.dart';
import './page2.dart';

class RoutePageRouteMap {
  final String page1 = 'page1';
  final String page2 = 'page2';

  static void Function(FluroRouter) define = handleDefine;
}

void handleDefine(FluroRouter router) {
  RoutePageRouteMap routeMap = RoutePageRouteMap();

  router.define(
    routeMap.page1,
    handler: Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return Page1();
      },
    ),
  );

  router.define(
    routeMap.page2,
    handler: Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return Page2();
      },
    ),
  );
}
