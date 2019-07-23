class Legacy {
  String xlarge;
  int xlargewidth;
  int xlargeheight;

  Legacy({this.xlarge, this.xlargewidth, this.xlargeheight});

  Legacy.fromJson(Map<String, dynamic> json) {
    xlarge = json['xlarge'];
    xlargewidth = json['xlargewidth'];
    xlargeheight = json['xlargeheight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xlarge'] = this.xlarge;
    data['xlargewidth'] = this.xlargewidth;
    data['xlargeheight'] = this.xlargeheight;
    return data;
  }
}