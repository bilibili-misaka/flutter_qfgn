import 'package:flutter/material.dart';
import 'package:flutter_app/model/topic_classify_model.dart';
import 'dart:ui' as ui;

class PersonalListItem extends StatelessWidget {
  final icon;
  final text;
  final plugWidget;
  final optionList;

  PersonalListItem(this.optionList)
      : icon = optionList["icon"],
        text = optionList["text"],
        plugWidget = optionList["plugWidget"] == null ? Spacer() : optionList["plugWidget"];

  @override
  Widget build(BuildContext context) {
    if(icon==null&&text==null){
      return Padding(padding: EdgeInsets.only(bottom: 10));
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
//        border: Border(
//          bottom: BorderSide(color: Colors.grey[200],width: 1,)
//        )
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20, right: 5),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                icon,
                width: 18,
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              Spacer(),
              plugWidget,
              IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[500],
                    size: 16,
                  ),
                  onPressed: () {})
            ],
          ),
          Container(
            color: Colors.grey[200],
            height: 1,
            margin: EdgeInsets.only(left: 30),
          )
        ],
      ),
    );
  }
}
