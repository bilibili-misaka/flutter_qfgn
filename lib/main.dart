import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home.dart';
import 'package:flutter_app/ui/message.dart';
import 'package:flutter_app/ui/personalpage/personal_page.dart';
import 'package:flutter_app/ui/topic.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  TabController _controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
    _controller..addListener((){
      index = _controller.index;
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
          children: [
            HomePage(),
            TopicPage(),
            Center(child: Image.asset("images/ic_tab_post.png")),
            MessagePage(),
            PersonalPage(),
          ],
        controller: _controller,
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
//                borderRadius: BorderRadius.all(
//                  Radius.circular(6.0),
//                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[500],
                      blurRadius: 6,
                      offset: Offset(0,1),
                      spreadRadius: -1
                  )
                ]

            ),
            child: TabBar(
              labelColor: Colors.pinkAccent,
              unselectedLabelColor: Colors.grey,
              labelPadding: EdgeInsets.only(top: 6),
              indicatorColor: Colors.transparent,
              indicatorWeight: 0.1,
              isScrollable: false,
              controller: _controller,
              tabs: [
                Tab(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        index==0?"images/ic_tab_home_selected.png":"images/ic_tab_home.png",
                        width: 22,
                        color: index==0?null:Colors.grey),
                      Text("主页",style: TextStyle(fontSize: 11),)
                    ],
                  ),

                ),
                Tab(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                          index==1?"images/ic_tab_plate_selected.png":"images/ic_tab_plate.png",
                          width: 22,
                          color: index==1?null:Colors.grey),
                      Text("话题",style: TextStyle(fontSize: 11),)
                    ],
                  ),

                ),
                Tab(
                    child: Text("")

                ),
                Tab(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                          index==3?"images/ic_tab_message_selected.png":"images/ic_tab_message.png",
                          width: 22,
                          color: index==3?null:Colors.grey),
                      Text("消息",style: TextStyle(fontSize: 11),)
                    ],
                  ),

                ),
                Tab(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                          index==4?"images/ic_tab_personal_selected.png":"images/ic_tab_personal.png",
                          width: 22,
                          color: index==4?null:Colors.grey),
                      Text("我的",style: TextStyle(fontSize: 11),)
                    ],
                  ),

                )
              ],
            ),
          ),
          Container(
              color: Colors.transparent,
              height: 50,
              width: MediaQuery.of(context).size.width/5,
              child: Image.asset("images/ic_tab_post.png")),
        ],
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
