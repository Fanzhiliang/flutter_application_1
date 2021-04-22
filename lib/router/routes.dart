import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
// 页面
import '../pages/tabbar/bottom_tabbar.dart' as IndexTabBar;
import '../pages/listPage/routes.dart';
import '../pages/routePage/routes.dart';

class RouteMap with ListPageRouteMap, RoutePageRouteMap {
  final String root = 'index_bottom_tabbar';
}

class Routes {
  static RouteMap configureRoutes(FluroRouter router) {
    RouteMap routeMap = RouteMap();

    ListPageRouteMap.define(router);

    RoutePageRouteMap.define(router);

    router.define(
      routeMap.root,
      handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
          int current = 0;
          if (params.containsKey('current') &&
              params['current']?.first != null) {
            current = int.parse(params['current']!.first);
          }

          return IndexTabBar.BottomTabBar(
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
    // 清空路由栈
    if (clearStack) {
      Global.routeList = [];
    }
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

  void back(BuildContext context, [int times = 1]) {
    NavigatorState navigatorState = Navigator.of(context);
    if (navigatorState.canPop()) {
      unfocus();
      for (int i = 0; i < times; i++) {
        navigatorState.pop(context);
      }
    }
  }

  void backWithParams(BuildContext context, Object result) {
    if (Navigator.of(context).canPop()) {
      unfocus();
      Navigator.pop(context, result);
    }
  }
}
