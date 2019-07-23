class Person {
  String firstname;
  String middlename;
  String lastname;
  String qualifier;
  String title;
  String role;
  String organization;
  int rank;

  Person(
      {this.firstname,
        this.middlename,
        this.lastname,
        this.qualifier,
        this.title,
        this.role,
        this.organization,
        this.rank});

  Person.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    qualifier = json['qualifier'];
    title = json['title'];
    role = json['role'];
    organization = json['organization'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['qualifier'] = this.qualifier;
    data['title'] = this.title;
    data['role'] = this.role;
    data['organization'] = this.organization;
    data['rank'] = this.rank;
    return data;
  }
}