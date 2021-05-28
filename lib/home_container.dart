
import 'package:flutter/material.dart';
import 'package:qiubai/ui/shit/msg.dart';
import 'package:qiubai/ui/shit/shit.dart';

class HomeContainer extends StatefulWidget{
  final index;

  const HomeContainer({this.index,Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    print('index index $index');
    return HomeState(index);
  }
}
class HomeState extends State<HomeContainer>{
  var index;

  HomeState(this.index);


  @override
  Widget build(context) {
    print('index $index');
    switch (index) {
      case 0:
        return ShitPage();

      case 1:
        return ShitPage();

      case 2:
        return ShitPage();

      case 3:
        return MsgPage();

      case 4:
        return ShitPage();
    }
    return Container();
  }
}