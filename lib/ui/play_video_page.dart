import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideoPage extends StatefulWidget{

  final String title;
  final String video_url;
  final double video_ratio;
  PlayVideoPage(this.title,this.video_url,this.video_ratio);

  @override
  State<StatefulWidget> createState() {
    return PlayVideoPageState(title,video_url,video_ratio);
  }


}

class PlayVideoPageState extends State<PlayVideoPage>{

  final String title;
  final String video_url;
  final double video_ratio;
  VideoPlayerController _videoPlayerController;

  PlayVideoPageState(this.title,this.video_url,this.video_ratio);

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(video_url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Container(width: 240,child: Text(title,style: TextStyle(color: Colors.white,),maxLines: 1,)),
        backgroundColor: Colors.transparent,
      ),
      body: Chewie(
        _videoPlayerController,
        autoPlay: true,
        looping: false,
        aspectRatio: video_ratio,
        autoInitialize: true,
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

}