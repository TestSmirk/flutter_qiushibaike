import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:qiubai/api/api.dart';

class ShitListCom extends StatefulWidget {
  static const TYPE_FOLLOW = 0;
  static const TYPE_OWN = 1;
  static const TYPE_VIDEO = 2;
  static const TYPE_TEXT = 3;
  static const TYPE_PIC = 4;
  static const TYPE_SELECTIVE = 5;
  static const TYPE_WTF = 6;
  final type;

  const ShitListCom({Key key, this.type}) : super(key: key);

  @override
  _ShitListComState createState() => _ShitListComState(type);
}

class _ShitListComState extends State<ShitListCom>

    with SingleTickerProviderStateMixin {
   EasyRefreshController _controller;


  var type;
  List<dynamic> items;
  ScrollController _scrollController;

  _ShitListComState(type) {
    this.type = type;
    print('type $type');

    data();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = EasyRefreshController();


  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return items != null
        ? EasyRefresh.custom(
        enableControlFinishRefresh: true,
        scrollController: _scrollController,
        controller: _controller,
        onRefresh: ()async{
          data();
        },
        header: ClassicalHeader(),
        slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = items[index];
                  return ShitItem(item);
                },
              ),
            )
          ])
        : Text("loading");
  }

  void data() {
    switch (this.type) {
      case ShitListCom.TYPE_OWN:
        {
          Api.getOwn().then((value) {
            print('getOwngetOwn $value');
            setState(() {
              items = value["items"];
            });
            _controller.resetLoadState();
            _controller.finishRefresh();

          });
        }
    }
  }
}

class ShitItem extends StatefulWidget {
  final item;

  ShitItem(this.item);

  @override
  _ShitItemState createState() => _ShitItemState(item);
}

class _ShitItemState extends State<ShitItem>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final item;

  _ShitItemState(this.item);

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
    final user = item["user"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          child: Row(
            children: [
              Container(
                width: 10,
              ),
              ClipOval(
                child: CachedNetworkImage(
                  width: 40,
                  height: 40,
                  imageUrl: user["thumb"],
                ),
              ),
              Container(
                width: 10,
              ),
              Text(user["login"]),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xfff2f2f2),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  child: Text(
                    "关注",
                    style: TextStyle(
                      color: Color(0xff282828),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Container(
                width: 12,
              ),
              Icon(
                Icons.close,
                size: 14,
                color: Colors.grey,
              ),
              Container(
                width: 10,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            item["content"],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 300,
            child: CachedNetworkImage(
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              imageUrl: item["pic_url"],
            ),
          ),
        )
      ],
    );
  }
}
