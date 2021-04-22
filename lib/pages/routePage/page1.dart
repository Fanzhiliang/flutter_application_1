import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter_application_1/global.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('页面1'),
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
                    Global.routeMap.page2,
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
