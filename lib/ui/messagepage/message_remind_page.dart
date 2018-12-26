import 'package:flutter/material.dart';

class MessageRemindPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MessageRemindPageState();
  }

}

class MessageRemindPageState extends State<MessageRemindPage> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16),
            child: TabBar(
                labelPadding: EdgeInsets.only(right: 12),
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontSize: 15),
                indicatorWeight: 0.1,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: "通知",
                  ),
                  Tab(
                    text: "@我的",
                  ),
                  Tab(
                    text: "评论",
                  ),
                  Tab(
                    text: "收到赞",
                  ),
                ]
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
                children: [
                  MessageRemindItemPage(),
                  MessageRemindItemPage(),
                  MessageRemindItemPage(),
                  MessageRemindItemPage(),
                ]
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

}

class MessageRemindItemPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("images/no_network.png",width: 120,height: 120,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("三次元的网络不行呀",style: TextStyle(color: Colors.grey,fontSize: 16),),
          ),
          Container(
            height: 100,
          )
        ],

      ),
    );
  }
  
}