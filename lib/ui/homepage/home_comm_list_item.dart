import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/customview/bottom_menu_dialog.dart';
import 'package:flutter_app/model/home_page_recommend_model.dart';
import 'package:flutter_app/ui/homepage/comm_content_detail_page.dart';
import 'package:flutter_app/ui/play_video_page.dart';
import 'package:flutter_app/ui/show_image_page.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CommListItem extends StatefulWidget{

  Data mItemData;
  final viewType;
  CommListItem(this.mItemData,{Key key ,viewType}):this.viewType=viewType==null?0:viewType,super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CommListItemState(mItemData,viewType);
  }
  
}

class CommListItemState extends State<CommListItem> {
  Data mItemData;
  final viewType;

  CommListItemState(this.mItemData,this.viewType);
  double itemHeight;
//  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
//    _videoPlayerController = VideoPlayerController.network(mItemData.children[0].url);
//    _videoPlayerController.addListener((){
//      _videoPlayerController.pause();
//      setState(() {
//      });
//    });
  }



  Widget initContentView(){
    if(mItemData==null|| mItemData.children==null||mItemData.children.length<1){
      return Container(height: 0,);
    }
    if(mItemData.type=="video"){
//      return Container(
//        height: 200,
//        child: Chewie(
//          new VideoPlayerController.network(mItemData.children[0].url),
//          autoPlay: false,
//          looping: false,
//
//        ),
//      );
        return Container(
          height: 200.0,
          width: itemHeight - 12,
          alignment: Alignment.center,
          decoration: BoxDecoration(
//            image: DecorationImage(
//                image: CachedNetworkImageProvider(mItemData.children[0].cover)
//            ),
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[600],
                    blurRadius: 8,
                    offset: Offset(0,1),
                    spreadRadius: 0
                )
              ]
          ),

          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                child: CachedNetworkImage(
                  imageUrl: mItemData.children[0].cover,
//                  placeholder: Image.asset("images/ic_empty_zhihu.png"),
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(iconSize: 60,icon: ImageIcon(AssetImage("images/ic_play_circle_outline_white_48dp.png"),color: Colors.white ,),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    int width = mItemData.children[0].width;
                    int height = mItemData.children[0].height;
                    double ratio = width>height?width/height:height/width;
                    return PlayVideoPage(mItemData.description,mItemData.children[0].url,ratio);
                  }));
                },),
            ],
          ),
        );
    }else{
      if(mItemData.children.length>1){
        double height;
        double item;
        if(mItemData.children.length == 2 || mItemData.children.length == 4){
          item = (itemHeight-8)/2;
          height = (mItemData.children.length/2) * (item+4);
        }else{
          item = (itemHeight-12)/3;
          height = (mItemData.children.length/3).ceil() * (item+4);
        }
//        double height = (mItemData.children.length/3).ceil() * (itemHeight + 8);
        return Container(
          height: height,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: item + 8,
              ),
              itemCount: mItemData.children.length,
              itemBuilder: (BuildContext context,int index){
                if(index<mItemData.children.length)
                return initGridViewItem(mItemData.children,index);
              }
          ),
        );

      }else{
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return ShowImagePage(mItemData.children,0);
            }));
          },
          child: Hero(
            tag: "photo_view"+mItemData.hashCode.toString()+"0",
            child: Container(
              height: 200.0,
              width: itemHeight - 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[600],
                        blurRadius: 6,
                        offset: Offset(0,1),
                        spreadRadius: -2
                    )
                  ]
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                child: CachedNetworkImage(
                  imageUrl: mItemData.children[0].cover,
//                  placeholder: Image.asset("images/ic_empty_zhihu.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      }
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
        tag: "photo_view"+mItemData.children[index].hashCode.toString()+"$index",
        child: Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[500],
                    blurRadius: 2,
                    offset: Offset(0,1),
                    spreadRadius: 0
                )
              ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            child: CachedNetworkImage(
              imageUrl: children[index].cover,
//              placeholder: Image.asset("images/ic_empty_zhihu.png"),
              fadeInDuration: Duration(milliseconds: 200),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    itemHeight = (MediaQuery.of(context).size.width - 12*2);
    return GestureDetector(
      onTap: (){
        if(viewType==0)
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return CommContentDetailPage(mItemData: mItemData,);
        }));
      },
      child: Container(
        padding: const EdgeInsets.only(top: 0,left: 12,right: 12),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(mItemData.user.avatar,),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[700],
                            blurRadius: 4,
                            offset: Offset(0,1),
                            spreadRadius: -2
                        )
                      ]
                  ),
                ),

                Expanded(
                  child: Padding(padding: EdgeInsets.only(left: 12),
                    child: Text(mItemData.user.username,style: TextStyle(fontSize: 13,color: Colors.grey[600]),textAlign: TextAlign.left,),
                  ),
                ),
                InkWell(
                  child:
                  viewType==0?
                  IconButton(icon: Image.asset("images/ic_more_horiz_black_24dp.png",width: 20,color: Colors.grey,), onPressed: (){
                    showDialog(
                        context: context,
                      builder: (context){
                          return BottomMenuDialog();
                      },
                      barrierDismissible: false
                    );
                  })
                  :Container(
                    padding: EdgeInsets.only(left: 8,right: 8,top: 1,bottom: 1),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.grey[400],width: 1,)
                    ),
                    child: Text("+关注",style: TextStyle(color: Colors.grey[400],fontSize: 12),),
                  ),
                  onTap: (){

                  },
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 12,bottom: 12),
              alignment: Alignment.topLeft,
              child: Text(mItemData.description,style: TextStyle(fontSize: 14,color: Colors.grey[800],),
              ),
            ),

            initContentView(),

            Row(
              children: <Widget>[
                Expanded(
                    child: Text("#"+mItemData.category_name,style: TextStyle(color: Theme.of(context).accentColor,fontSize: 12),)
                ),

                IconButton(icon: Image.asset("images/ic_card_share.png",height: 20,color: Colors.grey[600]), onPressed: (){}),

                IconButton(icon: Image.asset("images/ic_card_post.png",height: 20,color: Colors.grey[600]), onPressed: (){}),

                Text(mItemData.comment_count.toString(),style: TextStyle(fontSize: 11,color: Colors.grey),),

                IconButton(icon: Image.asset("images/ic_like_um.png",height: 18,color: Colors.grey[600]), onPressed: (){}),

                Text(mItemData.up_count.toString(),style: TextStyle(fontSize: 11,color: Colors.grey)),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
//    _videoPlayerController.dispose();
  }
}