import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/comment_detail_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/model/home_page_recommend_model.dart' as homedata;
import 'package:flutter_app/ui/homepage/comment_reply_detail_page.dart';
import 'package:flutter_app/ui/homepage/home_comm_list_item.dart';
import 'package:flutter_app/ui/show_image_page.dart';
import 'package:flutter_app/utils/date_util.dart';
import 'package:flutter_app/utils/screen_util.dart';

class CommContentDetailPage extends StatefulWidget {
  final homedata.Data mItemData;

  CommContentDetailPage({Key key, this.mItemData}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return CommContentDetailState(mItemData);
  }
}

class CommContentDetailState extends State<CommContentDetailPage> {
  homedata.Data mItemData;
  CommentDetailData mData;

  CommContentDetailState(this.mItemData);

  Future _getData() async {
    Dio dio = new Dio();
    dio.options.baseUrl = "http://go.tongmoe.com";
    Response response = await dio.get("/v1/posts/comments", data: {
//      "post_uuid": mItemData.upuuid,post_uuid=bD1mMRQzmx
//    "post_uuid":"bD1mMRQzmx",=dBNkXMlDw2
//      "post_uuid":"bq7y97kWE3",
      "post_uuid":mItemData.uuid,
      "sort": "upCount",
      "size": "10",
      "page": "1"
    });
    mData = CommentDetailData.fromJson(response.data);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          DateUtil.getDateTitle(mItemData.post_date*1000),
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: null),
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                "images/ic_more_horiz_black_24dp.png",
                height: 20,
                width: 20,
              ),
              onPressed: null)
        ],
      ),
      body: Container(
//          padding: EdgeInsets.all(12),
        child: ListView.builder(itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return CommListItem(mItemData,viewType: 1,);
          } else if (index == 1) {
            return Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 12),
                    height: 1,
                    color: Colors.grey[400].withOpacity(0.7),
                  ),
                ),
                Container(
                    transform: Matrix4.translationValues(0, -4.2, 0),
                    child: Image.asset(
                      "images/line_horiz.png",
                      width: 24,
                      height: 24,
                    )),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 12),
                    height: 1,
                    color: Colors.grey[400].withOpacity(0.7),
                  ),
                ),
              ],
            );
          } else if (mData!=null&&mData.data!=null){

            if(index < mData.data.list.length + 2){

              return CommentDetailListItem(mData.data.list[index - 2]);

            }else if(index == mData.data.list.length+2){
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 14,bottom: 65),
                  child: Text("已加载全部",style: TextStyle(color: Colors.grey[600]),),
                );
              }
          }
        }),
      ),
    );
  }
}

class CommentDetailListItem extends StatefulWidget {
  CommentList itemData;

  CommentDetailListItem(this.itemData);

  @override
  State<StatefulWidget> createState() {
    return CommentDetailItemState(itemData);
  }
}

class CommentDetailItemState extends State<CommentDetailListItem> {
  CommentList itemData;
  double _commentItemPicHeight;

  CommentDetailItemState(this.itemData);

  @override
  void initState() {
    super.initState();
    _commentItemPicHeight = (ScreenUtil.getInstance().screenWidth - 60)/3;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, top: 8, right: 14, bottom: 8),
      decoration: BoxDecoration(
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
                  radius: 16,
                  backgroundImage: NetworkImage(itemData.user.avatar),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  itemData.user.username,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              Spacer(),
              Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(left: 6),
                  child: Image.asset(
                    "images/ic_like_um.png",
                    width: 15,
                    height: 15,
                  )),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left:45,bottom: 12),
            child: Text(
              itemData.content,
              style: TextStyle(fontSize: 14, color: Colors.grey[600],),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left:45,),
            child: Row(
              children: <Widget>[
                Text(
                  "10分钟前",
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    "回复",
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),

    itemData.children.length>0?Container(
      margin: EdgeInsets.only(left: 45,top: 3),
      height: (itemData.children.length/3).ceil()*_commentItemPicHeight,
            child:  GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemData.children.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  maxCrossAxisExtent: _commentItemPicHeight
                ),

                itemBuilder: (BuildContext context,int index){
                  if(index<itemData.children.length)
                    return initGridViewItem(itemData.children,index);
                }
            ),
          ):Container(height: 0,),

          itemData.reply.length>0?_getItemCommentView(0):Container(height: 0,),
          itemData.reply.length>1?_getItemCommentView(1):Container(height: 0,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return CommentReplyDetailPage(commentId: itemData.id,);
              }));
            },

            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 45,top: 3),
              child: itemData.reply.length>2?Text("查看全部评论",textAlign: TextAlign.left,style: TextStyle(fontSize:14,color: Colors.blue),):Container(height: 0,),
            ),
          ),
        ],
      ),

    );
  }

  Widget _getItemCommentView(int index){
    if(itemData.reply[index]!=null)
     return Container(
       padding: const EdgeInsets.only(left: 45,top: 5),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                right: 10,
              ),
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.transparent,
                backgroundImage:
                itemData.reply[index].user.avatar==null?AssetImage("images/default_avatar.png")
                :CachedNetworkImageProvider(itemData.reply[index].user.avatar),
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.only(right: 6,bottom: 2),
//              child: Text(
//                itemData.reply[index].user.username??"",
//                style: TextStyle(fontSize: 12, color: Colors.black),
//                overflow: TextOverflow.ellipsis,
//                maxLines: 2,
//              ),
//            ),
//            Expanded(
//              child: Text(
//                itemData.reply[index].content,
//                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
//                  overflow: TextOverflow.ellipsis,
//                  maxLines: 2,
//              ),
//            ),

            Expanded(
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: itemData.reply[index].user.username+"  ",
                    style: TextStyle(color: Colors.black,fontSize: 13,),
                  ),

                  _dealRichTextContent(itemData.reply[index].content)

                ]
              ),
            ),
          ),
          ],
        ),
     );
  }

  TextSpan _dealRichTextContent(String text){

    int firstIndex = text.indexOf("@");
    int afterIndex = text.indexOf("：");
    if(afterIndex>firstIndex){
      List<TextSpan> richTexts = [];
      richTexts.add(TextSpan(
        text: text.substring(0,firstIndex)
      ));
      richTexts.add(
        TextSpan(
          text: text.substring(firstIndex,afterIndex),
          style: TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()..onTap=(){

        }
        )
      );
      richTexts.add(
        TextSpan(
          text: text.substring(afterIndex,text.length)
        )
      );
      return TextSpan(
        style: TextStyle(color: Colors.grey,fontSize: 13),
          children: richTexts
      );
    }else{
      return TextSpan(
          text: text,
          style: TextStyle(color: Colors.grey,fontSize: 13),
      );
    }
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
