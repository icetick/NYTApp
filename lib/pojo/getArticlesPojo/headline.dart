class Headline {
  String main;
  String kicker;
  String contentKicker;
  String printHeadline;
  String name;
  String seo;
  String sub;

  Headline(
      {this.main,
        this.kicker,
        this.contentKicker,
        this.printHeadline,
        this.name,
        this.seo,
        this.sub});

  Headline.fromJson(Map<String, dynamic> json) {
    main = json['main'];
    kicker = json['kicker'];
    contentKicker = json['content_kicker'];
    printHeadline = json['print_headline'];
    name = json['name'];
    seo = json['seo'];
    sub = json['sub'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['main'] = this.main;
    data['kicker'] = this.kicker;
    data['content_kicker'] = this.contentKicker;
    data['print_headline'] = this.printHeadline;
    data['name'] = this.name;
    data['seo'] = this.seo;
    data['sub'] = this.sub;
    return data;
  }
}