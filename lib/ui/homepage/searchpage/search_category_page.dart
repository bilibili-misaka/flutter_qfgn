import 'package:flutter/material.dart';
import 'package:flutter_app/model/topic_classify_model.dart';
import 'package:flutter_app/ui/api.dart';
import 'package:flutter_app/utils/http_util.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchCategoryPage extends StatefulWidget{

  final searchText;
  SearchCategoryPageState state;

  SearchCategoryPage({Key key, this.searchText}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return state = SearchCategoryPageState(searchText);
  }

}

class SearchCategoryPageState extends State<SearchCategoryPage> with AutomaticKeepAliveClientMixin{

  TopicClassifyData mData;
  String searchText;
  SearchCategoryPageState(this.searchText);

  @override
  void initState() {
    super.initState();
  }

  Future getData(String searchText) async{
    var response = await HttpUtil.getInstance().get(Api.SEARCH_CATEGORY,data: {"keyword":searchText});
    mData = TopicClassifyData.fromJson(response);
    
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
        padding: const EdgeInsets.only(left:5,right:5,),
        child: Card(
          color: Colors.white,
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 2,
                  child: ClipRRect(
                    child: CachedNetworkImage(imageUrl: mData.data[index].cover,width: 55,height: 55,),
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(mData.data[index].name,style: TextStyle(color: Colors.black87),),
                        Text(mData.data[index].description,style: TextStyle(color: Colors.grey),)
                      ],
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios,color: Colors.grey[400],size: 18,)
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}