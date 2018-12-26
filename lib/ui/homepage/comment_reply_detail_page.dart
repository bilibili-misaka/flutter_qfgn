import 'package:flutter/material.dart';
import 'package:flutter_app/model/comment_detail_reply_model.dart';
import 'package:flutter_app/ui/api.dart';
import 'package:flutter_app/ui/show_image_page.dart';
import 'package:flutter_app/utils/date_util.dart';
import 'package:flutter_app/utils/http_util.dart';
import 'package:flutter_app/utils/screen_util.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CommentReplyDetailPage extends StatefulWidget{
  final commentId;
  const CommentReplyDetailPage({Key key, this.commentId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CommentReplyDetailState(commentId);
  }

}

class CommentReplyDetailState extends State<CommentReplyDetailPage>{
  
  final commentId;
  CommentReplyDetailState(this.commentId);

  CommentReplyDetailData mData;

  Future _getData() async{
    var response = await HttpUtil.getInstance().get(Api.GET_COMMENT_REPLY,data:{"comment_id":commentId,"size":"10","page":1});

    mData = CommentReplyDetailData.fromJson(response);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("评论详情",style: TextStyle(color: Colors.black,fontSize: 16),),
        leading: Icon(Icons.arrow_back,color: Colors.black,size: 24,),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(itemBuilder: (BuildContext context,int index){

                if(mData!=null&&mData.data!=null&&index<mData.data.length){
                  return CommentReplyListItem(mData.data[index],index);
                }
            }),
          )
        ],
      ),
    );
  }

}

class CommentReplyListItem extends StatefulWidget {
  final Data itemData;
final index;
  CommentReplyListItem(this.itemData, this.index);

  @override
  State<StatefulWidget> createState() {
    return CommentDetailItemState(itemData,this.index);
  }
}

class CommentDetailItemState extends State<CommentReplyListItem> {
  Data itemData;
  final index;
  double _commentItemPicHeight;

  CommentDetailItemState(this.itemData, this.index);

  @override
  void initState() {
    super.initState();
    _commentItemPicHeight = (ScreenUtil
        .getInstance()
        .screenWidth - 60) / 3;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      color: index == 0?Colors.white:Colors.grey[300],
      padding: index == 0?
      EdgeInsets.only(left: 14, top: 8, right: 14, bottom: 8)
      :EdgeInsets.only(left: 14, top: 8, right: 14, bottom: 8),
      decoration: BoxDecoration(
        color:  index == 0?Colors.white:Colors.grey[100],
          border:
          Border(bottom: BorderSide(width: 1, color: Colors.grey[200]))),

      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  right: 10,
                ),
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.transparent,
                  backgroundImage: CachedNetworkImageProvider(itemData.user.avatar),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    itemData.user.username,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(DateUtil.getDateTitle(itemData.postDate),style: TextStyle(color: Colors.grey,fontSize: 12),),
                  )
                ],
              ),
              Spacer(),
              Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 8),
                  child: Image.asset(
                    "images/ic_like_um.png",
                    width: 15,
                    height: 15,
                  )
              ),
              Text(itemData.upCount.toString()+"个赞",style: TextStyle(fontSize: 12),),

              Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(left: 8),
                  child: Image.asset(
                    "images/ic_dislike_um.png",
                    width: 15,
                    height: 15,
                  )
              ),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 45, bottom: 12),
            child: Text(
              itemData.content,
              style: TextStyle(fontSize: 14, color: Colors.grey[600],),
            ),
          ),

          itemData.children.length > 0 ? Container(
            margin: EdgeInsets.only(left: 45, top: 3),
            height: (itemData.children.length / 3).ceil() *
                _commentItemPicHeight,
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: itemData.children.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    maxCrossAxisExtent: _commentItemPicHeight
                ),

                itemBuilder: (BuildContext context, int index) {
                  if (index < itemData.children.length)
                    return initGridViewItem(itemData.children, index);
                }
            ),
          ) : Container(height: 0,),

//          Container(
//            alignment: Alignment.topLeft,
//            padding: const EdgeInsets.only(left: 45, top: 3),
//            child: itemData.reply.length > 2 ? Text(
//              "查看全部评论", textAlign: TextAlign.left,
//              style: TextStyle(fontSize: 14, color: Colors.blue),) : Container(
//              height: 0,),
//          ),
        ],
      ),

    );
  }

  Widget initGridViewItem (List children,int index){
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return ShowImagePage(children,index);
        }));
      },
      child: Hero(
        tag: "photo_view"+itemData.children[index].hashCode.toString()+"$index",
        child: Container(
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(children[index].cover),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[600],
                    blurRadius: 2,
                    offset: Offset(0,1),
                    spreadRadius: -1
                )
              ]
          ),
//          child: CachedNetworkImage(
//              imageUrl: children[index].cover,
//            placeholder: Image.asset("images/ic_empty_zhihu.png"),
//            fit: BoxFit.cover,
//          ),
        ),
      ),
    );
  }
}