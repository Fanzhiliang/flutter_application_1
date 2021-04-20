import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/hide_wave/hide_wave.dart';
import 'package:flutter_application_1/global.dart';

class LikeListPage extends StatefulWidget {
  final String list;
  LikeListPage({
    Key key,
    this.list = '',
  }) : super(key: key);

  @override
  _LikeListPageState createState() => _LikeListPageState();
}

class _LikeListPageState extends State<LikeListPage> {
  List<String> _likeList = [];

  _handleDelete(String val) {
    setState(() {
      _likeList.remove(val);
    });
  }

  Widget _rowBuilder({int index}) {
    final String val = _likeList[index];
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
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.grey,
          ),
          onPressed: () {
            _handleDelete(val);
          },
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        onTap: () {
          print('点击行');
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.list.isNotEmpty) {
      setState(() {
        _likeList = widget.list.split(',');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text('我的喜欢'),
          centerTitle: true,
        ),
        body: ListView(
          children: List.generate(
            _likeList.length,
            (index) => _rowBuilder(
              index: index,
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Global.routerUtils.backWithParams(context, _likeList);
        return false;
      },
    );
  }
}
