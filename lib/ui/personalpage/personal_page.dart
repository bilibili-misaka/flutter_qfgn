import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_app/ui/personalpage/personal_list_item.dart';

class PersonalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PersonalPageState();
  }
}

class PersonalPageState extends State<PersonalPage> with SingleTickerProviderStateMixin{
  List<Map> _setList = [];
  double _opacity = 0.0;
  Tween colorTween;
  ScrollController _controller;
  double _titleBarheight = 120;
  int _colorValue = 255;

  Widget _createSignBtn() {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.pink.withOpacity(0.7),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Text(
        "已签到",
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _setList.add({
      "icon": "images/ic_my_mission.png",
      "text": "任务中心",
      "plugWidget": _createSignBtn()
    });
    _setList.add({});
    _setList.add({"icon": "images/ic_my_post.png", "text": "我的贴子"});
    _setList.add({"icon": "images/ic_my_comment.png", "text": "我的评论"});
    _setList.add({"icon": "images/ic_my_collection.png", "text": "我收藏的"});
    _setList.add({"icon": "images/ic_my_like.png", "text": "我赞过的"});
    _setList.add({"icon": "images/ic_my_history.png", "text": "浏览记录"});
    _setList.add({"icon": "images/ic_my_dark_room.png", "text": "小黑屋"});
    _setList.add({});
    _setList.add({"icon": "images/ic_my_share.png", "text": "推荐给好友"});
    _setList.add({"icon": "images/ic_my_help.png", "text": "帮助与反馈"});

    colorTween = ColorTween(
      begin: Colors.white,
      end:Colors.black,
    );


    _controller = ScrollController(

    )..addListener((){
      if(_controller.position.pixels <= _titleBarheight){
        _opacity = _controller.position.pixels/_titleBarheight;
        _colorValue = 255-(_opacity*255).floor();
      }else{
        _opacity = 0.99;
        _colorValue = 0;
      }
      print(_colorValue);
      setState(() {
      });

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _controller,
            slivers: <Widget>[
              SliverList(
                  delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                    if (index == 0) {
                      return PersonalTopView();
                    } else {
                      if (index < _setList.length + 1)
                        return PersonalListItem(_setList[index-1]);
                    }
                  }, childCount: _setList.length + 1)
              ),
              SliverPadding(padding: EdgeInsets.all(40))
            ],
          ),
          Material(
            elevation: 3,
            shadowColor: Color.fromARGB(255-_colorValue, 150, 150, 150),
            color: Color.fromARGB(255-_colorValue, 255, 255, 255),
            child: Container(
              padding: EdgeInsets.only(left: 14,top: 20,bottom: 14,right: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                        "我的",
                        style: TextStyle(color: Color.fromARGB(255, _colorValue, _colorValue, _colorValue), fontSize: 20),
                      )),
                  IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Color.fromARGB(255, _colorValue, _colorValue, _colorValue),
                        size: 24,
                      ),
                      onPressed: () {})
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

}

class PersonalTopView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PersonalTopViewState();
  }
}

class PersonalTopViewState extends State<PersonalTopView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/bg_user3.jpg"), fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
        child: Container(
          color: Colors.black.withOpacity(0.2),
          padding: EdgeInsets.only(top: 60, left: 12, right: 12, bottom: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(5)),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/default_avatar.png"),
                      radius: 30,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "未登录",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          "这个人很懒，还没有写个人介绍",
                          maxLines: 2,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "拥有的D币",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              "images/ic_gold.png",
                              width: 16,
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                "0",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                            Spacer(),
                            Image.asset(
                              "images/ic_exchange.png",
                              width: 17,
                              height: 17,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text("0",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          Text("获赞",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.5,
                      height: 25,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text("0",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          Text("关注",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.5,
                      height: 25,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text("0",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          Text("粉丝",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.5,
                      height: 25,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text("0",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          Text("编辑",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }


}
