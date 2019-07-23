class Keywords {
  String name;
  String value;
  int rank;
  String major;

  Keywords({this.name, this.value, this.rank, this.major});

  Keywords.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    rank = json['rank'];
    major = json['major'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['value'] = this.value;
    data['rank'] = this.rank;
    data['major'] = this.major;
    return data;
  }
}