import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_application_1/utils/utils.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentTime),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text('可拖拽列表'),
                onPressed: () {
                  Global.routerUtils.navigateTo(
                    context,
                    Global.routeMap.reorderAbleListPage,
                  );
                },
              ),
              ElevatedButton(
                child: Text('路由测试'),
                onPressed: () {
                  Global.routerUtils
                      .navigateTo(
                        context,
                        Global.routeMap.page1,
                      )
                      .then((value) => print(value));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
