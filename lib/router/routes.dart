import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
// 页面
import '../pages/tabbar/bottom_tabbar.dart';
import '../pages/listPage/routes.dart';

class RouteMap with ListPageRouteMap {
  final String bottomTabBar = 'bottom_tabbar';
}

class Routes {
  static RouteMap configureRoutes(FluroRouter router) {
    RouteMap routeMap = RouteMap();

    ListPageRouteMap.define(router);

    router.define(
      routeMap.bottomTabBar,
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          int current = 0;
          if (params.containsKey('current') &&
              params['current']?.first != null) {
            current = int.parse(params['current']!.first);
          }

          return BottomTabBar(
            current: current,
          );
        },
      ),
    );

    return routeMap;
  }
}

// 路由跳转工具
class RouterUtils {
  late FluroRouter router;

  Duration routerDuration = Duration(milliseconds: 250);

  RouterUtils() {
    router = FluroRouter();
  }

  FluroRouter getRouter() {
    return router;
  }

  void unfocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<dynamic> navigateTo(
    BuildContext context,
    String path, {
    bool replace = false,
    bool clearStack = false,
    TransitionType transition = TransitionType.inFromRight,
    Duration? transitionDuration,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionBuilder,
  }) async {
    unfocus();
    return await router.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transition: transition,
      transitionDuration: transitionDuration ?? routerDuration,
      transitionBuilder: transitionBuilder,
    );
  }

  void back(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      unfocus();
      Navigator.pop(context);
    }
  }

  void backWithParams(BuildContext context, Object result) {
    if (Navigator.of(context).canPop()) {
      unfocus();
      Navigator.pop(context, result);
    }
  }
}
