import 'dart:convert' show json;

class TopicBannerData {

  int code;
  String message;
  List<Data> data;

  TopicBannerData.fromParams({this.code, this.message, this.data});

  factory TopicBannerData(jsonStr) => jsonStr == null ? null : jsonStr is String ? new TopicBannerData.fromJson(json.decode(jsonStr)) : new TopicBannerData.fromJson(jsonStr);

  TopicBannerData.fromJson(jsonRes) {
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
  int priority;
  int status;
  String create_time;
  String description;
  String end_time;
  String image_url;
  String key_name;
  String start_time;
  String url;

  Data.fromParams({this.id, this.priority, this.status, this.create_time, this.description, this.end_time, this.image_url, this.key_name, this.start_time, this.url});

  Data.fromJson(jsonRes) {
    id = jsonRes['id'];
    priority = jsonRes['priority'];
    status = jsonRes['status'];
    create_time = jsonRes['create_time'];
    description = jsonRes['description'];
    end_time = jsonRes['end_time'];
    image_url = jsonRes['image_url'];
    key_name = jsonRes['key_name'];
    start_time = jsonRes['start_time'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"priority": $priority,"status": $status,"create_time": ${create_time != null?'${json.encode(create_time)}':'null'},"description": ${description != null?'${json.encode(description)}':'null'},"end_time": ${end_time != null?'${json.encode(end_time)}':'null'},"image_url": ${image_url != null?'${json.encode(image_url)}':'null'},"key_name": ${key_name != null?'${json.encode(key_name)}':'null'},"start_time": ${start_time != null?'${json.encode(start_time)}':'null'},"url": ${url != null?'${json.encode(url)}':'null'}}';
  }
}

