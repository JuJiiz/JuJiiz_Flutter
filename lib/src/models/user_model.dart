class UserModel {
  String uid, email;
  bool allowed;
  int register_date;

  UserModel({this.uid, this.email, this.allowed, this.register_date});

  UserModel.from(Map<dynamic, dynamic> json) {
    uid = json['uid'] as String;
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
