import 'package:flutter_app/model/home_page_recommend_model.dart';

class CommentDetailData {
  int code;
  String message;
  Data data;

  CommentDetailData({this.code, this.message, this.data});

  CommentDetailData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int count;
  List<CommentList> list;

  Data({this.count, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = new List<CommentList>();
      json['list'].forEach((v) {
        list.add(new CommentList.fromJson(v));
      });
    }else{
      list = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentList {
  int id;
  String type;
  Comment comment;
  User user;
  String ownerUserUuid;
  TargetUser targetUser;
  int status;
  String tieziUuid;
  String content;
  int postDate;
  bool isKami;
  List<Children> children;
  int commentCount;
  bool isUp;
  bool isDown;
  int upCount;
  int downCount;
  List<CommentList> reply;
//  Null post;

  CommentList(
      {this.id,
        this.type,
        this.comment,
        this.user,
        this.ownerUserUuid,
        this.targetUser,
        this.status,
        this.tieziUuid,
        this.content,
        this.postDate,
        this.isKami,
        this.children,
        this.commentCount,
        this.isUp,
        this.isDown,
        this.upCount,
        this.downCount,
        this.reply,
//        this.post
      });

  CommentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    comment =
    json['comment'] != null ? new Comment.fromJson(json['comment']) : Comment();
    user = json['user'] != null ? new User.fromJson(json['user']) : User();
    ownerUserUuid = json['owner_user_uuid'];
    targetUser = json['target_user'] != null
        ? new TargetUser.fromJson(json['target_user'])
        : null;
    status = json['status'];
    tieziUuid = json['tiezi_uuid'];
    content = json['content'];
    postDate = json['post_date'];
    isKami = json['is_kami'];
    if (json['children'] != null) {
      children = List<Children>();
      json['children'].forEach((v) {
        children.add(new Children.fromJson(v));
      });
    }else{
      children = [];
    }
    commentCount = json['comment_count'];
    isUp = json['is_up'];
    isDown = json['is_down'];
    upCount = json['up_count'];
    downCount = json['down_count'];
//    reply = json['reply'];
    if (json['reply'] != null) {
      reply = new List<CommentList>();
      json['reply'].forEach((v) {
        reply.add(new CommentList.fromJson(v));
      });
    }else{
      reply = [];
    }
//    post = json['post'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.comment != null) {
      data['comment'] = this.comment.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['owner_user_uuid'] = this.ownerUserUuid;
    if (this.targetUser != null) {
      data['target_user'] = this.targetUser.toJson();
    }
    data['status'] = this.status;
    data['tiezi_uuid'] = this.tieziUuid;
    data['content'] = this.content;
    data['post_date'] = this.postDate;
    data['is_kami'] = this.isKami;
//    if (this.children != null) {
//      data['children'] = this.children.map((v) => v.toJson()).toList();
//    }
    data['comment_count'] = this.commentCount;
    data['is_up'] = this.isUp;
    data['is_down'] = this.isDown;
    data['up_count'] = this.upCount;
    data['down_count'] = this.downCount;
    data['reply'] = this.reply;
//    data['post'] = this.post;
    return data;
  }
}

class Comment {
  int id;
  String type;
  Comment comment;
  User user;
  String ownerUserUuid;
  TargetUser targetUser;
  int status;
  String tieziUuid;
  String content;
  int postDate;
  bool isKami;
//  null children;
  int commentCount;
  bool isUp;
  bool isDown;
  int upCount;
  int downCount;
  List<CommentList> reply;
//  Null post;

  Comment(
      {this.id,
        this.type,
        this.comment,
        this.user,
        this.ownerUserUuid,
        this.targetUser,
        this.status,
        this.tieziUuid,
        this.content,
        this.postDate,
        this.isKami,
//        this.children,
        this.commentCount,
        this.isUp,
        this.isDown,
        this.upCount,
        this.downCount,
        this.reply,
//        this.post
      }
        );

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];

    if(comment != null){
      comment = json['comment'];
    }else{
      comment = Comment();
    }
    if(user != null){
      user = json['user'];
    }else{
      user = User();
    }
    ownerUserUuid = json['owner_user_uuid'];
    if(targetUser!=null){
      targetUser = json['target_user'];
    }

    status = json['status'];
    tieziUuid = json['tiezi_uuid'];
    content = json['content'];
    postDate = json['post_date'];
    isKami = json['is_kami'];
//    children = json['children'];
    commentCount = json['comment_count'];
    isUp = json['is_up'];
    isDown = json['is_down'];
    upCount = json['up_count'];
    downCount = json['down_count'];
//    reply = json['reply'];
    if (json['reply'] != null) {
      reply = new List<CommentList>();
      json['reply'].forEach((v) {
        reply.add(new CommentList.fromJson(v));
      });
    }else{
      reply = [];
    }
//    post = json['post'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['comment'] = this.comment;
    data['user'] = this.user;
    data['owner_user_uuid'] = this.ownerUserUuid;
    data['target_user'] = this.targetUser;
    data['status'] = this.status;
    data['tiezi_uuid'] = this.tieziUuid;
    data['content'] = this.content;
    data['post_date'] = this.postDate;
    data['is_kami'] = this.isKami;
//    data['children'] = this.children;
    data['comment_count'] = this.commentCount;
    data['is_up'] = this.isUp;
    data['is_down'] = this.isDown;
    data['up_count'] = this.upCount;
    data['down_count'] = this.downCount;
    data['reply'] = this.reply;
//    data['post'] = this.post;
    return data;
  }
}

