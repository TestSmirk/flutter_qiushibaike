import 'package:flutter/material.dart';
import 'package:qiubai/ui/com/shit/shit_list.dart';
import 'package:qiubai/ui/com/shit/shit_post_qs.dart';
import 'package:qiubai/ui/com/shit/shit_search.dart';
import 'package:qiubai/ui/com/shit_sign.dart';

class ShitPage extends StatefulWidget {
  const ShitPage({Key key}) : super(key: key);

  @override
  _ShitPageState createState() => _ShitPageState();
}

class _ShitPageState extends State<ShitPage>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
  AnimationController _controller;
  var tabIndex = 1;
  var pageIndex = 1;
  TabController tabController;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    tabController = TabController(
        initialIndex: tabIndex, length: shitTabs.length, vsync: this);
    pageController = PageController(initialPage: tabIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    pageController.dispose();
    tabController.dispose();
    super.dispose();
  }

  final shitTabs = [
    Tab(
      text: "关注",
    ),
    Tab(
      text: "专享",
    ),
    Tab(
      text: "视频",
    ),
    Tab(
      text: "纯文",
    ),
    Tab(
      text: "纯图",
    ),
    Tab(
      text: "精华",
    ),
    Tab(
      text: "爆社",
    ),
  ];

  final tabsContent = [
    ShitListCom(
      type: ShitListCom.TYPE_FOLLOW,
    ),
    ShitListCom(
      type: ShitListCom.TYPE_OWN,
    ),
    ShitListCom(
      type: ShitListCom.TYPE_VIDEO,
    ),
    ShitListCom(
      type: ShitListCom.TYPE_TEXT,
    ),
    ShitListCom(
      type: ShitListCom.TYPE_PIC,
    ),
    ShitListCom(
      type: ShitListCom.TYPE_SELECTIVE,
    ),
    ShitListCom(
      type: ShitListCom.TYPE_WTF,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            Container(
              height: 50,
              color: Colors.red,
              child: Row(
                children: [
                  Container(
                    width: 10,
                  ),
                  ShitSign(),
                  Container(
                    width: 5,
                  ),
                  ShitSearch(),
                  Container(
                    width: 10,
                  ),
                  PostQS(),
                  Container(
                    width: 10,
                  )
                ],
              ),
            ),
            Container(
              height: 50,
              child: DefaultTabController(
                length: shitTabs.length,
                initialIndex: tabIndex,
                child: TabBar(
                  labelColor: Colors.black,
                  controller: tabController,
                  onTap: (i) {
                    print('iiii $i');
                    pageController.animateToPage(i,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.ease);
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
                  isScrollable: true,
                  unselectedLabelStyle: TextStyle(
                    decoration: TextDecoration.none,
                  ),
                  tabs: shitTabs,
                ),
              ),
            ),
            Expanded(
                child: PageView(
              scrollDirection: Axis.horizontal,
              controller: pageController,
              onPageChanged: (i) {
                print('index $i');
                tabController.animateTo(i,
                    duration: Duration(milliseconds: 300));
              },
              children: tabsContent,
            ))
          ],
        ));
  }
}
