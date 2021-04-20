import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_application_1/router/routes.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'components/hide_scroll_shadow/hide_scroll_shadow.dart';
import 'pages/tabbar/bottom_tabbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  // 强制竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    Utils.statusBarEnable(true);

    // 路由
    RouterUtils routerUtils = RouterUtils();
    Global.routeMap = Routes.configureRoutes(routerUtils.getRouter());
    Global.routerUtils = routerUtils;

    runApp(App());
  });
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        // 消除滚动的月牙阴影
        home: HideScrollShadow(
          // 打开的初始页面
          child: BottomTabBar(),
        ),
        localizationsDelegates: [
          // 解决 Cupertino 弹框报错的问题
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: Locale('zh-CN'),
        // locale: Locale('en'),
        supportedLocales: [
          const Locale('zh', 'CN'),
          const Locale('en', 'US'),
        ],
      ),
    );
  }
}
