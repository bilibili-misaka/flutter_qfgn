import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/home_page_recommend_model.dart';
import 'package:flutter_app/ui/homepage/comm_content_detail_page.dart';

class TopicGuessLikeItem extends StatefulWidget {
  Data mItemData;

  TopicGuessLikeItem(this.mItemData);

  @override
  State<StatefulWidget> createState() {
    return TopicGuessLikeItemState(mItemData);
  }
}

class TopicGuessLikeItemState extends State<TopicGuessLikeItem> {
  Data mItemData;

//  double _width = 200;
//  double _height = 165;

//  double offset;

  TopicGuessLikeItemState(this.mItemData);

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return CommContentDetailPage(mItemData: mItemData,);
        }));
      },
      child: Container(
//        width: _width,
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(mItemData.children!=null&&mItemData.children.length>0
                    ? mItemData.children[0].cover
                    : mItemData.category.cover),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[600],
                    blurRadius: 8,
                    offset: Offset(0, 1),
                    spreadRadius: -1)
              ]
          ),
          child: Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            height: 35,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[600],
                      blurRadius: 4,
                      offset: Offset(0, 1),
                      spreadRadius: -1)
                ]),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  mItemData.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                )),
                Container(
                    height: 24,
                    width: 50,
                    child: Text(
                      "PINK",
                      style: TextStyle(color: Colors.white,letterSpacing: 1.2,fontSize: 12,fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.pink[300],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(2.0),
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[600],
                              blurRadius: 4,
                              offset: Offset(0, 1),
                              spreadRadius: -1)
                        ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
