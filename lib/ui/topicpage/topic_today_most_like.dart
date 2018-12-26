import 'package:flutter/material.dart';
import 'package:flutter_app/ui/api.dart';
import 'package:flutter_app/ui/homepage/home_recommend.dart';

class TopicTodayMostLikePage extends StatelessWidget{

  final pageType; //1.每日最赞 2.编辑精选
  static final MOST_LIKE = 1;
  static final CHOICE_POSTS = 2;

  const TopicTodayMostLikePage({Key key, this.pageType}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: (){
          Navigator.pop(context);
        }),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(pageType==MOST_LIKE?"每日最赞":"编辑精选",style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.w500),),
      ),
      body: HomeRecommend(url: pageType==MOST_LIKE?Api.TOPIC_TODAY_MOST_LIKE:Api.GET_CHOICE_POSTS,responseData: {},loadMore: false,),
    );
  }

}