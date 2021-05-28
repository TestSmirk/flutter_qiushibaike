import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class Api {
  static const _own = "https://m2.qiushibaike.com/article/newlist?new=1";
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
}
