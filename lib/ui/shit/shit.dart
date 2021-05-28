import 'package:flutter/material.dart';
import 'package:qiubai/ui/com/shit/shit_post_qs.dart';
import 'package:qiubai/ui/com/shit/shit_search.dart';
import 'package:qiubai/ui/com/shit_sign.dart';

class ShitPage extends StatefulWidget {
  const ShitPage({Key key}) : super(key: key);

  @override
  _ShitPageState createState() => _ShitPageState();
}

class _ShitPageState extends State<ShitPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

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
                length: 3,
                child: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.assignment_ind),),
                  Tab(icon: Icon(Icons.assignment_late),),
                  Tab(icon: Icon(Icons.assignment_return),),
                ],
              ),),
            )
          ],
        ));
  }
}
