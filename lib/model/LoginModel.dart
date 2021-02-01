class LoginModel {
  bool success;
  String token;
  Session session;

  LoginModel({this.success, this.token, this.session});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    session =
        json['session'] != null ? new Session.fromJson(json['session']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    if (this.session != null) {
      data['session'] = this.session.toJson();
    }
    return data;
  }
}

class Session {
  int roleId;
  String completeName;
  String roleName;
  int customerId;
  int userTip;
  int userRoleId;
  String userName;
  String locale;
  int userId;

  Session(
      {this.roleId,
      this.completeName,
      this.roleName,
      this.customerId,
      this.userTip,
      this.userRoleId,
      this.userName,
      this.locale,
      this.userId});

  Session.fromJson(Map<String, dynamic> json) {
    roleId = json['roleId'];
    completeName = json['completeName'];
    roleName = json['roleName'];
    customerId = json['customerId'];
    userTip = json['userTip'];
    userRoleId = json['userRoleId'];
    userName = json['userName'];
    locale = json['locale'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleId'] = this.roleId;
    data['completeName'] = this.completeName;
    data['roleName'] = this.roleName;
    data['customerId'] = this.customerId;
    data['userTip'] = this.userTip;
    data['userRoleId'] = this.userRoleId;
    data['userName'] = this.userName;
    data['locale'] = this.locale;
    data['userId'] = this.userId;
    return data;
  }
}
