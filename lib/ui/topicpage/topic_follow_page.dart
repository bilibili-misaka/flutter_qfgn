import 'package:flutter/material.dart';

class TopicFollowPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Spacer(flex: 1,),
          Image.asset("images/no_data.png",width: 120,height: 120,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("去关注更多的人吧",style: TextStyle(color: Colors.grey,fontSize: 16),),
          ),
          Spacer(flex: 2,),
        ],
      ),
    );
  }
  
}