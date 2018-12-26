import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/home_page_recommend_model.dart';
import 'package:flutter_app/ui/api.dart';
import 'package:flutter_app/ui/homepage/home_comm_list_item.dart';
import 'package:flutter_app/utils/http_util.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";

class HomeRecommend extends StatefulWidget{

  final type;
  final url;
  final responseData;
  final loadMore;
  HomeRecommendState state;
  HomeRecommend({Key key,this.type,this.url,this.responseData,this.loadMore}):super(key: key);

  @override
  State<StatefulWidget> createState() {
    return state = HomeRecommendState(type: type,url: url,responseData: responseData,loadMore: loadMore);
  }

}

class HomeRecommendState extends State<HomeRecommend> with AutomaticKeepAliveClientMixin{

  final String type;
  final url;
  final responseData;
  bool loadMore;
  HomeRecommendState({this.type,this.url,this.responseData,loadMore}):this.loadMore = loadMore==null?true:loadMore;

  HomeRecommendData mData;
  RefreshController _refreshController;
  int startTime = 0;
  int endTime = 0;
  String isDown = "0";

  int mode;

  Future _getData() async {
    var response;
    if(responseData!=null){
      response = await HttpUtil.getInstance().get(url,data: responseData);
    }else{
      response = await HttpUtil.getInstance().get(url,data: {"is_down":isDown,"start_time":startTime,"end_time":endTime,"size":"10"});
    }

  mData = HomeRecommendData.fromJson(response);
    if(mData!=null && mData.data!=null && mData.data.length>0){
      startTime = mData.data[0].post_date;
      endTime = mData.data[mData.data.length-1].post_date;
      _refreshController.sendBack(false, RefreshStatus.idle);
    }

    setState(() {});
  }

  Future reqData(String url,Map responseData) async{
    var response = HttpUtil.getInstance().get(url,data: responseData);
    mData = HomeRecommendData.fromJson(response);
    setState(() {
    });
  }

  Future _getMoreData() async {
    var response;
    if(responseData!=null){
      response = await HttpUtil.getInstance().get(url,data: responseData);
    }else{
      response = await HttpUtil.getInstance().get(url,data: {"is_down":isDown,"start_time":startTime,"end_time":endTime,"size":"10"});
    }

    HomeRecommendData moreData = HomeRecommendData.fromJson(response);
    if(moreData!=null && moreData.data!=null && mData.data.length>0){
      mData.data.addAll(moreData.data);
      endTime = mData.data[mData.data.length-1].post_date;
      mode = RefreshStatus.idle;
    }else{
      mode = RefreshStatus.noMore;
    }
    _refreshController.sendBack(false, RefreshStatus.idle);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getData();
    _refreshController = RefreshController();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(

      onRefresh: (){
        return Future.delayed(Duration(milliseconds: 1000)).then((val){
          _onRefresh(true);
        });
      },

      child: SmartRefresher(
        enablePullDown: false,
        enableOverScroll: false,
        enablePullUp: loadMore,
        controller: _refreshController,

        footerConfig: LoadConfig(autoLoad: true,bottomWhenBuild: false),
        footerBuilder: (BuildContext context,int mode){
          return Center(
            child: ClassicIndicator(
              mode: mode,
              idleText: "加载完成",
              refreshingText: "正在加载下一页...",
              noDataText: "已经到底了",
            ),
          );
        },

        headerConfig: RefreshConfig(
          visibleRange: 0,
          triggerDistance: 80,
        ),
//        headerBuilder: (BuildContext context,int mode){
//          return Center(
//            child: Text("正在加载..."),
//          );
//        },
        onRefresh: _onRefresh,

        child: ListView.builder(itemBuilder: (BuildContext context,int index){
          if(mData!=null&&mData.data!=null && index<mData.data.length)
            return CommListItem(mData.data[index]);
        })
      ),
    );
  }

  void _onRefresh(bool up){
    if(up){
      isDown = "1";
      _getData();
    }
    else{
      _getMoreData();
    }

  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.scrollController.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}