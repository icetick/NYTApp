import 'package:NYT/pojo/getArticlesPojo/person.dart';

class Byline {
  String original;
  List<Person> person;
  String organization;

  Byline({this.original, this.person, this.organization});

  Byline.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    if (json['person'] != null) {
      person = new List<Person>();
      json['person'].forEach((v) {
        person.add(Person.fromJson(v));
      });
    }
    organization = json['organization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original'] = this.original;
    if (this.person != null) {
      data['person'] = this.person.map((v) =>v).toList();
    }
    data['organization'] = this.organization;
    return data;
  }
}