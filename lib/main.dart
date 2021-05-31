import 'package:flutter/material.dart';
import 'package:qiubai/ui/dynamic/dynamic.dart';
import 'package:qiubai/ui/shit/msg.dart';
import 'package:qiubai/ui/shit/shit.dart';

import 'api/api.dart';

void main() {
  runApp(MyApp());
}

final pages = [ShitPage(), DynamicPage(), ShitPage(), MsgPage(), MsgPage()];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 12,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              print('currentIndex $currentIndex');
            });
          },
          items: [
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Container(
                  width: 25,
                  height: 25,
                  child: Image.asset("images/home/1/shit_23.png"),
                ),
                label: "糗事"),
            BottomNavigationBarItem(
                icon: Container(
                  width: 25,
                  height: 25,
                  child: Image.asset("images/home/2/qyq_23.png"),
                ),
                label: "动态"),
            BottomNavigationBarItem(
                icon: Container(
                  width: 25,
                  height: 25,
                  child: Image.asset("images/home/3/live_22.png"),
                ),
                label: "直播"),
            BottomNavigationBarItem(
                icon: Container(
                  width: 25,
                  height: 25,
                  child: Image.asset("images/home/4/msg_23.png"),
                ),
                label: "小纸条"),
            BottomNavigationBarItem(
                icon: Container(
                  width: 25,
                  height: 25,
                  child: Image.asset("images/home/5/mine_23.png"),
                ),
                label: "未登录"),
          ]),
      body: pages[
          currentIndex], // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
