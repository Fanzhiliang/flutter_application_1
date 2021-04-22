import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter_application_1/global.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('页面2'),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text('下一页'),
                onPressed: () {
                  Global.routerUtils.navigateTo(
                    context,
                    Global.routeMap.page1,
                  );
                },
              ),
              TextButton(
                child: Text('返回上上个页面'),
                onPressed: () {
                  // Navigator.of(context)..pop()..pop();
                  Global.routerUtils.back(context, 2);
                },
              ),
              ElevatedButton(
                child: Text('返回tabbar'),
                onPressed: () {
                  // 如果上一页有 indexTabBar
                  int findIndex = Global.routeList.reversed
                      .toList()
                      .indexOf(Global.routeMap.root);
                  if (findIndex >= 1) {
                    Global.routerUtils.back(context, findIndex);
                  }
                },
              ),
              TextButton(
                child: Text('清空路由栈，返回我的'),
                onPressed: () {
                  Global.routerUtils.navigateTo(
                    context,
                    '${Global.routeMap.root}?current=1',
                    clearStack: true,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
