import 'package:flutter/material.dart';

class BottomMenuDialog extends Dialog{

  @override
  Widget build(BuildContext context) {

    return Material(
      type: MaterialType.transparency,

      child: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(bottom: 30),
        child: Container(
          color: Colors.white,
          height: 200,
          width: 300,
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 14,top: 8,bottom: 8,right: 35),
                    child: Image.asset("images/ic_my_collection.png",width: 28,height: 28,),
                  ),
                  Text("收藏",style: TextStyle(color: Colors.grey,fontSize: 16),)
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 14,top: 8,bottom: 8,right: 35),
                    child: Image.asset("images/ic_more_follow.png",width: 28,height: 28,),
                  ),
                  Text("关注",style: TextStyle(color: Colors.grey,fontSize: 16),)
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 14,top: 8,bottom: 8,right: 35),
                    child: Image.asset("images/ic_more_tipoff.png",width: 28,height: 28,),
                  ),
                  Text("举报",style: TextStyle(color: Colors.grey,fontSize: 16),)
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 14,top: 8,bottom: 8,right: 35),
//                    child: Image.asset("images/ic_close_black_24dp.png",color: Colors.black87,width: 28,height: 28,),
                    child: Icon(Icons.clear,color: Colors.black87,size: 28,),
                  ),
                  Text("取消",style: TextStyle(color: Colors.grey,fontSize: 16),)
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }

}