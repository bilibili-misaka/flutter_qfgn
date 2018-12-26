import 'package:flutter/material.dart';
import 'package:flutter_app/ui/api.dart';
import 'package:flutter_app/ui/homepage/home_recommend.dart';
import 'package:flutter_app/ui/homepage/searchpage/home_search_page.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TabBar(
          indicatorColor: Colors.transparent,
          isScrollable: true,
          controller: _controller,
          labelColor: Theme.of(context).accentColor,
          labelPadding: EdgeInsets.only(right: 14),
          tabs: [
            Text("推荐",style: TextStyle(fontSize: 20),),
            Text("视频",style: TextStyle(fontSize: 20),),
            Text("图文",style: TextStyle(fontSize: 20),),
            Text("关注",style: TextStyle(fontSize: 20),),
          ],
          unselectedLabelColor: Colors.grey,
          indicatorWeight: 0.1,
        ),
        actions: <Widget>[
        Hero(
          tag: "home_search_btn",
          child: Material(
            color: Colors.transparent,
            child: IconButton(icon:Icon(Icons.search),color: Colors.grey[800], onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return CommSearchPage();
              }));
            }),
          ),
        )
      ],
      ),
      body: TabBarView(
          controller: _controller,
          children: [
            HomeRecommend(type: "",url: Api.HOME_RECOMMEND,),
            HomeRecommend(type:"video",url: Api.HOME_RECOMMEND,),
            HomeRecommend(type:"img",url: Api.HOME_RECOMMEND,),
            Text("关注",style: TextStyle(fontSize: 18),),
          ]
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

}