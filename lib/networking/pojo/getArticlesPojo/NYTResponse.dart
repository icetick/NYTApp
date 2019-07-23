import 'package:NYT/networking/pojo/getArticlesPojo/articleNYT.dart';

class NYTResponse {
  final List<ArticleNYT> articles;
  final Meta meta;
  NYTResponse({this.articles, this.meta});
  factory NYTResponse.fromJson(Map<String, dynamic> json) {
    var ticles = new List<ArticleNYT>();
    json['docs'].forEach((v) {
      ticles.add(ArticleNYT.fromJson(v));
    });
    var meta = Meta.fromJson(json['meta']);
    return NYTResponse(
        articles: ticles,
        meta: meta
    );
  }
}

class Meta {
  final int hits;
  Meta({this.hits});
  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
        hits: json['hits']
    );
  }
}