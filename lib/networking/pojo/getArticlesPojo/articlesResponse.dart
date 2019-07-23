import 'package:NYT/networking/pojo/getArticlesPojo/NYTResponse.dart';

class ArticlesResponse {
  final String copyright;
  final NYTResponse response;

  ArticlesResponse({this.copyright, this.response});

  factory ArticlesResponse.fromJson(Map<String, dynamic> json) {
    var res = NYTResponse.fromJson(json['response']);
    return ArticlesResponse(copyright: json['copyright'], response: res);
  }
}