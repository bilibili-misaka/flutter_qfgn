import 'package:flutter/material.dart';
import 'package:flutter_app/model/home_page_recommend_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ShowImagePage extends StatefulWidget {
  List<Children> mList;
  int index;

  ShowImagePage(this.mList, this.index);

  @override
  State<StatefulWidget> createState() {
    return ShowImagePageState(mList, index);
  }
}

class ShowImagePageState extends State<ShowImagePage> {
  List<Children> mList;
  int index;

  ShowImagePageState(this.mList, this.index);

  String page;
  List<PhotoViewGalleryPageOptions> mPhotoViewList = [];

  _initImageView() {
    for (int i = 0; i < mList.length; i++) {
      mPhotoViewList.add(
        PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(mList[i].url),
          heroTag: "photo_view"+mList[i].hashCode.toString()+"$i",
        ),
      );
    }
    return mPhotoViewList;
  }

  @override
  void initState() {
    super.initState();
    _initImageView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: PhotoViewGallery(
//                enableRotation: true,
                pageController: PageController(
                  initialPage: index,
                ),
                pageOptions: mPhotoViewList,
                onPageChanged: (index) {
                  this.index = index;
                  setState(() {});
                },
                backgroundDecoration: BoxDecoration(color: Colors.black87),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.all(12),
                  child: Text(
                    (index + 1).toString() + "/" + mList.length.toString(),
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )),
              Expanded(
                child: Text(""),
              ),
              IconButton(
                  icon: Icon(
                    Icons.file_download,
                    color: Colors.white,
                  ),
                  onPressed: () {})
            ],
          )
        ],
      ),
    );
  }
}
