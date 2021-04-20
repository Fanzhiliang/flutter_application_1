import 'package:flutter/material.dart';

enum LoadMoreStatus { Loading, NoMore, None, NoData }

class LoadMore extends StatefulWidget {
  final LoadMoreStatus status;
  final double paddingTop;
  final double paddingBottom;

  LoadMore({
    Key key,
    this.status = LoadMoreStatus.Loading,
    this.paddingTop = 15,
    this.paddingBottom = 15,
  }) : super(key: key);

  @override
  _LoadMoreState createState() => _LoadMoreState();
}

class _LoadMoreState extends State<LoadMore> {
  Widget _textBuilder() {
    String text = '';

    switch (widget.status) {
      case LoadMoreStatus.NoMore:
        text = '没有更多数据';
        break;
      case LoadMoreStatus.NoData:
        text = '暂无数据';
        break;
      case LoadMoreStatus.Loading:
      default:
        text = '加载中...';
    }

    return Text(
      text,
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.status == LoadMoreStatus.None
        ? SizedBox()
        : Column(
            children: [
              SizedBox(height: widget.paddingTop),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // loading 图标
                  widget.status == LoadMoreStatus.Loading
                      ? Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(right: 10),
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.grey),
                            strokeWidth: 2,
                          ),
                        )
                      : SizedBox(),
                  // 文字
                  _textBuilder(),
                ],
              ),
              SizedBox(height: widget.paddingBottom),
            ],
          );
  }
}
