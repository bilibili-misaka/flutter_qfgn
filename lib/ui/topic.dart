import 'package:flutter/material.dart';
import 'package:flutter_app/ui/topicpage/topic_follow_page.dart';
import 'package:flutter_app/ui/topicpage/topic_recommend.dart';

class TopicPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TopicPageState();
  }

}

class TopicPageState extends State<TopicPage> with SingleTickerProviderStateMixin{

  TabController _controller;
  double dx;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
//    _controller.addListener((){
//      setState(() {
//
//      });
//    });
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
          tabs: [
            Text("发现",style: TextStyle(fontSize: 20),),
            Text("关注",style: TextStyle(fontSize: 20),),
          ],
          unselectedLabelColor: Colors.grey,
          indicatorWeight: 0.1,
        ),
        actions: <Widget>[
          IconButton(icon:Icon(Icons.search),color: Colors.grey[800], onPressed: (){
          })
        ],
      ),
      body: TabBarView(
          controller: _controller,
          children: [
            TopicRecommend(""),
            TopicFollowPage(),
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