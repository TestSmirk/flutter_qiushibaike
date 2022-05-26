import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:interactiveviewer_gallery/hero_dialog_route.dart';
import 'package:interactiveviewer_gallery/interactiveviewer_gallery.dart';
import 'package:video_player/video_player.dart';

class Pop extends StatelessWidget {
  final attach;
  final index;
  const Pop({this.attach,this.index,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InteractiveviewerGallery(
      sources: attach,
      initIndex: index,
      itemBuilder: (context, index, isFocus) {
        final lowUrl = attach[index]["low_url"];
        print('lowUrl ${lowUrl}');
        if (lowUrl.toString().endsWith("mp4")) {
          final videoPlayerController = VideoPlayerController.network("https:${lowUrl}");
          videoPlayerController.initialize();
          final chewieController = ChewieController(
            videoPlayerController: videoPlayerController,
            autoPlay: true,
            looping: true,
          );
          return Chewie(controller: chewieController);
        } else {
          return CachedNetworkImage(imageUrl: "https:${attach[index]["origin_url"]}");
        }
      },
      onPageChanged: (int pageIndex) {
        print("nell-pageIndex:$pageIndex");
      },
    );
  }
}
