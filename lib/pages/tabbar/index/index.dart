import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Global.routerUtils.navigateTo(
                    context,
                    Global.routeMap.reorderAbleListPage,
                  );
                },
                child: Text('可拖拽列表'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('跳转'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
