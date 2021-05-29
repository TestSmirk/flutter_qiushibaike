import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class Api {
  static const _own = "https://m2.qiushibaike.com/article/newlist?new=1";
  static const _video = "https://m2.qiushibaike.com/article/list/video?page=1&count=12";
  static const _text = "https://m2.qiushibaike.com/article/list/text?page=1&count=12";
  static const _image = "https://m2.qiushibaike.com/article/list/imgrank?page=1&count=12";
  static final _dio = Dio()
  ..interceptors.add(LogInterceptor(responseBody: true));


  static Future getOwn() async {
    try {
      var request = await _dio.get(_own);

      return jsonDecode(request.toString());
    } catch (e) {
      return e;
    }
  }
  static Future getVideo() async {
    try {
      var request = await _dio.get(_video);

      return jsonDecode(request.toString());
    } catch (e) {
      return e;
    }
  }
 static Future getText() async {
    try {
      var request = await _dio.get(_text);

      return jsonDecode(request.toString());
    } catch (e) {
      return e;
    }
  }
static Future getImage() async {
    try {
      var request = await _dio.get(_image);

      return jsonDecode(request.toString());
    } catch (e) {
      return e;
    }
  }
}
