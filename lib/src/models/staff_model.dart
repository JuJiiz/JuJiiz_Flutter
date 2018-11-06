class StaffModel {
  String uid, email;
  bool allowed;
  int register_date;

  StaffModel({this.uid, this.email, this.allowed, this.register_date});

  StaffModel.from(Map<dynamic, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    allowed = json['allowed'];
    register_date = json['register_date'];
  }

  toJson() {
    return {
      "uid": uid,
      "email": email,
      "allowed": allowed,
      "register_date": register_date,
    };
  }
}
