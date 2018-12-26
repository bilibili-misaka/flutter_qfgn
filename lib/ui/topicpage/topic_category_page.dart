import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/home_page_recommend_model.dart' as homeData;
import 'package:flutter_app/model/topic_classify_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_app/ui/api.dart';
import 'package:flutter_app/ui/homepage/home_comm_list_item.dart';
import 'dart:ui' as ui;

import 'package:flutter_app/utils/http_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicCategoryPage extends StatefulWidget {
  final mTopData;

  TopicCategoryPage({Key key, this.mTopData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TopicCategoryPageState(mTopData);
  }
}

class TopicCategoryPageState extends State<TopicCategoryPage>
    with TickerProviderStateMixin {
  Data mTopData;

  TopicCategoryPageState(this.mTopData);

  double _opacity = 0.0;
  double _titleBarheight = 80;
  int _colorValue = 255;
  ScrollController _controller;
  TabController _tabController;

  double dx = 38;
  double dy = 45;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _tabController = TabController(length: 2, vsync: this);

    _controller.addListener(() {
      if (_controller.position.pixels <= _titleBarheight) {
        _opacity = _controller.position.pixels / _titleBarheight;
//        _colorValue = 255 - (_opacity * 255).floor();
        dy = 45 - _opacity * 45;
        dx = 38 - _opacity * 38;
      } else {
        _opacity = 1;
//        _colorValue = 0;
        dx = 0;
        dy = 0;
      }
//      print(_colorValue);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        primary: false,
        appBar: PreferredSize(child: Container(), preferredSize: Size(0, 0)),
        body: Stack(
      children: <Widget>[
        NestedScrollView(
          controller: _controller,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
//              SliverAppBar(
//                centerTitle: false,
//                expandedHeight: 150,
//                leading: Container(width: 0,),
//
//                elevation: 0,
//                backgroundColor: Colors.transparent,
//                flexibleSpace: FlexibleSpaceBar(
////                  background: TopicCategoryTopView(mTopData),
//                  collapseMode: CollapseMode.pin,
//                ),
//              ),

              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  maxHeight: 200,
                  minHeight: 120,
                  child: TopicCategoryTopView(mTopData, _tabController),
                ),
                pinned: true,
              )
            ];
          },
          body: Container(
            padding: EdgeInsets.all(0),
              child: TabBarView(controller: _tabController, children: [
            TopicCategoryContent(category_id: mTopData.id, sort_type: "postdate",),
            TopicCategoryContent(category_id: mTopData.id, sort_type: "hot"),
          ])),
        ),
        Material(
//          elevation: 5,
//          shadowColor: Color.fromARGB(255 - _colorValue, 150, 150, 150),
//          color: Color.fromARGB(255 - _colorValue, 255, 255, 255),
          color: Colors.transparent,
          child: BackdropFilter(
            filter:
                ui.ImageFilter.blur(sigmaX: 3 * _opacity, sigmaY: 3 * _opacity),
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(top: 18, bottom: 14, right: 14),
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  Container(
                    transform: Matrix4.translationValues(dx, dy, 0),
                    child: Text(
                      mTopData.name,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {})
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight > minHeight ? maxHeight : minHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class TopicCategoryTopView extends StatefulWidget {
  Data mTopData;
  TabController _tabController;

  TopicCategoryTopView(this.mTopData, this._tabController);

  @override
  State<StatefulWidget> createState() {
    return TopicCategoryTopViewState(mTopData, _tabController);
  }
}

class TopicCategoryTopViewState extends State<TopicCategoryTopView> {
  Data mTopData;
  TabController _tabController;

  TopicCategoryTopViewState(this.mTopData, this._tabController);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(mTopData.cover),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(),
              Container(
                padding: EdgeInsets.only(bottom: 6),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  CachedNetworkImageProvider(mTopData.cover)),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: -1,
                                offset: Offset(0, 1),
                                blurRadius: 5)
                          ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
//                            "情感日常",
                            "",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Text(
                                  "成员: " +
                                      mTopData.priority.toString() +
                                      "  帖子: " +
                                      mTopData.post_count.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                )),
                                Container(
                                  width: 80,
                                  height: 25,
                                  margin: EdgeInsets.only(right: 14),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Text(
                                    "加入副本",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 30,
                            child: Text(
                              mTopData.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                height: 40,
                child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black87,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                        text: "新帖",
                      ),
                      Tab(
                        text: "热门",
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopicCategoryContent extends StatefulWidget {
  final category_id;
  final sort_type;

  const TopicCategoryContent({Key key, this.category_id, this.sort_type}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return TopicCategoryContentState(category_id, sort_type);
  }
}

class TopicCategoryContentState extends State<TopicCategoryContent>
    with AutomaticKeepAliveClientMixin {
  homeData.HomeRecommendData mData;
  int startTime = 0;
  int endTime = 0;
  final category_id;
  final sort_type;
  TopicCategoryContentState(this.category_id,this.sort_type);


  Future _getData() async {
    var response = await HttpUtil.getInstance().post(Api.GET_TOPIC_CATEGORY,
        data: {
          "is_down": sort_type == "hot" ? "1" : "0",
          "start_time": startTime,
          "end_time": endTime,
          "size": "10",
          "category_id": category_id,
          "sort_type": sort_type
        },
        options: Options(
            baseUrl: Api.HOST,
            contentType:
                ContentType.parse("application/x-www-form-urlencoded")));
    if (mData == null) {
      mData = homeData.HomeRecommendData.fromJson(response);
    } else {
      homeData.HomeRecommendData moreData =
          homeData.HomeRecommendData.fromJson(response);
      if (moreData != null && moreData.data != null && mData.data.length > 0) {
        mData.data.addAll(moreData.data);
        endTime = mData.data[mData.data.length - 1].post_date;
      } else {}
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(itemBuilder: (BuildContext context, int index) {
      if (mData != null && mData.data != null && index < mData.data.length)
        return CommListItem(mData.data[index]);
    }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
