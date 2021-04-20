import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/hide_scroll_shadow/hide_scroll_shadow.dart';
import 'package:flutter_application_1/components/hide_wave/hide_wave.dart';
import 'package:flutter_application_1/global.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './index/index.dart';
import './user/user.dart';

class BottomTabBar extends StatefulWidget {
  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  DateTime _lastPopTime;
  final int _popMaxTime = 2;

  List<Widget> _tabbarList = [
    Index(),
    User(),
  ];

  List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      title: Text('首页'),
      icon: Icon(
        Icons.home,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        Icons.home,
        color: Global.Primary_Color,
      ),
    ),
    BottomNavigationBarItem(
      title: Text('我的'),
      icon: Icon(
        Icons.account_circle_outlined,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        Icons.account_circle_rounded,
        color: Global.Primary_Color,
      ),
    ),
  ];

  int _currentIndex = 0;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentIndex,
      // keepPage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HideScrollShadow(
        child: WillPopScope(
          onWillPop: () async {
            // 2秒内连续点击两次就退出程序
            if (_lastPopTime == null ||
                DateTime.now().difference(_lastPopTime) >
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
                _tabbarList[index],
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
              _currentIndex = index;
              _pageController.jumpToPage(_currentIndex);
            });
          },
          items: _items,
        ),
      ),
    );
  }
}
