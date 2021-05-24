import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';

class Exercise extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Exercise> {
  // 注册一个通知
  static const EventChannel eventChannel =
      const EventChannel('com.allen.test.call');

  String naviTitle = 'title';

  // 渲染前的操作，类似viewDidLoad
  @override
  void initState() {
    super.initState();
    getHttp();
    // 监听事件，同时发送参数12345
    eventChannel
        .receiveBroadcastStream(12345)
        .listen(_onEvent, onError: _onError);
  }

  void getHttp() async {
    try {
      Response response;
      var dio = Dio();
      // Optionally the request above could also be done as
      response = await dio.get(
          'http://test.api.kachexiongdi.com/v1/user/register_or_login_by_sms',
          queryParameters: {
            'mobile': 15100000002,
            'sms': '123456',
            'role': 'GOODSOWNER',
            'type': 'NEW'
          });
      print(response.data.toString());
    } catch (e) {
      print(e);
    }
  }

  // 回调事件
  void _onEvent(Object event) {
    setState(() {
      naviTitle = event.toString();
      print(naviTitle);
    });
  }

  // 错误返回
  void _onError(Object error) {}

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Material(
        child: new Scaffold(
          body: new Center(
            child: new Text(naviTitle),
          ),
        ),
      ),
    );
  }
}
