import 'package:NYT/pojo/getArticlesPojo/byline.dart';
import 'package:NYT/pojo/getArticlesPojo/headline.dart';
import 'package:NYT/pojo/getArticlesPojo/keywords.dart';
import 'package:NYT/pojo/getArticlesPojo/multimedia.dart';

class ArticleNYT {
  String webUrl;
  String snippet;
  String leadParagraph;
  String abstract;
  String printPage;
  List<String> blog;
  String source;
  List<Multimedia> multimedia;
  Headline headline;
  List<Keywords> keywords;
  String pubDate;
  String documentType;
  String newsDesk;
  String sectionName;
  Byline byline;
  String typeOfMaterial;
  String sId;
  int wordCount;
  String uri;

  ArticleNYT(
      {this.webUrl,
        this.snippet,
        this.leadParagraph,
        this.abstract,
        this.printPage,
        this.blog,
        this.source,
        this.multimedia,
        this.headline,
        this.keywords,
        this.pubDate,
        this.documentType,
        this.newsDesk,
        this.sectionName,
        this.byline,
        this.typeOfMaterial,
        this.sId,
        this.wordCount,
        this.uri});

  ArticleNYT.fromJson(Map<String, dynamic> json) {
    webUrl = json['web_url'];
    snippet = json['snippet'];
    leadParagraph = json['lead_paragraph'];
    abstract = json['abstract'];
    printPage = json['print_page'];
    if (json['blog'] != null) {
      /* blog = new List<Null>();
      json['blog'].forEach((v) {
        blog.add(new String.fromJson(v));
      });*/
    }
    source = json['source'];
    if (json['multimedia'] != null) {
      multimedia = new List<Multimedia>();
      json['multimedia'].forEach((v) {
        multimedia.add(new Multimedia.fromJson(v));
      });
    }
    headline = json['headline'] != null
        ? new Headline.fromJson(json['headline'])
        : null;
    if (json['keywords'] != null) {
      keywords = new List<Keywords>();
      json['keywords'].forEach((v) {
        keywords.add(new Keywords.fromJson(v));
      });
    }
    pubDate = json['pub_date'];
    documentType = json['document_type'];
    newsDesk = json['news_desk'];
    sectionName = json['section_name'];
    byline =
    json['byline'] != null ? new Byline.fromJson(json['byline']) : null;
    typeOfMaterial = json['type_of_material'];
    sId = json['_id'];
    wordCount = json['word_count'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['web_url'] = this.webUrl;
    data['snippet'] = this.snippet;
    data['lead_paragraph'] = this.leadParagraph;
    data['abstract'] = this.abstract;
    data['print_page'] = this.printPage;
    if (this.blog != null) {
      data['blog'] = this.blog.map((v) => v).toList();
    }
    data['source'] = this.source;
    if (this.multimedia != null) {
      data['multimedia'] = this.multimedia.map((v) => v.toJson()).toList();
    }
    if (this.headline != null) {
      data['headline'] = this.headline.toJson();
    }
    if (this.keywords != null) {
      data['keywords'] = this.keywords.map((v) => v.toJson()).toList();
    }
    data['pub_date'] = this.pubDate;
    data['document_type'] = this.documentType;
    data['news_desk'] = this.newsDesk;
    data['section_name'] = this.sectionName;
    if (this.byline != null) {
      data['byline'] = this.byline.toJson();
    }
    data['type_of_material'] = this.typeOfMaterial;
    data['_id'] = this.sId;
    data['word_count'] = this.wordCount;
    data['uri'] = this.uri;
    return data;
  }
}