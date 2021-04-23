import 'package:flutter/material.dart';
import 'package:flutter_application_1/global.dart';

class CustomListPage extends StatefulWidget {
  @override
  _CustomListPageState createState() => _CustomListPageState();
}

class _CustomListPageState extends State<CustomListPage> {
  // 标题
  Widget _titleBuilder(String title) {
    final BorderSide thinBorder = BorderSide(
      width: 2,
      color: Theme.of(context).primaryColor,
    );

    final BorderSide boldBorder = BorderSide(
      width: 6,
      color: Theme.of(context).primaryColor,
    );

    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.only(left: 6),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: thinBorder,
          right: thinBorder,
          bottom: thinBorder,
          left: boldBorder,
        ),
      ),
      child: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // 导航栏
          SliverAppBar(
            title: Text('普通列表'),
            centerTitle: true,
            pinned: true,
          ),
          SliverToBoxAdapter(child: SizedBox(height: 8)),
          // 网格列表
          SliverToBoxAdapter(
            child: _titleBuilder('网格列表'),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // 2 列
                crossAxisCount: 2,
                // 横间隔
                mainAxisSpacing: 5,
                // 纵间隔
                crossAxisSpacing: 8,
                // 网格宽高比
                childAspectRatio: 5.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text('item $index'),
                  );
                },
                childCount: 18,
              ),
            ),
          ),
          // 高度一样的列表
          SliverToBoxAdapter(
            child: _titleBuilder('高度一样的列表'),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverFixedExtentList(
              itemExtent: 50,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text('item $index'),
                  );
                },
                childCount: 18,
              ),
            ),
          ),
          // 高度不一样的列表
          SliverToBoxAdapter(
            child: _titleBuilder('高度不一样的列表'),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    height: double.parse('${50 + 5 * index}'),
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: Text('item $index'),
                  );
                },
                childCount: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
