// 图片工具
import 'package:flutter/cupertino.dart';

class ImageUtils {
  static const String baseUrl = '';
  static const String imagePrefix = '$baseUrl';

  static String wrapUrl(String url) {
    if (url.startsWith('http') || url.startsWith('https')) {
      return url;
    } else {}
    return imagePrefix + url;
  }

  static String wrapAssets(String url) {
    return "assets/images/" + url;
  }
}

// 字体图标
class IconFonts {
  IconFonts._();

  static const String fontFamily = 'iconfont';
  // 关闭
  static const IconData Close =
      IconData(0xe617, fontFamily: fontFamily, matchTextDirection: true);
}
