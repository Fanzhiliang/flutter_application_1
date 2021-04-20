import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_application_1/components/hide_wave/hide_wave.dart';
import 'package:flutter_application_1/components/load_more/load_more.dart';
import 'package:flutter_application_1/global.dart';

class ReorderAbleListPage extends StatefulWidget {
  ReorderAbleListPage({Key key}) : super(key: key);

  @override
  _ReorderAbleListPageState createState() => _ReorderAbleListPageState();
}

class _ReorderAbleListPageState extends State<ReorderAbleListPage> {
  List<WordPair> _words = [];

  List<String> _likeList = [];

  _handleRandomWord() async {
    await Future.delayed(Duration(milliseconds: 1500));
    setState(() {
      _words.addAll(generateWordPairs().take(20));
    });
  }

  _handleToggleLike(String val) {
    setState(() {
      if (_likeList.contains(val)) {
        _likeList.remove(val);
      } else {
        _likeList.add(val);
      }
    });
  }

  Widget _rowBuilder({int index}) {
    final String val = _words[index].asPascalCase;
    final bool isContains = _likeList.contains(val);
    return Container(
      key: ValueKey('row_$index'),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromRGBO(136, 136, 136, 0.1),
          ),
        ),
      ),
      child: ListTile(
        title: Text(val),
        trailing: HideWave(
          child: IconButton(
            icon: Icon(
              isContains ? Icons.favorite : Icons.favorite_border,
              color: isContains ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              _handleToggleLike(val);
            },
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        onTap: () {
          print('点击行');
        },
      ),
    );
  }

  ScrollController _scrollController = ScrollController();

  _handleScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      _handleToLower();
    }
  }

  bool _isLoading = false;

  // 滚动到最底部
  _handleToLower() async {
    if (_isLoading) return;
    _isLoading = true;
    await _handleRandomWord();
    _isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    // 初始化数据
    _handleRandomWord();
    // 设置监听
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    super.dispose();
    // 移除监听
    _scrollController.removeListener(_handleScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('可拖拽列表'),
        actions: [
          IconButton(
            onPressed: () {
              Global.routerUtils.navigateTo(
                context,
                Global.routeMap.likeListPage,
              );
            },
            icon: Icon(Icons.local_grocery_store_outlined),
          )
        ],
      ),
      // 抓取移动列表
      body: Scrollbar(
        child: ReorderableListView(
          scrollController: _scrollController,
          physics: BouncingScrollPhysics(),
          onReorder: (int oldIndex, int newIndex) {
            if (newIndex > oldIndex) newIndex -= 1;
            final WordPair w = _words.removeAt(oldIndex);
            _words.insert(newIndex, w);
          },
          children: [
            ...List.generate(
              _words.length,
              (index) => _rowBuilder(index: index),
            ),
            LoadMore(
              key: ValueKey('load-more'),
              status: LoadMoreStatus.Loading,
            ),
          ],
        ),
      ),
    );
  }
}
