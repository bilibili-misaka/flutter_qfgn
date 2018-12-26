import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/home_page_recommend_model.dart';
import 'package:flutter_app/model/topic_classify_model.dart';
import 'package:flutter_app/model/topic_page_banner_model.dart';
import 'package:flutter_app/model/topic_page_guess_like_model.dart';
import 'package:flutter_app/ui/api.dart';
import 'package:flutter_app/ui/topicpage/topic_guess_like_item.dart';
import 'package:flutter_app/ui/topicpage/topic_rank_list_item.dart';
import 'package:flutter_app/ui/topicpage/topic_today_most_like.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TopicRecommend extends StatefulWidget{
  final String type;

  TopicRecommend(this.type);

  @override
  State<StatefulWidget> createState() {
    return TopicRecommendState(type);
  }
}

class TopicRecommendState extends State<TopicRecommend>
    with AutomaticKeepAliveClientMixin {
  final String type;

  TopicRecommendState(this.type);

  TopicBannerData mBannerData;
  HomeRecommendData mGuessLikeData;
  TopicClassifyData mClassifyListData;
  String startTime = "0";
  String endTime = "0";
  
//  PageController _pageController;

  Future _getBannerData() async {
    Dio dio = new Dio();
    dio.options.baseUrl = "http://go.tongmoe.com";
    Response response = await dio.get(Api.TOPIC_BANNER, data: {});
    mBannerData = TopicBannerData.fromJson(response.data);
    setState(() {});
  }

  Future _getData() async {
    Dio dio = new Dio();
    dio.options.baseUrl = "http://go.tongmoe.com";
    Response response = await dio.get(Api.TOPIC_GUESS_LIKE, data: {});
    mGuessLikeData = HomeRecommendData.fromJson(response.data);
    setState(() {});
  }

  Future _getClassifyData() async {
    Dio dio = new Dio();
    dio.options.baseUrl = "http://go.tongmoe.com";
    Response response = await dio.get(Api.TOPIC_LIST, data: {});
    mClassifyListData = TopicClassifyData.fromJson(response.data);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getBannerData();
    _getData();
    _getClassifyData();

//    _pageController = PageController(
//      viewportFraction: 0.8,
//      initialPage: 1,
//    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            if (index == 0 && mBannerData != null && mBannerData.data != null) {
              return Container(
                height: 150,
                child: CarouselSlider(
                  autoPlay: true,
                    viewportFraction: 1.0,
                    items: mBannerData.data.map((item){
                      return Builder(builder: (BuildContext context){
                        return  Container(
                            child: Image.network(
                          mBannerData.data[index].image_url,
                          height: 150,
                        ));
                      });
                    }).toList()
                )
//                child: PageView.builder(
//                    reverse: true,
//                    itemBuilder: (BuildContext context, int index) {
//                      if (mBannerData != null && mBannerData.data != null)
//                        return Container(
//                            child: Image.network(
//                          mBannerData.data[index].image_url,
//                          height: 150,
//                        ));
//                    }),
              );
            } else if (index == 1) {
              return Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 14, top: 12, bottom: 12),
                  child: Text(
                    "猜你喜欢",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ));
            } else if (index == 2 && mGuessLikeData!=null && mGuessLikeData.data!=null) {
              return CarouselSlider(

                height: 160,
//                autoPlay: true,
                reverse: true,
//                aspectRatio: 16/9,
                initialPage: 1,
                viewportFraction: 0.8,
//                  distortion: false,
//                interval: const Duration(seconds: 4),
//                autoPlayCurve: Curves.fastOutSlowIn,
//                autoPlayDuration: const Duration(milliseconds: 800),

                items: mGuessLikeData.data.map((item){
                  return Builder(builder: (BuildContext context){
                      return TopicGuessLikeItem(item);
                  });
                }).toList(),
              );
            } else if (index == 3) {
              return Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(""),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset("images/ic_huochai.png",
                              height: 35, width: 35),
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return TopicTodayMostLikePage(pageType: TopicTodayMostLikePage.MOST_LIKE,);
                              }));
                            },
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "每日最赞",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                Text(
                                  "收到赞啦吗？",
                                  style:
                                      TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 1.5,
                          height: 30,
                          margin: EdgeInsets.only(left: 12, right: 12),
                          color: Colors.grey[600],
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            "images/ic_huotui.png",
                            height: 32,
                            width: 32,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return TopicTodayMostLikePage(pageType: TopicTodayMostLikePage.CHOICE_POSTS,);
                              }));
                            },
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "编辑精选",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                Text(
                                  "我上电视啦",
                                  style:
                                      TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(""),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 14, top: 25, right: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: Text(
                            "话题榜",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          )),
                          Text(
                            "话题广场>",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (mClassifyListData != null &&
                mClassifyListData.data != null &&
                index < mClassifyListData.data.length + 4) {
              return Container(
                height: 110,
                padding: EdgeInsets.only(left: 14, bottom: 14, right: 14),
                child: TopicListItem(mItemData: mClassifyListData.data[index - 4],),
              );
            }
          }, childCount: 4 + (mClassifyListData==null?0:mClassifyListData.data.length)),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
//    _pageController.dispose();
  }
}
