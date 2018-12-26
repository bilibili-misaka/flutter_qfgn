import 'dart:convert' show json;

class TopicClassifyData {

  int code;
  String message;
  List<Data> data;

  TopicClassifyData.fromParams({this.code, this.message, this.data});

  factory TopicClassifyData(jsonStr) => jsonStr == null ? null : jsonStr is String ? new TopicClassifyData.fromJson(json.decode(jsonStr)) : new TopicClassifyData.fromJson(jsonStr);

  TopicClassifyData.fromJson(jsonRes) {
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

  Data.fromParams({this.id, this.parent_id, this.post_count, this.post_date, this.priority, this.state, this.is_follow, this.background_img, this.cover, this.description, this.designation, this.founder, this.name});

  Data.fromJson(jsonRes) {
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

