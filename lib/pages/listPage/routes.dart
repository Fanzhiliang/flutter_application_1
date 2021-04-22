import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
// 页面
import './reorder_able_list_page.dart';
import './like_list_page.dart';

class ListPageRouteMap {
  final String reorderAbleListPage = 'reorder_able_list_page';
  final String likeListPage = 'like_list_page';

  static void Function(FluroRouter) define = handleDefine;
}

void handleDefine(FluroRouter router) {
  ListPageRouteMap routeMap = ListPageRouteMap();

  router.define(
    routeMap.reorderAbleListPage,
    handler: Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        return ReorderAbleListPage();
      },
    ),
  );

  router.define(
    routeMap.likeListPage,
    handler: Handler(
      handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
        String list = '';
        if (params.containsKey('list') && params['list']?.first != null) {
          list = params['list']!.first;
        }

        return LikeListPage(
          list: list,
        );
      },
    ),
  );
}
