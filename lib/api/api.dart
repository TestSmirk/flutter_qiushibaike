import 'dart:convert';

import 'package:dio/dio.dart';

class Api {
  static const _own = "https://m2.qiushibaike.com/article/newlist?new=1";
  static const _video =
      "https://m2.qiushibaike.com/article/list/video?page=1&count=12";
  static const _text =
      "https://m2.qiushibaike.com/article/list/text?page=1&count=12";
  static const _image =
      "https://m2.qiushibaike.com/article/list/imgrank?page=1&count=12";
  static const _nearby =
      "https://circle.qiushibaike.com/article/nearby/list?page=1";
  static const _follow =
      "https://circle.qiushibaike.com/article/follow/list?page=1&latitude=0.0&longitude=0.0";
  static const _topic =
      "https://circle.qiushibaike.com/topic/latest?page=1&count=20";
  static const _selecive = "https://m2.qiushibaike.com/article/list/day?page=1&count=12";
  static const _live =
      "https://live.yuanbobo.com/v1/live/stream/qb/list?app=1&ver=11.14.1&mod=V1829A&count=10&chn=32&source=1&sys=android_10&sig=458df27e1403fd80f9dfaa0723162d79&user_id=0&build=302&review=1&bundle_id=qsbk.app&lan=0&page=1&source_id=0&sdk=9.4.0&net=0&did=6CB222B2024F38E8345F19F2E6379358&ts=1622437214401";
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

  static Future getNeazrby({latitude = 0.0, longitude = 0.0}) async {
    try {
      var request = await _dio.get(_nearby,
          queryParameters: {"latitude": latitude, "longitude": longitude});

      return jsonDecode(request.toString());
    } catch (e) {
      return e;
    }
  }


  static Future getFollow({latitude = 0.0, longitude = 0.0}) async {
    try {
      var request = await _dio.get(_follow,
          queryParameters: {"latitude": latitude, "longitude": longitude});

      return jsonDecode(request.toString());
    } catch (e) {
      return e;
    }
  }

  static Future getSelective({latitude = 0.0, longitude = 0.0}) async {
    try {
      var request = await _dio.get(_selecive,
          queryParameters: {"latitude": latitude, "longitude": longitude});

      return jsonDecode(request.toString());
    } catch (e) {
      return e;
    }
  }

  static Future getTopic({latitude = 0.0, longitude = 0.0}) async {
    try {
      var request = await _dio.get(_topic,
          queryParameters: {"latitude": latitude, "longitude": longitude});

      return jsonDecode(request.toString());
    } catch (e) {
      return e;
    }
  }
}
