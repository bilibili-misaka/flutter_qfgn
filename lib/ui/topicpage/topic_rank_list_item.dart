import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/topic_classify_model.dart';
import 'dart:ui' as ui;

import 'package:flutter_app/ui/topicpage/topic_category_page.dart';

class TopicListItem extends StatelessWidget{

  final mItemData;

  TopicListItem({Key key, this.mItemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
          return TopicCategoryPage(mTopData: mItemData,);
        }));
      },
      child: Stack(
        alignment: Alignment.center,
          children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(mItemData.cover),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                ),
//              boxShadow: [
//                BoxShadow(
//                    color: Colors.grey[600],
//                    blurRadius: 8,
//                    offset: Offset(0, 1),
//                    spreadRadius: -1)
//              ]
            ),
          ),

       BackdropFilter(
         filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 14,right: 8,),
                decoration: BoxDecoration(
                color: Colors.transparent.withOpacity(0.6),
                borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.transparent,
                          blurRadius: 0,
                          offset: Offset(0, 0),
                          spreadRadius: -2)
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                    width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(mItemData.cover),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(6.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[600],
                                blurRadius: 8,
                                offset: Offset(0, 1),
                                spreadRadius: -1)
                          ]),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(mItemData.name,style: TextStyle(color: Colors.white,fontSize: 16),),
                          Text("今日发帖量 "+mItemData.post_count.toString()+" 次",style: TextStyle(color: Colors.white,fontSize: 12),),
                        ],
                      ),
                    ),
                    IconButton(icon: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 16,), onPressed: (){

                    })
                  ],
                ),

              ),
            ),
          ],
      ),
    );
  }

}