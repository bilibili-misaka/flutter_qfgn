
class UserListData {
  int code;
  String message;
  bool success;
  List<User> data;

  UserListData({this.code, this.message, this.success, this.data});

  UserListData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    success = json['success'];
    if (json['data'] != null) {
      data = new List<User>();
      json['data'].forEach((v) {
        data.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int id;
  String uuid;
  String username;
  String avatar;
  int sex;
  String birthday;
  String signature;
  int userState;
  int followCount;
  int fansCount;
  int likeCount;
  int isFollow;

  User(
      {this.id,
        this.uuid,
        this.username,
        this.avatar,
        this.sex,
        this.birthday,
        this.signature,
        this.userState,
        this.followCount,
        this.fansCount,
        this.likeCount,
        this.isFollow});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    username = json['username'];
    avatar = json['avatar'];
    sex = json['sex'];
    birthday = json['birthday'];
    signature = json['signature'];
    userState = json['userState'];
    followCount = json['followCount'];
    fansCount = json['fansCount'];
    likeCount = json['likeCount'];
    isFollow = json['isFollow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['sex'] = this.sex;
    data['birthday'] = this.birthday;
    data['signature'] = this.signature;
    data['userState'] = this.userState;
    data['followCount'] = this.followCount;
    data['fansCount'] = this.fansCount;
    data['likeCount'] = this.likeCount;
    data['isFollow'] = this.isFollow;
    return data;
  }
}
