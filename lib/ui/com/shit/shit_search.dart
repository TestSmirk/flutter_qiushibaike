import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShitSearch extends StatefulWidget {
  const ShitSearch({Key key}) : super(key: key);

  @override
  _ShitSearchState createState() => _ShitSearchState();
}

class _ShitSearchState extends State<ShitSearch>
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
    return Expanded(child: Container(
      height: 35,
      decoration: BoxDecoration(color: Color(0xfff7f7f7)
          ,borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(CupertinoIcons.search),
            Text("搜索糗事")
          ],
        ),
      ),
    ));
  }
}
