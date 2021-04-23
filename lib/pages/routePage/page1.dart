import 'package:fluro/fluro.dart';
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
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(171, 203, 120, 1),
            Color.fromRGBO(22, 181, 184, 1)
          ],
        ),
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
