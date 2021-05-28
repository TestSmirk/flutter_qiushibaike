import 'package:flutter/cupertino.dart';

class PostQS extends StatefulWidget {
  const PostQS({Key key}) : super(key: key);

  @override
  _PostQSState createState() => _PostQSState();
}

class _PostQSState extends State<PostQS> with SingleTickerProviderStateMixin {
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
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Color(0xfff9e059),
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Center(
        child: Row(
          children: [
            Container(width: 10,),
            Icon(CupertinoIcons.pencil,size: 12,),
            Text("发帖",style: TextStyle(fontSize: 12),),
            Container(width: 10,)
          ],
        ),
      ),
    );
  }
}
