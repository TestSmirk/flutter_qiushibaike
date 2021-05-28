import 'package:flutter/cupertino.dart';
import 'package:qiubai/ui/com/public/FrameAnimationImage.dart';

final signImagePaths = [
  "images/home/sign/qb_sign_gold_coin_1.png",
  "images/home/sign/qb_sign_gold_coin_2.png",
  "images/home/sign/qb_sign_gold_coin_3.png",
  "images/home/sign/qb_sign_gold_coin_4.png",
  "images/home/sign/qb_sign_gold_coin_5.png",
  "images/home/sign/qb_sign_gold_coin_6.png",
  "images/home/sign/qb_sign_gold_coin_7.png",
  "images/home/sign/qb_sign_gold_coin_8.png",
  "images/home/sign/qb_sign_gold_coin_9.png",
  "images/home/sign/qb_sign_gold_coin_10.png",
  "images/home/sign/qb_sign_gold_coin_11.png",
  "images/home/sign/qb_sign_gold_coin_12.png",
  "images/home/sign/qb_sign_gold_coin_13.png",
  "images/home/sign/qb_sign_gold_coin_14.png",
  "images/home/sign/qb_sign_gold_coin_15.png",
  "images/home/sign/qb_sign_gold_coin_16.png",
];

class ShitSign extends StatefulWidget {
  const ShitSign({Key key}) : super(key: key);

  @override
  _ShitSignState createState() => _ShitSignState();
}

class _ShitSignState extends State<ShitSign> with SingleTickerProviderStateMixin {
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
    return FrameAnimationImage(signImagePaths, width: 80, height: 35, interval: 50,start: true,);
  }
}
