import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/hide_scroll_shadow/hide_scroll_shadow.dart';
import 'package:flutter_application_1/components/hide_wave/hide_wave.dart';
import 'package:flutter_application_1/global.dart';
import 'package:flutter_application_1/utils/source_utils.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:badges/badges.dart';
import 'package:event_bus/event_bus.dart';
import './index/index.dart';
import './user/user.dart';

EventBus $tabBarBus = EventBus();

// tabbar 改变事件
class TabBarChangeEvent {
  final int currentIndex;

  const TabBarChangeEvent({
    this.currentIndex = 0,
  });
}

// tabbar 角标改变事件
class BadgeChangeEvent {
  int index;
  BottomTabBarBadge badge;

  BadgeChangeEvent({
    required this.index,
    required this.badge,
  });
}

// tabbar 角标
class BottomTabBarBadge {
  bool showBadge;
  String badgeContent;

  BottomTabBarBadge({
    this.showBadge = false,
    this.badgeContent = '',
  });
}

// tabbar 项
class BottomTabBarItem {
  String? title;
  Widget page;
  Widget icon;
  Widget activeIcon;
  Function? onTap;
  BottomTabBarBadge? badge;

  BottomTabBarItem({
    this.title,
    this.page = const Scaffold(),
    this.icon = const SizedBox(),
    this.activeIcon = const SizedBox(),
    this.onTap,
    this.badge,
  });
}

// tabbar
class BottomTabBar extends StatefulWidget {
  final int current;

  BottomTabBar({
    Key? key,
    this.current = 0,
  });

  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  DateTime _lastPopTime = DateTime.now();
  final int _popMaxTime = 2;

  // tabbar 列表
  List<BottomTabBarItem> _tabbarList = [
    BottomTabBarItem(
      title: '首页',
      page: Index(),
      icon: Icon(
        Icons.home,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        Icons.home,
        color: Global.Primary_Color,
      ),
    ),
    BottomTabBarItem(
      title: '我的',
      page: User(),
      icon: Icon(
        Icons.account_circle_outlined,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        Icons.account_circle_rounded,
        color: Global.Primary_Color,
      ),
    ),
    // 特殊tabbar
    BottomTabBarItem(
      icon: ExtendedImage.network(
        'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=49081054,840221900&fm=224&gp=0.jpg',
        width: 100 * Utils.rpx,
        height: 40,
        fit: BoxFit.fitWidth,
      ),
      activeIcon: ExtendedImage.asset(
        ImageUtils.wrapAssets('tabbar-test.gif'),
        width: 60,
        height: 40,
        fit: BoxFit.fitHeight,
      ),
    ),
    BottomTabBarItem(
      title: '不跳转',
      icon: Icon(IconFonts.Close),
      onTap: () {
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: '触发事件不跳转页面');
      },
    ),
  ];

  int _currentIndex = 0;

  PageController? _pageController;

  // 生成角标
  Widget _badgeBuilder({
    BottomTabBarBadge? badge,
    required Widget child,
  }) {
    badge = badge ?? BottomTabBarBadge();

    return Badge(
      badgeContent: Text(
        badge.badgeContent,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
      animationType: BadgeAnimationType.fade,
      padding: EdgeInsets.all(5),
      showBadge: badge.showBadge,
      child: child,
    );
  }

  List<StreamSubscription> _subs = [];

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.current;

    _pageController = PageController(
      initialPage: _currentIndex,
    );

    // 监听事件广播
    _subs.add($tabBarBus.on<TabBarChangeEvent>().listen((e) {
      setState(() {
        _currentIndex = e.currentIndex;
        _pageController!.jumpToPage(_currentIndex);
      });
    }));

    _subs.add($tabBarBus.on<BadgeChangeEvent>().listen((e) {
      setState(() {
        _tabbarList[e.index].badge = e.badge;
      });
    }));
  }

  @override
  void dispose() {
    super.dispose();
    // 解绑事件广播
    _subs.forEach((StreamSubscription sub) {
      sub.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HideScrollShadow(
        child: WillPopScope(
          onWillPop: () async {
            // 2秒内连续点击两次就退出程序
            if (DateTime.now().difference(_lastPopTime) >
                Duration(seconds: _popMaxTime)) {
              // 记录新的时间
              _lastPopTime = DateTime.now();
              // 提示
              Fluttertoast.showToast(
                  msg: '再次按一次退出', toastLength: Toast.LENGTH_SHORT);
              return false;
            }
            return true;
          },
          child: PageView.builder(
            itemBuilder: (BuildContext context, int index) =>
                _tabbarList[index].page,
            itemCount: _tabbarList.length,
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
          ),
        ),
      ),
      bottomNavigationBar: HideWave(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Global.Primary_Color,
          iconSize: 25,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              BottomTabBarItem item = _tabbarList[index];
              if (item.onTap == null) {
                _currentIndex = index;
                _pageController?.jumpToPage(_currentIndex);
              } else {
                (item.onTap as Function)();
              }
            });
          },
          items: List.generate(_tabbarList.length, (index) {
            BottomTabBarItem item = _tabbarList[index];
            return BottomNavigationBarItem(
              title:
                  item.title != null ? Text(item.title as String) : SizedBox(),
              icon: _badgeBuilder(
                child: item.icon,
                badge: item.badge,
              ),
              activeIcon: _badgeBuilder(
                child: item.activeIcon,
                badge: item.badge,
              ),
            );
          }),
        ),
      ),
    );
  }
}
