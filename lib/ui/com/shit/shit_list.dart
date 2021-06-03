import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:interactiveviewer_gallery/hero_dialog_route.dart';
import 'package:interactiveviewer_gallery/interactiveviewer_gallery.dart';
import 'package:nine_grid_view/nine_grid_view.dart';
import 'package:qiubai/api/api.dart';
import 'package:video_player/video_player.dart';

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
                childCount: items.length),
            )
          ])
        : Text("loading");
  }

  void data() {
    Future result;
    switch (this.type) {
      case ShitListCom.TYPE_OWN:
        {
          result = Api.getOwn();
          break;
        }
      case ShitListCom.TYPE_VIDEO:
        {
          result = Api.getVideo();
          break;
        }
      case ShitListCom.TYPE_TEXT:
        result = Api.getText();

        break;
        case ShitListCom.TYPE_PIC:
        result = Api.getImage();

        break;
      case ShitListCom.TYPE_SELECTIVE:

        result = Api.getSelective();
        break;
    }
    result?.then((value) {
      print('getOwngetOwn $value');
      setState(() {
        items = value["items"];
      });
      _controller.resetLoadState();
      _controller.finishRefresh();
    });
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
    final hot_comment = item["hot_comment"];
    final attach = item["attachments"];
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
                  imageUrl: user["thumb"] ?? "",
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
        Visibility(
            visible: item["pic_url"] != null,
            child: Padding(
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
                  imageUrl: item["pic_url"] ?? "",
                ),
              ),
            )),
        Visibility(
            visible: attach != null,
            child: NineGridView(
                type: NineGridType.weiBo,
                itemCount: attach != null ? attach.length : 0,
                itemBuilder: (context, index) {
                  final subItem = attach[index];

                  final lowUrl = subItem["low_url"];

                  final imageUrl = lowUrl.toString().endsWith("mp4")
                      ? subItem["pic_url"]
                      : lowUrl;
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          HeroDialogRoute<void>(
                            // DisplayGesture is just debug, please remove it when use
                            builder: (BuildContext context) =>
                                InteractiveviewerGallery(
                              sources: attach,
                              initIndex: attach.indexOf(subItem),
                              itemBuilder: (context, index, isFocus) {
                                final lowUrl = attach[index]["low_url"];
                                print('lowUrl ${lowUrl}');
                                if (lowUrl.toString().endsWith("mp4")) {

                                  final videoPlayerController  =VideoPlayerController.network(
                                      "https:${lowUrl}");
                                  videoPlayerController.initialize();
                                  final chewieController = ChewieController(
                                    videoPlayerController: videoPlayerController,
                                    autoPlay: true,
                                    looping: true,
                                  );
                                  return Chewie(controller: chewieController);
                                } else {
                                  return CachedNetworkImage(
                                      imageUrl:
                                          "https:${attach[index]["origin_url"]}");
                                }
                              },
                              onPageChanged: (int pageIndex) {
                                print("nell-pageIndex:$pageIndex");
                              },
                            ),
                          ),
                        );
                      },
                      child: Hero(
                          tag: "https:$imageUrl",
                          child: CachedNetworkImage(
                              fit: BoxFit.cover, imageUrl: "https:$imageUrl")));
                })),
        Visibility(
            visible: hot_comment != null,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xfff6f6f6),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      child: Row(
                        children: [
                          Container(
                            width: 5,
                          ),
                          ClipOval(
                            child: CachedNetworkImage(
                                height: 25,
                                width: 25,
                                imageUrl: hot_comment != null
                                    ? hot_comment["user"]["thumb"] ?? ""
                                    : ""),
                          ),
                          Container(
                            width: 5,
                          ),
                          Text(hot_comment != null
                              ? hot_comment["user"]["login"]
                              : ""),
                          Spacer(),
                          Text(
                            "${hot_comment != null ? hot_comment["like_count"] : ""} 赞",
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                          Container(
                            width: 10,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Expanded(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            hot_comment != null ? hot_comment["content"] : "d",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff636363),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        Container(
          height: 40,
          child: Row(
            children: [
              Container(
                width: 20,
              ),
              Icon(
                Icons.tag_faces,
                size: 20,
              ),
              Container(
                width: 5,
              ),
              Text(
                "${item["votes"]["up"]}",
                style: TextStyle(fontSize: 12),
              ),
              Container(
                width: 10,
              ),
              Icon(
                Icons.thumb_down_alt_outlined,
                size: 20,
              ),
              Container(
                width: 5,
              ),
              Text(
                "${item["votes"]["down"]}",
                style: TextStyle(fontSize: 12),
              ),
              Spacer(),
              Icon(
                Icons.comment,
                size: 20,
              ),
              Container(
                width: 5,
              ),
              Text(
                "${item["comments_count"]}",
                style: TextStyle(fontSize: 12),
              ),
              Container(
                width: 5,
              ),
              Icon(
                Icons.share,
                size: 20,
              ),
              Container(
                width: 5,
              ),
              Text(
                "${item["share_count"]}",
                style: TextStyle(fontSize: 12),
              ),
              Container(
                width: 10,
              ),
            ],
          ),
        )
      ],
    );
  }
}

