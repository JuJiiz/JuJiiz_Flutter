class UserModel {
  String app_version;
  String birth_date;
  String device;
  String display_name;
  String first_name;
  String gender;
  bool is_accept_term;
  bool is_user_check_info;
  int last_login;
  String last_name;
  String name_last_name;
  String os_version;
  String phone_number;
  String picture;
  int point;
  String referrer_link;
  String referrer_uid;
  int registered_date;
  String uid;

  UserModel(
      {this.app_version,
      this.birth_date,
      this.device,
      this.display_name,
      this.first_name,
      this.gender,
      this.is_accept_term,
      this.is_user_check_info,
      this.last_login,
      this.last_name,
      this.name_last_name,
      this.os_version,
      this.phone_number,
      this.picture,
      this.point,
      this.referrer_link,
      this.referrer_uid,
      this.registered_date,
      this.uid});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      app_version: data['app_version'] as String,
      birth_date: data['birth_date'] as String,
      device: data['device'] as String,
      display_name: data['display_name'] as String,
      first_name: data['first_name'] as String,
      gender: data['gender'] as String,
      is_accept_term: data['is_accept_term'] as bool,
      is_user_check_info: data['is_user_check_info'] as bool,
      last_login: data['last_login'] as int,
      last_name: data['last_name'] as String,
      name_last_name: data['name_last_name'] as String,
      os_version: data['os_version'] as String,
      phone_number: data['phone_number'] as String,
      picture: data['picture'] as String,
      point: data['point'] as int,
      referrer_link: data['referrer_link'] as String,
      referrer_uid: data['referrer_uid'] as String,
      registered_date: data['registered_date'] as int,
      uid: data['uid'] as String,
    );
  }

  toJson() {
    return {
      "app_version": app_version,
      "birth_date": birth_date,
      "device": device,
      "display_name": display_name,
      "first_name": first_name,
      "gender": gender,
      "is_accept_term": is_accept_term,
      "is_user_check_info": is_user_check_info,
      "last_login": last_login,
      "last_name": last_name,
      "name_last_name": name_last_name,
      "os_version": os_version,
      "phone_number": phone_number,
      "picture": picture,
      "point": point,
      "referrer_link": referrer_link,
      "referrer_uid": referrer_uid,
      "registered_date": registered_date,
      "uid": uid,
    };
  }
}
