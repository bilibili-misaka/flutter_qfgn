import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/search_user_list_model.dart';
import 'package:flutter_app/ui/api.dart';
import 'package:flutter_app/utils/http_util.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchUserPage extends StatefulWidget{

  final searchText;
  SearchUserPageState state;
  SearchUserPage({Key key, this.searchText}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return state = SearchUserPageState(searchText);
  }

}

class SearchUserPageState extends State<SearchUserPage> with AutomaticKeepAliveClientMixin{

  UserListData mData;
  String searchText;

  SearchUserPageState(this.searchText);

  @override
  void initState() {
    super.initState();
  }

  Future getData(String searchText) async{
    var response = await HttpUtil.getInstance().post(Api.SEARCH_USER,data: {"keyword":searchText},
        options: Options(
      baseUrl: Api.HOST_SEARCH,
      contentType: ContentType.parse("application/x-www-form-urlencoded"),
    )
    );
    mData = UserListData.fromJson(response);

    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return mData==null||mData.data==null||mData.data.length<1?Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Spacer(flex: 1,),
          Image.asset("images/no_data.png",width: 120,height: 120,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("空空如也",style: TextStyle(color: Colors.grey,fontSize: 16),),
          ),
          Spacer(flex: 2,),
        ],
      ),
    ):ListView.builder(itemBuilder: (BuildContext context,int index){
      if(index<mData.data.length)
        return Padding(
          padding: const EdgeInsets.only(left:12,right:12,),
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  child: CachedNetworkImage(imageUrl: mData.data[index].avatar,width: 45,height: 45,fit: BoxFit.cover,),
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(mData.data[index].username,style: TextStyle(color: Colors.grey,fontSize: 15),),
                        Text("关注: "+mData.data[index].isFollow.toString()+" 粉丝: "+mData.data[index].fansCount.toString(),style: TextStyle(color: Colors.grey,fontSize: 12),),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 6,right: 6,top: 2,bottom: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.grey,width: 1)
                  ),
                  child: Text("+关注",style: TextStyle(color: Colors.grey,fontSize: 13),),
                )
              ],
            ),
          ),
        );
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}