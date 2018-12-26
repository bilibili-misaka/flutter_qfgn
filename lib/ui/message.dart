import 'package:flutter/material.dart';
import 'package:flutter_app/ui/messagepage/message_remind_page.dart';

class MessagePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MessagePageState();
  }

}

class MessagePageState extends State<MessagePage> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TabBar(
            indicatorWeight: 0.1,
            isScrollable: true,
            controller: _tabController,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Colors.grey,
            labelPadding: EdgeInsets.only(right: 14),
            tabs: [
              Tab(
                child: Text("提醒",style: TextStyle(fontSize: 20,),),
              ),
              Tab(
                child: Text("消息",style: TextStyle(fontSize: 20,),),
              ),
            ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
          children: [
            MessageRemindPage(),
            MessageRemindPage(),
          ]
      ),
    );
  }

}