class User {
  int id;
  String uuid;
  String username;
  int sex;
  String birthday;
  String avatar;
  String signature;
  int createDate;
  String phoneNumber;
  int userState;
  String userCover;
  int fansCount;
  int followCount;
  int likeCount;
  int privilegeId;
  bool isFollow;

  User(
      {this.id,
        this.uuid,
        this.username,
        this.sex,
        this.birthday,
        this.avatar,
        this.signature,
        this.createDate,
        this.phoneNumber,
        this.userState,
        this.userCover,
        this.fansCount,
        this.followCount,
        this.likeCount,
        this.privilegeId,
        this.isFollow});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    username = json['username'];
    sex = json['sex'];
    birthday = json['birthday'];
    avatar = json['avatar'];
    signature = json['signature'];
    createDate = json['create_date'];
    phoneNumber = json['phone_number'];
    userState = json['user_state'];
    userCover = json['user_cover'];
    fansCount = json['fans_count'];
    followCount = json['follow_count'];
    likeCount = json['like_count'];
    privilegeId = json['privilege_id'];
    isFollow = json['is_follow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['username'] = this.username;
    data['sex'] = this.sex;
    data['birthday'] = this.birthday;
    data['avatar'] = this.avatar;
    data['signature'] = this.signature;
    data['create_date'] = this.createDate;
    data['phone_number'] = this.phoneNumber;
    data['user_state'] = this.userState;
    data['user_cover'] = this.userCover;
    data['fans_count'] = this.fansCount;
    data['follow_count'] = this.followCount;
    data['like_count'] = this.likeCount;
    data['privilege_id'] = this.privilegeId;
    data['is_follow'] = this.isFollow;
    return data;
  }
}

class TargetUser {
  int id;
  String uuid;
  String username;
  int sex;
  String birthday;
  String avatar;
  String signature;
  int createDate;
  String phoneNumber;
  int userState;
  String userCover;
  int fansCount;
  int followCount;
  int likeCount;
  int privilegeId;
  bool isFollow;

  TargetUser(
      {this.id,
        this.uuid,
        this.username,
        this.sex,
        this.birthday,
        this.avatar,
        this.signature,
        this.createDate,
        this.phoneNumber,
        this.userState,
        this.userCover,
        this.fansCount,
        this.followCount,
        this.likeCount,
        this.privilegeId,
        this.isFollow});

  TargetUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    username = json['username'];
    sex = json['sex'];
    birthday = json['birthday'];
    avatar = json['avatar'];
    signature = json['signature'];
    createDate = json['create_date'];
    phoneNumber = json['phone_number'];
    userState = json['user_state'];
    userCover = json['user_cover'];
    fansCount = json['fans_count'];
    followCount = json['follow_count'];
    likeCount = json['like_count'];
    privilegeId = json['privilege_id'];
    isFollow = json['is_follow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['username'] = this.username;
    data['sex'] = this.sex;
    data['birthday'] = this.birthday;
    data['avatar'] = this.avatar;
    data['signature'] = this.signature;
    data['create_date'] = this.createDate;
    data['phone_number'] = this.phoneNumber;
    data['user_state'] = this.userState;
    data['user_cover'] = this.userCover;
    data['fans_count'] = this.fansCount;
    data['follow_count'] = this.followCount;
    data['like_count'] = this.likeCount;
    data['privilege_id'] = this.privilegeId;
    data['is_follow'] = this.isFollow;
    return data;
  }
}
