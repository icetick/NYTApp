import 'package:NYT/pojo/getArticlesPojo/legacy.dart';

class Multimedia {
  int rank;
  String subtype;
  String caption;
  String credit;
  String type;
  String url;
  int height;
  int width;
  Legacy legacy;
  String subType;
  String cropName;

  Multimedia(
      {this.rank,
        this.subtype,
        this.caption,
        this.credit,
        this.type,
        this.url,
        this.height,
        this.width,
        this.legacy,
        this.subType,
        this.cropName});

  Multimedia.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    subtype = json['subtype'];
    caption = json['caption'];
    credit = json['credit'];
    type = json['type'];
    url = json['url'];
    height = json['height'];
    width = json['width'];
    legacy =
    (json['legacy'] != null&&json['legacy'].length!=0) ? new Legacy.fromJson(json['legacy']) : null;
    subType = json['subType'];
    cropName = json['crop_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rank'] = this.rank;
    data['subtype'] = this.subtype;
    data['caption'] = this.caption;
    data['credit'] = this.credit;
    data['type'] = this.type;
    data['url'] = this.url;
    data['height'] = this.height;
    data['width'] = this.width;
    if (this.legacy != null) {
      data['legacy'] = this.legacy.toJson();
    }
    data['subType'] = this.subType;
    data['crop_name'] = this.cropName;
    return data;
  }
}