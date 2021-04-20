import 'package:flutter/material.dart';

class LikeListPage extends StatefulWidget {
  LikeListPage({Key key}) : super(key: key);

  @override
  _LikeListPageState createState() => _LikeListPageState();
}

class _LikeListPageState extends State<LikeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的喜欢'),
        centerTitle: true,
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
