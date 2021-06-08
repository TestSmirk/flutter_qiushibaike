import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qiubai/ui/com/shit_sign.dart';

final dynamicTabs = [
  Tab(

    text: "隔壁",
  ),
  Tab(
    text: "关注",

  ),
  Tab(
    text: "话题",

  )
];

class DynamicPage extends StatefulWidget {
  const DynamicPage({Key key}) : super(key: key);

  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  var tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: Container(
          height: 50,
          child: Row(
            children: [
              Container(
                width: 10,
              ),
              ShitSign(),
              Expanded(
                  child: DefaultTabController(
                length: dynamicTabs.length,
                initialIndex: tabIndex,
                child: TabBar(
                  labelColor: Colors.black,
                  onTap: (i) {
                    print('iiii $i');
                  },
                  indicator: BoxDecoration(),
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.yellow,
                      decorationThickness: 6,
                      decorationStyle: TextDecorationStyle.dotted),
                  isScrollable: false,
                  unselectedLabelStyle: TextStyle(
                    decoration: TextDecoration.none,
                  ),
                  tabs: dynamicTabs,
                ),
              )),
              Icon(Icons.ac_unit),
              Container(
                width: 10,
              ),
            ],
          ),
        ));
  }
}
