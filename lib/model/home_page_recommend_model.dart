import 'dart:convert' show json;

class HomeRecommendData {

  int code;
  String message;
  List<Data> data;

  HomeRecommendData.fromParams({this.code, this.message, this.data});

  factory HomeRecommendData(jsonStr) => jsonStr == null ? null : jsonStr is String ? new HomeRecommendData.fromJson(json.decode(jsonStr)) : new HomeRecommendData.fromJson(jsonStr);

  HomeRecommendData.fromJson(jsonRes) {
    code = jsonRes['code'];
    message = jsonRes['message'];
    data = jsonRes['data'] == null ? null : [];

    for (var dataItem in data == null ? [] : jsonRes['data']){
      data.add(dataItem == null ? null : new Data.fromJson(dataItem));
    }
  }

  @override
  String toString() {
    return '{"code": $code,"message": ${message != null?'${json.encode(message)}':'null'},"data": $data}';
  }
}

class Data {

  int comment_count;
  int down_count;
  int id;
  int post_date;
  int state;
  int up_count;
  bool collected;
  bool is_choice;
  bool is_down;
  bool is_up;
  String category_name;
  String description;
  String share_url;
  String type;
  String upuuid;
  String uuid;
  List<Children> children;
  Category category;
  User user;

  Data.fromParams({this.comment_count, this.down_count, this.id, this.post_date, this.state, this.up_count, this.collected, this.is_choice, this.is_down, this.is_up, this.category_name, this.description, this.share_url, this.type, this.upuuid, this.uuid, this.children, this.category, this.user});

  Data.fromJson(jsonRes) {
    comment_count = jsonRes['comment_count'];
    down_count = jsonRes['down_count'];
    id = jsonRes['id'];
    post_date = jsonRes['post_date'];
    state = jsonRes['state'];
    up_count = jsonRes['up_count'];
    collected = jsonRes['collected'];
    is_choice = jsonRes['is_choice'];
    is_down = jsonRes['is_down'];
    is_up = jsonRes['is_up'];
    category_name = jsonRes['category_name'];
    description = jsonRes['description'];
    share_url = jsonRes['share_url'];
    type = jsonRes['type'];
    upuuid = jsonRes['upuuid'];
    uuid = jsonRes['uuid'];
    children = jsonRes['children'] == null ? null : [];

    for (var childrenItem in children == null ? [] : jsonRes['children']){
      children.add(childrenItem == null ? null : new Children.fromJson(childrenItem));
    }

    category = jsonRes['category'] == null ? null : new Category.fromJson(jsonRes['category']);
    user = jsonRes['user'] == null ? null : new User.fromJson(jsonRes['user']);
  }

  @override
  String toString() {
    return '{"comment_count": $comment_count,"down_count": $down_count,"id": $id,"post_date": $post_date,"state": $state,"up_count": $up_count,"collected": $collected,"is_choice": $is_choice,"is_down": $is_down,"is_up": $is_up,"category_name": ${category_name != null?'${json.encode(category_name)}':'null'},"description": ${description != null?'${json.encode(description)}':'null'},"share_url": ${share_url != null?'${json.encode(share_url)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'},"upuuid": ${upuuid != null?'${json.encode(upuuid)}':'null'},"uuid": ${uuid != null?'${json.encode(uuid)}':'null'},"children": $children,"category": $category,"user": $user}';
  }
}

class User {

  int create_date;
  int fans_count;
  int follow_count;
  int id;
  int like_count;
  int privilege_id;
  int sex;
  int user_state;
  bool is_follow;
  String avatar;
  String birthday;
  String phone_number;
  String signature;
  String user_cover;
  String username;
  String uuid;

  User.fromParams({this.create_date, this.fans_count, this.follow_count, this.id, this.like_count, this.privilege_id, this.sex, this.user_state, this.is_follow, this.avatar, this.birthday, this.phone_number, this.signature, this.user_cover, this.username, this.uuid});

  User.fromJson(jsonRes) {
    create_date = jsonRes['create_date'];
    fans_count = jsonRes['fans_count'];
    follow_count = jsonRes['follow_count'];
    id = jsonRes['id'];
    like_count = jsonRes['like_count'];
    privilege_id = jsonRes['privilege_id'];
    sex = jsonRes['sex'];
    user_state = jsonRes['user_state'];
    is_follow = jsonRes['is_follow'];
    avatar = jsonRes['avatar'];
    birthday = jsonRes['birthday'];
    phone_number = jsonRes['phone_number'];
    signature = jsonRes['signature'];
    user_cover = jsonRes['user_cover'];
    username = jsonRes['username'];
    uuid = jsonRes['uuid'];
  }

  @override
  String toString() {
    return '{"create_date": $create_date,"fans_count": $fans_count,"follow_count": $follow_count,"id": $id,"like_count": $like_count,"privilege_id": $privilege_id,"sex": $sex,"user_state": $user_state,"is_follow": $is_follow,"avatar": ${avatar != null?'${json.encode(avatar)}':'null'},"birthday": ${birthday != null?'${json.encode(birthday)}':'null'},"phone_number": ${phone_number != null?'${json.encode(phone_number)}':'null'},"signature": ${signature != null?'${json.encode(signature)}':'null'},"user_cover": ${user_cover != null?'${json.encode(user_cover)}':'null'},"username": ${username != null?'${json.encode(username)}':'null'},"uuid": ${uuid != null?'${json.encode(uuid)}':'null'}}';
  }
}

class Category {

  int id;
  int parent_id;
  int post_count;
  int post_date;
  int priority;
  int state;
  bool is_follow;
  String background_img;
  String cover;
  String description;
  String designation;
  String founder;
  String name;

  Category.fromParams({this.id, this.parent_id, this.post_count, this.post_date, this.priority, this.state, this.is_follow, this.background_img, this.cover, this.description, this.designation, this.founder, this.name});

  Category.fromJson(jsonRes) {
    id = jsonRes['id'];
    parent_id = jsonRes['parent_id'];
    post_count = jsonRes['post_count'];
    post_date = jsonRes['post_date'];
    priority = jsonRes['priority'];
    state = jsonRes['state'];
    is_follow = jsonRes['is_follow'];
    background_img = jsonRes['background_img'];
    cover = jsonRes['cover'];
    description = jsonRes['description'];
    designation = jsonRes['designation'];
    founder = jsonRes['founder'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"id": $id,"parent_id": $parent_id,"post_count": $post_count,"post_date": $post_date,"priority": $priority,"state": $state,"is_follow": $is_follow,"background_img": ${background_img != null?'${json.encode(background_img)}':'null'},"cover": ${cover != null?'${json.encode(cover)}':'null'},"description": ${description != null?'${json.encode(description)}':'null'},"designation": ${designation != null?'${json.encode(designation)}':'null'},"founder": ${founder != null?'${json.encode(founder)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'}}';
  }
}

class Children {

  int height;
  int video_time;
  int width;
  String cover;
  String url;

  Children.fromParams({this.height, this.video_time, this.width, this.cover, this.url});

  Children.fromJson(jsonRes) {
    height = jsonRes['height'];
    video_time = jsonRes['video_time'];
    width = jsonRes['width'];
    cover = jsonRes['cover'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"height": $height,"video_time": $video_time,"width": $width,"cover": ${cover != null?'${json.encode(cover)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}

